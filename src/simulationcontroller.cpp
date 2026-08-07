#include "simulationcontroller.h"
#include "mainmodel.h"

SimulationController::SimulationController(QObject *parent) : QObject(parent)
{
    timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(onTimerTimeout()));
}

void SimulationController::onTimerTimeout() {
    driveState.onUpdate(500 * m_timeScale);
    MainModel::instance()->setSimulationTime(driveState.getStateTime());
}

void SimulationController::toggleSpeedUp()
{
    m_timeScale = (m_timeScale == 1) ? 20 : 1;
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
