import QtQuick 2.12
import Style 1.0
import MediaPlayerModel 1.0
Row {
    signal clicked(int index);
    property int currentIndex;
    id: menu;
    Repeater {
        model: ListModel {
            ListElement { text: "Play"; image: "qrc:/images/menu/play.png"}
            ListElement { text: "Navi"; image: "qrc:/images/menu/navi.png"}
            ListElement { text: "Phone"; image: "qrc:/images/menu/phone.png"}
            ListElement { text: "Setup"; image: "qrc:/images/menu/setup.png"}
        }
        delegate: Item {
            width: 47;
            height: 38;
            property bool active: index == currentIndex;
            Image {
                source:index === 0 ?(MediaPlayerModel.mediaPlayback ? "qrc:/images/menu/pause.png" : "qrc:/images/menu/play.png"):model.image;
                anchors.horizontalCenter: parent.horizontalCenter;
                opacity: parent.active ? 1.0 : 0.15;
                Behavior on opacity { NumberAnimation { duration: 300; } }
            }
            Text {
                text: index === 0 ?(MediaPlayerModel.mediaPlayback ? "Pause" : "Play"):model.text;
                anchors.bottom: parent.bottom;
                anchors.horizontalCenter: parent.horizontalCenter;
                opacity: parent.active ? 1 : 0;
                Behavior on opacity { NumberAnimation { duration: 400; easing.type: Easing.InCubic } }
                font.pixelSize: 12;
                font.family: "Microsoft YaHei UI";
                color: Style.lightPeriwinkle;
            }
        }
    }
}
