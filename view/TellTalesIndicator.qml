import QtQuick 2.12
import Style 1.0
import TellTalesModel 1.0

Item {
    id: indicator
    height: 28;
    width: image.width + 15;

    property alias source: image.source; //显示哪张图标
    property bool active: false;         //亮还是灭
    property color activeColor: Style.highlighterGreen     //亮时颜色
    property color inactiveColor: Style.darkBlue;       //灭时颜色
    property real indicatorOpacity:1;   //透明度
    property bool blinking: false;   //要不要闪
    property bool blinkVisible:false;

    Image {
        id: image;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.verticalCenter: parent.verticalCenter;
        opacity: active && (!blinking || blinkVisible) ? indicatorOpacity : 0;

        Behavior on opacity { NumberAnimation {
            easing.type: Easing.InOutQuad;
            duration: TellTalesModel.opacityChangeDuration;
        }}
    }

    // SequentialAnimation {
    //     id: indicatorBlinkAnimation
    //     loops: Animation.Infinite
    //     alwaysRunToEnd: true

    //     ScriptAction {
    //         script: indicator.active = true;
    //     }

    //     PauseAnimation {
    //         duration: 600
    //     }

    //     ScriptAction {
    //         script: indicator.active = false;
    //     }

    //     PauseAnimation {
    //         duration: 400
    //     }
    // }
}
