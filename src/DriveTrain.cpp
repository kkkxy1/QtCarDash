/******************************************************************************
**
** Copyright (C) 2020 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Qt Quick Ultralite module.
**
** $QT_BEGIN_LICENSE:COMM$
**
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see http://www.qt.io/terms-conditions. For further
** information use the contact form at http://www.qt.io/contact-us.
**
** $QT_END_LICENSE$
**
******************************************************************************/
#include "DriveTrain.h"
#include <assert.h>
#include <algorithm>
#include <cmath>
#include "mainmodel.h"
// #include <cstdlib>

namespace {
const float cmPerMinuteToKmhRatio = 0.0006;
const uint32_t crusingDownshiftDelay = 1500;
} // namespace

Drivetrain::Drivetrain(QObject *parent)
    : QObject(parent)
{
    assert(_config.gearNum <= Config::MAX_GEARS);
    reset();
}

// void Drivetrain::clampSpeed(float maxSpeed)
// {
//     if(_data.speed>maxSpeed){
//         _data.speed=maxSpeed;
//         _data.rpm=getRpm(_data.speed,_data.gear);
//         updateModel();
//     }
// }

void Drivetrain::update(uint32_t tick, float acceleration)
{
    const float prevRpm = updateRpm(tick, acceleration);
    updateGearShift(tick, prevRpm, acceleration);
    updateSpeed();
    applySpeedLimit();
    updateOdo(tick);
    updateRange();
    updateBattery(tick, acceleration);
    updateFuelLevel(tick);
    updateCoolantTemp(tick, acceleration);
    updateModel();
}

void Drivetrain::applySpeedLimit()
{
    if (_data.speed > _config.maxSpeed) {
        _data.speed = _config.maxSpeed;
        _data.rpm = getRpm(_data.speed, _data.gear);
    }
}

void Drivetrain::udpateCruiseControll(uint32_t tick, float targetSpeed)
{
    const float maxSpeed = _config.maxSpeed;
    targetSpeed = std::min(targetSpeed, maxSpeed);

    float acceleration = 0;
    if ((int) targetSpeed != (int) _data.speed) {
        const int dir = targetSpeed - _data.speed > 0 ? 1 : -1;
        const float speedFactor = std::abs(targetSpeed - _data.speed) / _config.maxSpeed;
        if (dir > 0) {
            acceleration = 0.1f + std::sqrt(std::min(std::max(speedFactor * 2, 0.f), 1.f)) * 1.5f;
        } else {
            acceleration = -(0.05f + std::min(std::max(speedFactor * 4, 0.f), 1.f) * 0.95f);
        }
    }
    update(tick, acceleration);
}

float Drivetrain::updateRpm(uint32_t tick, float acceleration)
{
    const float currentRatio = (_config.gearRatios[_data.gear]);
    const float speedFactor = _data.speed / _config.maxSpeed;
    const float accVariation = acceleration > 0 ? 0.02f + (1 - speedFactor) * 0.98f
                                                : 2 * (0.2 + speedFactor * speedFactor * speedFactor * 0.8f);

    const float prevValue = _data.rpm;
    _data.rpm += 2 * tick * acceleration * currentRatio * accVariation;
    const float minRpm = (_data.fuel <= 0.f) ? 0.f : _config.minRpm;
    _data.rpm = std::min(std::max(_data.rpm, minRpm), _config.maxRpm);
    return prevValue;
}

void Drivetrain::updateGearShift(uint32_t tick, float prevRpm, float acceleration)
{
    const float shiftUpAtRpm = acceleration > 0.25f
                                   ? _config.shiftUpAtRpm
                                   : _config.shiftDownAtRpm + (_config.shiftUpAtRpm - _config.shiftDownAtRpm) * 0.5f;
    if (_data.rpm >= shiftUpAtRpm && _data.gear < (_config.gearNum - 1)) {
        shiftGear(1);
    } else if (_data.rpm <= _config.shiftDownAtRpm && _data.gear > 0) {
        shiftGear(-1);
    } else if (std::abs((int) prevRpm - (int) _data.rpm) < 10) {
        _constSpeedTime += tick;
        if (_constSpeedTime > crusingDownshiftDelay && _data.gear < (_config.gearNum - 1)) {
            // Consider shifting up while crusing
            const float possibleRpm = getRpm(_data.speed, _data.gear + 1);
            if (possibleRpm > _config.shiftDownAtRpm) {
                shiftGear(1);
            }
            _constSpeedTime = 0;
        }
    } else {
        _constSpeedTime = 0;
    }
}

void Drivetrain::shiftGear(int delta)
{
    _data.gear += delta;
    assert(_data.gear >= 0 && _data.gear < _config.gearNum);
    _data.rpm = getRpm(_data.speed, _data.gear);
}

void Drivetrain::updateSpeed()
{
    _data.speed = getSpeed(_data.rpm, _data.gear);    
}

void Drivetrain::updateOdo(uint32_t tick)
{
    _data.odo += _data.speed * tick / 3600000.f;
}

void Drivetrain::updateRange()
{
    // 续航由油量决定（在 updateFuelLevel 中同步更新）
    _data.range = _data.fuel * _config.maxRange;
}

void Drivetrain::updateBattery(uint32_t tick, float acceleration)
{
    Q_UNUSED(tick)
    Q_UNUSED(acceleration)
    // 电池消耗由混动逻辑管理（见 updateFuelLevel）：油尽后按时间消耗
}

void Drivetrain::updateFuelLevel(uint32_t tick)
{
    // 混动策略：先耗油，油尽后耗电
    // 油量从 3/4 开始，40 分钟耗尽；电量从 3/4 开始，油尽后 30 分钟耗尽
    if (_data.fuel > 0.f) {
        _data.fuel = std::max(0.f, _data.fuel - 0.75f * tick / (40.f * 60.f * 1000.f));
    } else {
        _data.battery = std::max(0.f, _data.battery - 0.75f * tick / (30.f * 60.f * 1000.f));
    }
    // 续航与油量同步下降
    _data.range = _data.fuel * _config.maxRange;
}

void Drivetrain::updateCoolantTemp(uint32_t tick, float acceleration)
{
    if (_data.coolantTemp < _config.optimalTemp
        || (_data.rpm > _config.maxRpm * 0.75f && _data.coolantTemp < _config.maxTemp)) {
        const float accHeatFactor = acceleration > 0 ? (0.1f + acceleration * 0.2f) : 0.1f;
        _data.coolantTemp += _config.maxTemp * tick * _config.coolantHeatRatio * accHeatFactor;
    } else if (_data.coolantTemp > _config.optimalTemp) {
        const float rpmCoolFactor = acceleration <= 0.15 ? 1 - _data.rpm / _config.maxRpm : 0;
        _data.coolantTemp -= _config.maxTemp * tick * _config.coolantCooldownRatio * rpmCoolFactor;
    }
}

void Drivetrain::reset()
{
    _data.speed = 0;
    _data.rpm = 0;
    _data.gear = 0;
    _data.coolantTemp = 0;
    _data.fuel = 0.75f;      // 混动初始：3/4 油
    resetOdo();
    resetBattery(1.0f);     // 混动初始：3/4 电
}

void Drivetrain::resetOdo(float value)
{
    _data.odo = value;
}

void Drivetrain::resetBattery(float value)
{
    _data.battery = value;
}

float Drivetrain::getSpeed(float rpm, int gear) const
{
    if (gear < 0 || gear >= _config.gearNum) {
        assert(!"Wrong gear!");
        return 0;
    }
    return (_config.tireCircumference * rpm) / (_config.gearRatios[gear] * _config.diffRatio) * cmPerMinuteToKmhRatio;
}

float Drivetrain::getRpm(float speed, int gear) const
{
    if (gear < 0 || gear >= _config.gearNum) {
        assert(!"Wrong gear!");
        return 0;
    }
    return (speed * _config.gearRatios[gear] * _config.diffRatio) / (_config.tireCircumference * cmPerMinuteToKmhRatio);
}

void Drivetrain::updateModel()
{
    const DriveData &data = getDriveData();
    MainModel* mainModel = MainModel::instance();
    mainModel->update(data);
}
