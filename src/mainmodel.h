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

public:
    static MainModel* instance();
    float speed() const;
    float rpm() const;
    float odo() const;
    float range() const;
    void setSpeed(float newValue);
    void setRPM(float newValue);
    void setOdo(float newValue);
    void setRange(float newValue);
    void update(const Drivetrain::DriveData &data);

signals:
    void modelUpdated();
    void speedChanged();
    void rpmChanged();
    void odoChanged();
    void rangeChanged();

private:
    explicit MainModel(QObject* parent = nullptr);
    float m_speed;
    float m_rpm;
    float m_odo;
    float m_range;
};

#endif // MAINMODEL_H
