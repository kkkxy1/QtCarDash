#ifndef MAINMODEL_H
#define MAINMODEL_H

#include <QObject>
#include "DriveTrain.h"

class MainModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(float speed READ speed NOTIFY speedChanged)
    Q_PROPERTY(float rpm READ rpm NOTIFY rpmChanged)
    Q_PROPERTY(float odo READ odo NOTIFY odoChanged)
    Q_PROPERTY(float range READ range NOTIFY rangeChanged)
    Q_PROPERTY(float coolantTemp READ coolantTemp NOTIFY coolantTempChanged)
    Q_PROPERTY(float fuelLevel READ fuelLevel NOTIFY fuelLevelChanged)
    Q_PROPERTY(float batteryLevel READ batteryLevel NOTIFY batteryLevelChanged)
    Q_PROPERTY(int simulationTime READ simulationTime NOTIFY simulationTimeChanged)

public:
    static MainModel* instance();
    float speed() const;
    float rpm() const;
    float odo() const;
    float range() const;
    float coolantTemp() const;
    float fuelLevel() const;
    float batteryLevel() const;
    int simulationTime() const;
    void setSimulationTime(int newValue);
    void setSpeed(float newValue);
    void setRPM(float newValue);
    void setOdo(float newValue);
    void setRange(float newValue);
    void setCoolantTemp(float newValue);
    void setFuelLevel(float newValue);
    void setBatteryLevel(float newValue);
    void update(const Drivetrain::DriveData &data);

signals:
    void modelUpdated();
    void speedChanged();
    void rpmChanged();
    void odoChanged();
    void rangeChanged();
    void coolantTempChanged();
    void fuelLevelChanged();
    void batteryLevelChanged();
    void simulationTimeChanged();

private:
    explicit MainModel(QObject* parent = nullptr);
    float m_speed;
    float m_rpm;
    float m_odo;
    float m_range;
    float m_coolantTemp;
    float m_fuelLevel;
    float m_batteryLevel;
    int m_simulationTime = 0;
};

#endif // MAINMODEL_H
