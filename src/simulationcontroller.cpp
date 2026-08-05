#include "simulationcontroller.h"

SimulationController::SimulationController(QObject *parent) : QObject(parent)
{
    timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(onTimerTimeout()));
}

void SimulationController::onTimerTimeout() {
    driveState.onUpdate(500 * m_timeScale);
}

void SimulationController::toggleSpeedUp()
{
    m_timeScale = (m_timeScale == 1) ? 10 : 1;
    emit timeScaleChanged();
}

void SimulationController::start()
{
    timer->start(500);
}

void SimulationController::stop()
{
    timer->stop();
}
