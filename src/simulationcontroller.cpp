#include "simulationcontroller.h"
#include "mainmodel.h"

SimulationController::SimulationController(QObject *parent) : QObject(parent)
{
    timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(onTimerTimeout()));
}

void SimulationController::onTimerTimeout() {

    if(m_targetSpeed>0){
        driveState.drivetrain.udpateCruiseControll(500,m_targetSpeed);
    }else{
        driveState.onUpdate(500 );
    }
    static uint64_t simTime = 0;
    simTime += 500 * m_timeScale;
    MainModel::instance()->setSimulationTime(simTime);
}

void SimulationController::toggleSpeedUp()
{
    m_timeScale = (m_timeScale == 1) ? 20 : 1;
    emit timeScaleChanged();
}

void SimulationController::accelerate(){
    if(m_targetSpeed==0){
        m_targetSpeed=qMin((int)driveState.drivetrain.getDriveData().speed+m_targetSpeed+10,200);
    }else{
        m_targetSpeed=qMin(m_targetSpeed+10,200);
    }
    emit targetSpeedChanged();
}

void SimulationController::decelerate(){
    if(m_targetSpeed==0){
        m_targetSpeed=qMax((int)driveState.drivetrain.getDriveData().speed-10,0);
    }else{
        m_targetSpeed=qMax(m_targetSpeed-10,0);
    }

    emit targetSpeedChanged();
}

void SimulationController::start()
{
    timer->start(500);
}

void SimulationController::stop()
{
    timer->stop();
}
