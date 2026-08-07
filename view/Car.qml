import QtQuick 2.12
import TellTalesModel 1.0

Item {
    Image {
        id: bg
        anchors { bottom: parent.bottom; horizontalCenter: parent.horizontalCenter; }
        source: "qrc:/images/bg-mask.png"

        transform: Scale {
            origin.x: bg.implicitWidth / 2
            origin.y: bg.implicitHeight
        }
    }

    Image {
        id: highlights
        anchors { bottom: parent.bottom; horizontalCenter: parent.horizontalCenter; }
        source: "qrc:/images/lights/car-highlights.png"
        // visible:false

        transform: Scale {
            origin.x: highlights.implicitWidth / 2
            origin.y: highlights.implicitHeight
        }
    }

    Image {
        id:leftTurnLight
        anchors { bottom: parent.bottom; horizontalCenter: parent.horizontalCenter;}
        source: "qrc:/images/lights/car-turnleft.png"
        visible: TellTalesModel.turnLeftActive
        opacity: TellTalesModel.turnLeftVisible ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: 100 } }

        transform: Scale {
                origin.x: leftTurnLight.implicitWidth / 2
                origin.y: leftTurnLight.implicitHeight
            }

    }

    Image {
        id:rightTurnLight
        anchors { bottom: parent.bottom; horizontalCenter: parent.horizontalCenter;}
        source: "qrc:/images/lights/car-turnright.png"
        visible: TellTalesModel.turnRightActive
        opacity: TellTalesModel.turnRightVisible ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: 100 } }

        transform: Scale {
                origin.x: rightTurnLight.implicitWidth / 2
                origin.y: rightTurnLight.implicitHeight
            }

    }
}
