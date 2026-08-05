#include "mainmodel.h"

MainModel::MainModel(QObject* parent) : QObject(parent) {}

MainModel* MainModel::instance()
{
    static MainModel* s_instance = nullptr;
    if (!s_instance)
        s_instance = new MainModel();
    return s_instance;
}

float MainModel::speed() const
{
    return m_speed;
}

float MainModel::rpm() const
{
    return m_rpm;
}

float MainModel::odo() const
{
    return m_odo;
}

float MainModel::range() const
{
    return m_range;
}

float MainModel::coolantTemp() const
{
    return m_coolantTemp;
}

float MainModel::fuelLevel() const
{
    return m_fuelLevel;
}

float MainModel::batteryLevel() const
{
    return m_batteryLevel;
}

void MainModel::setSpeed(float newValue) {
    if (m_speed != newValue) {
        m_speed = newValue;
        emit speedChanged();
    }
}

void MainModel::setRPM(float newValue) {
    if (m_rpm != newValue) {
        m_rpm = newValue;
        emit rpmChanged();
    }
}

void MainModel::setOdo(float newValue) {
    if (m_odo != newValue) {
        m_odo = newValue;
        emit odoChanged();
    }
}

void MainModel::setRange(float newValue) {
    if (m_range != newValue) {
        m_range = newValue;
        emit rangeChanged();
    }
}

void MainModel::setCoolantTemp(float newValue) {
    if (m_coolantTemp != newValue) {
        m_coolantTemp = newValue;
        emit coolantTempChanged();
    }
}

void MainModel::setFuelLevel(float newValue) {
    if (m_fuelLevel != newValue) {
        m_fuelLevel = newValue;
        emit fuelLevelChanged();
    }
}

void MainModel::setBatteryLevel(float newValue) {
    if (m_batteryLevel != newValue) {
        m_batteryLevel = newValue;
        emit batteryLevelChanged();
    }
}

void MainModel::update(const Drivetrain::DriveData &data) {
    setRPM(data.rpm);
    setSpeed(data.speed);
    setOdo(data.odo);
    setRange(data.range);
    setCoolantTemp(data.coolantTemp);
    setFuelLevel(data.fuel);
    setBatteryLevel(data.battery);
    emit modelUpdated();
}
