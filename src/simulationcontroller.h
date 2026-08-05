#ifndef SIMULATIONCONTROLLER_H
#define SIMULATIONCONTROLLER_H

#include <QObject>
#include "DriveState.h"
#include <QTimer>

struct SimulationController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int timeScale READ timeScale NOTIFY timeScaleChanged)
public:
    explicit SimulationController(QObject *parent = nullptr);

    int timeScale() const { return m_timeScale; }

public slots:
    void start();
    void stop();
    void onTimerTimeout();
    void toggleSpeedUp();

signals:
    void timeScaleChanged();

private:
    void randomizeAccChange();
    DriveState driveState;
    QTimer *timer;
    int m_timeScale = 1;   // 1 = 实时，8 = 8 倍速模拟
};

#endif // SIMULATIONCONTROLLER_H
