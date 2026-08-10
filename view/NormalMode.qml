import QtQuick 2.12
import NormalModeModel 1.0
import Style 1.0
import MainModel 1.0
import Units 1.0
import MediaPlayerModel 1.0

Item {
    id: root;
    property real scale: 1.0
    property int menu: NormalModeModel.menu;

    Image {
        id: topLine;
        source: "qrc:/images/top-line.png";
        anchors.horizontalCenter: parent.horizontalCenter;
        y: 62;
    }

    LaneAssist {
        anchors.fill: parent
        scale: root.scale
    }

    Item {
        id: mainElement;
        anchors.fill: parent

        MediaPlayer {
                activeMode: active;
                selected: true;
                anchors.fill: parent;
                visible: menu == NormalModeModel.MediaPlayerMenu;
            }

        Item {
            anchors.fill: parent;
            visible: menu == NormalModeModel.NavigationMenu;
            Text {
                anchors.horizontalCenter: parent.horizontalCenter;
                y: 77
                text: "导航"
                font.bold: true
                font.pixelSize: 16
                font.family: "Microsoft YaHei UI"
                color: Style.lightPeriwinkle
            }
            Image {
                x: (parent.width - width) / 2;
                y: 121;
                source: "qrc:/images/menu/navigation.png";
            }
        }

        Item{
            anchors.fill: parent;
            visible: menu == NormalModeModel.PhoneMenu;
            Text {
                anchors.horizontalCenter: parent.horizontalCenter;
                y: 77
                text: "电话"
                font.bold: true
                font.pixelSize: 16
                font.family: "Microsoft YaHei UI"
                color: Style.lightPeriwinkle
            }
            Image {
                x: (parent.width - width) / 2;
                y: 121;
                source: "qrc:/images/menu/phone-call.png";
            }
        }

        Item{
            anchors.fill: parent;
            visible: menu == NormalModeModel.CarStatusMenu;
            Column {
                visible: NormalModeModel.setupIndex == -1;
                opacity: 1;
                anchors.horizontalCenter: parent.horizontalCenter;
                spacing: 8;
                y:77;
                Text {
                    x:30;
                    text: "设置"
                    font.bold: true
                    font.pixelSize: 16
                    font.family: "Microsoft YaHei UI"
                    color: Style.lightPeriwinkle
                }

                Row {
                    spacing: 4;
                    Text {
                        text: "▶";
                        color: 0==NormalModeModel.setupSelect ? Style.orange : "transparent";
                        width: 16;
                        font.pixelSize: 16; }
                    Text {
                        text: "胎压监测";
                        color: 0==NormalModeModel.setupSelect ? Style.orange : Style.lightPeriwinkle;
                        font.pixelSize: 16;
                        font.family: "Microsoft YaHei UI"; }
                }

                Row {
                    spacing: 4;
                    Text {
                        text: "▶";
                        color: 1==NormalModeModel.setupSelect ? Style.orange : "transparent";
                        width: 16;
                        font.pixelSize: 16; }
                    Text {
                        text: "续航里程";
                        color: 1==NormalModeModel.setupSelect ? Style.orange : Style.lightPeriwinkle;
                        font.pixelSize: 16;
                        font.family: "Microsoft YaHei UI"; }
                }

                Row { spacing: 4;
                    Text {
                        text: "▶";
                        color: 2==NormalModeModel.setupSelect ? Style.orange : "transparent";
                        width: 16;
                        font.pixelSize: 16; }
                    Text {
                        text: "水温状态";
                        color: 2==NormalModeModel.setupSelect ? Style.orange : Style.lightPeriwinkle;
                        font.pixelSize: 16;
                        font.family: "Microsoft YaHei UI"; }
                }

                Row {
                    spacing: 4;
                    Text {
                        text: "▶";
                        color: 3==NormalModeModel.setupSelect ? Style.orange : "transparent";
                        width: 16;
                        font.pixelSize: 16; }
                    Text {
                        text: "音量调节";
                        color: 3==NormalModeModel.setupSelect ? Style.orange : Style.lightPeriwinkle;
                        font.pixelSize: 16;
                        font.family: "Microsoft YaHei UI"; }
                }

                Row {
                    spacing: 4;
                    Text {
                        text: "▶";
                        color: 4==NormalModeModel.setupSelect ? Style.orange : "transparent";
                        width: 16;
                        font.pixelSize: 16; }
                    Text {
                        text: "屏幕亮度";
                        color: 4==NormalModeModel.setupSelect ? Style.orange : Style.lightPeriwinkle;
                        font.pixelSize: 16;
                        font.family: "Microsoft YaHei UI"; }
                }

            }


            Column {
                visible: NormalModeModel.setupIndex ==0;
                anchors.horizontalCenter: parent.horizontalCenter;
                spacing: 6;
                y:90;
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter;
                    text: "胎压监测";
                    font.bold: true;
                    font.pixelSize: 18
                    font.family: "Microsoft YaHei UI";
                    color: Style.lightPeriwinkle;
                }
                Text { text: "左前: 2.4 bar"; font.pixelSize: 14; font.family: "Microsoft YaHei UI"; color: Style.lightPeriwinkle; }
                Text { text: "右前: 2.4 bar"; font.pixelSize: 14; font.family: "Microsoft YaHei UI"; color: Style.lightPeriwinkle; }
                Text { text: "左后: 2.3 bar"; font.pixelSize: 14; font.family: "Microsoft YaHei UI"; color: Style.lightPeriwinkle; }
                Text { text: "右后: 2.3 bar"; font.pixelSize: 14; font.family: "Microsoft YaHei UI"; color: Style.lightPeriwinkle; }
            }

            Text {
                visible: NormalModeModel.setupIndex == 1;
                anchors.horizontalCenter: parent.horizontalCenter;
                y:90;
                text: "续航里程";
                font.bold: true;
                font.pixelSize: 18
                font.family: "Microsoft YaHei UI";
                color: Style.lightPeriwinkle;
            }
            Column {
                visible: NormalModeModel.setupIndex ==1;
                anchors.horizontalCenter: parent.horizontalCenter;
                spacing: 8;
                y:150;
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter;
                    spacing: 15;
                    Text {
                        text: "已跑";
                        font.pixelSize: 14;
                        font.family: "Microsoft YaHei UI";
                        color: Style.lightPeriwinkle;
                        opacity: 0.7;
                    }
                    Text {
                        text: MainModel.odo + " km";
                        font.pixelSize: 14;
                        font.family: "Microsoft YaHei UI";
                        color: Style.highlighterGreen;
                    }
                }
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter;
                    spacing: 15;
                    Text {
                        text: "剩余";
                        font.pixelSize: 14;
                        font.family: "Microsoft YaHei UI";
                        color: Style.lightPeriwinkle;
                        opacity: 0.7;
                    }
                    Text {
                        text: MainModel.range + " km";
                        font.pixelSize: 14;
                        font.family: "Microsoft YaHei UI";
                        color: Style.highlighterGreen;
                    }
                }

            }

            Text {
                visible: NormalModeModel.setupIndex == 2;
                anchors.horizontalCenter: parent.horizontalCenter;
                y:90;
                text: "水温状态";
                font.bold: true;
                font.pixelSize: 18
                font.family: "Microsoft YaHei UI";
                color: Style.lightPeriwinkle;
            }

            Column {
                visible: NormalModeModel.setupIndex == 2;
                anchors.horizontalCenter: parent.horizontalCenter;
                spacing: 8;
                y: 150;
                Row{
                    anchors.horizontalCenter: parent.horizontalCenter;
                    spacing: 15;
                    Text{
                        text: "当前水温";
                        font.pixelSize: 14
                        color: Style.lightPeriwinkle;
                        opacity: 0.7;
                    }
                    Text{
                        text: MainModel.temp.toFixed(1) + "°C";
                        font.pixelSize: 14
                        color: Style.highlighterGreen;

                    }
                }

            }

            Text {
                visible: NormalModeModel.setupIndex == 3;
                anchors.horizontalCenter: parent.horizontalCenter;
                y:90;
                text: "音量调节";
                font.bold: true;
                font.pixelSize: 18
                font.family: "Microsoft YaHei UI";
                color: Style.lightPeriwinkle;
            }

            Column {
                visible: NormalModeModel.setupIndex == 3;
                anchors.horizontalCenter: parent.horizontalCenter;
                spacing: 8;
                y: 130;
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter;
                    spacing: 8;
                    Item { width: 24; height: 1; }
                    Text {
                        text: "当前音量";
                        font.pixelSize:14
                        color: Style.lightPeriwinkle;
                        opacity: 0.7;
                    }
                    Text {
                        text: MediaPlayerModel.volume + "/20";
                    }
                }
                Row {
                    Text {
                        text: "- ";
                        font.pixelSize: 18;
                        font.family: "Microsoft YaHei UI";
                        color: Style.lightPeriwinkle;
                        anchors.verticalCenter: parent.verticalCenter;
                    }
                    Item {
                        width: 150; height: 20;
                        Rectangle {
                            width: parent.width;
                            height: 12;
                            radius: 6;
                            y: 4;
                            color: "#003366";
                        }
                        Rectangle {
                            width: parent.width * MediaPlayerModel.volume / 20;
                            height: 12;
                            radius: 6;
                            y: 4;
                            color: Style.highlighterGreen;
                        }
                        Text {
                            anchors.centerIn: parent;
                            text: MediaPlayerModel.volume + "/20";
                            font.pixelSize: 10
                            color: "white";
                        }
                    }
                    Text {
                        text: "+";
                        font.pixelSize: 18;
                        font.family: "Microsoft YaHei UI";
                        color: Style.lightPeriwinkle;
                        anchors.verticalCenter: parent.verticalCenter;
                    }
                }
            }


            Text {
                visible: NormalModeModel.setupIndex == 4;
                anchors.horizontalCenter: parent.horizontalCenter;
                y:90;
                text: "亮度调节";
                font.bold: true;
                font.pixelSize: 18
                font.family: "Microsoft YaHei UI";
                color: Style.lightPeriwinkle;
            }

            Column {
                visible: NormalModeModel.setupIndex == 4;
                anchors.horizontalCenter: parent.horizontalCenter;
                spacing: 8;
                y: 130;
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter;
                    spacing: 8;
                    Item { width: 24; height: 1; }
                    Text {
                        text: "当前亮度";
                        font.pixelSize:14
                        color: Style.lightPeriwinkle;
                        opacity: 0.7;
                    }
                    Text {
                        text: NormalModeModel.brightness + "/20";
                    }
                }
                Row {
                    Text {
                        text: "- ";
                        font.pixelSize: 18;
                        font.family: "Microsoft YaHei UI";
                        color: Style.lightPeriwinkle;
                        anchors.verticalCenter: parent.verticalCenter;
                    }
                    Item {
                        width: 150; height: 20;
                        Rectangle {
                            width: parent.width;
                            height: 12;
                            radius: 6;
                            y: 4;
                            color: "#003366";
                        }
                        Rectangle {
                            width: parent.width * NormalModeModel.brightness / 20;
                            height: 12;
                            radius: 6;
                            y: 4;
                            color: Style.highlighterGreen;
                        }
                        Text {
                            anchors.centerIn: parent;
                            text: NormalModeModel.brightness + "/20";
                            font.pixelSize:10;
                            color: "white";
                        }
                    }
                    Text {
                        text: "+";
                        font.pixelSize: 18;
                        font.family: "Microsoft YaHei UI";
                        color: Style.lightPeriwinkle;
                        anchors.verticalCenter: parent.verticalCenter;
                    }
                }
            }


        }


            Text {
                visible: NormalModeModel.setupIndex != -1;
                anchors.horizontalCenter: parent.horizontalCenter;
                y: 220;
                text: "按 Esc 返回";
                font.pixelSize: 12
                color: Style.lightPeriwinkle;
                opacity: 0.5;
            }
        }



    Gauge {
        id: leftGauge;
        x: 20;
        y: 44;
        leftOrientation: true;
        value: Units.kilometersToLongDistanceUnit(MainModel.speed)
        maxValue: Units.maximumSpeed
        textLabel: Units.speedUnit
    }

    Gauge {
        id: rightGauge;
        x: root.width - rightGauge.width - 20;
        y: 44;
        leftOrientation: false;
        value: MainModel.rpm / 1000;
        valueText: MainModel.speed === 0 ? "P" : "D"
        maxValue: MainModel.maxRpm / 1000;
        maxAngle: 180
        textLabel: ""

        Text {
            id: rpmLabel
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: -35
            anchors.verticalCenterOffset: 100

            opacity: 0.2
            horizontalAlignment: Text.AlignRight
            text: "x1000\n    RPM"
            color: Style.lightPeriwinkle;
            font.pixelSize: 10
            font.family: "Microsoft YaHei UI"

            transform: Scale {
                origin.x: rightGauge.transformOriginX - rpmLabel.x
                origin.y: 340 - rpmLabel.y
                xScale: rightGauge.scale
                yScale: rightGauge.scale
            }
        }

    }

    Menu {
        id: normalMenu;
        opacity: topLine.opacity;
        anchors.horizontalCenter: parent.horizontalCenter;
        y: 293;
        currentIndex: menu;
        onClicked: menu = index;
    }
}
