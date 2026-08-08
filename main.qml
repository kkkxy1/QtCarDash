import QtQuick 2.12
import QtQuick.Window 2.12

import MainModel 1.0
import SimulationController 1.0
import MediaPlayerModel 1.0
import NormalModeModel 1.0
import TellTalesModel 1.0
import "view" as View

Window {
    id: window;
    width: 800;
    height: 480;
    visible: true
    title: qsTr("Instrument Cluster Demo")

    Rectangle {
        id: root;
        anchors.fill: parent;
        focus: true

        color: "#00091a"

        View.TellTales {
            anchors.horizontalCenter: parent.horizontalCenter;
            y:16;
        }

        View.Car {
            anchors.fill: parent;
        }

        View.NormalMode {
            id: normalMode;
            anchors.fill: parent;
        }

        View.StatusBar {
            anchors.fill: parent;
        }

        Text {
            anchors.top: parent.top;
            anchors.right: parent.right;
            anchors.topMargin: 8;
            anchors.rightMargin: 12;
            text: "模拟加速 x" + simulationController.timeScale;
            color: "#657080";
            font.pixelSize: 12;
            font.family: "Microsoft YaHei UI";
            visible: simulationController.timeScale > 1;
        }

        SimulationController {
            id: simulationController
        }

        Timer{
            id:blinkTimer
            interval: 500
            repeat: true
            running:TellTalesModel.turnLeftBlinking||TellTalesModel.turnRightBlinking

            onTriggered: {
                if(TellTalesModel.turnLeftBlinking){
                    TellTalesModel.turnLeftVisible=!TellTalesModel.turnLeftVisible;
                }
                if(TellTalesModel.turnRightBlinking){
                    TellTalesModel.turnRightVisible=!TellTalesModel.turnRightVisible;
                }
            }
        }

        function onKeyPressed(key : int) {
            if (key === Qt.Key_Right) {
                MediaPlayerModel.nextSong()
            } else if (key === Qt.Key_Left) {
                MediaPlayerModel.previousSong()
            } else if (key === Qt.Key_Space) {
                updateSimulationState()
            } else if (key === Qt.Key_X) {
                simulationController.toggleSpeedUp()
            } else if(key === Qt.Key_A){
                NormalModeModel.previousMenu();
            } else if(key === Qt.Key_D){
                 NormalModeModel.nextMenu();
            } else if(key === Qt.Key_Q){
                TellTalesModel.toggleLeftTurn();
            } else if(key === Qt.Key_E){
                TellTalesModel.toggleRightTurn();
            } else if(key === Qt.Key_W){
                simulationController.accelerate();
            } else if(key ===Qt.Key_S){
                simulationController.decelerate();
            } else if(key === Qt.Key_F){
                TellTalesModel.beamActive =! TellTalesModel.beamActive;
            } else if(key === Qt.Key_H){
                TellTalesModel.highBeamsActive =! TellTalesModel.highBeamsActive;
            }
        }



        function updateSimulationState() {
            if(MainModel.simulationRunning) {
                simulationController.stop()
            } else {
                simulationController.start()
            }
            MainModel.simulationRunning = !MainModel.simulationRunning;
        }

        Keys.onPressed: (event)=> { onKeyPressed(event.key) }

        Component.onCompleted: {
            updateSimulationState()
        }
    }
}
