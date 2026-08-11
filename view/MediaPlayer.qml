import QtQuick 2.12
import Style 1.0
import MediaPlayerModel 1.0
import MainModel 1.0
import QtMultimedia

NormalModeContentItem {
    Repeater {
        model: ListModel {
            // FIXME: https://bugreports.qt.io/browse/UL-597
            // Durations are used in MediaPlayerModel.qml
            ListElement {

                artist: "周杰伦";
                song: "半岛铁盒";
                cover: "qrc:/images/albums/cover1.png";
            }
            ListElement {
                artist: "周杰伦";
                song: "园游会";
                cover: "qrc:/images/albums/cover2.png";
            }
            ListElement {
                artist: "周杰伦";
                song: "美人鱼";
                cover: "qrc:/images/albums/cover3.png";
            }
            ListElement {
                artist: "周杰伦";
                song: "我不配";
                cover: "qrc:/images/albums/cover4.png";
            }
            ListElement {
                artist: "周杰伦";
                song: "大笨钟";
                cover: "qrc:/images/albums/cover5.png";
            }
        }

        Item {
            anchors.fill: parent
            property int pos: -(-(10 + index - MediaPlayerModel.track%5 + 2) % 5) - 2

            Text {
                id: songTxt
                anchors.horizontalCenter: parent.horizontalCenter;
                y: 77
                text: model.song
                font.bold: true
                font.pixelSize: 16
                font.family: "Microsoft YaHei UI"
                color: Style.lightPeriwinkle
                opacity: pos === 0 ? 1 : 0;
                Behavior on opacity { NumberAnimation{ duration: MediaPlayerModel.changeSongDuration } }
            }
            Text {
                id:artistTxt
                anchors.horizontalCenter: parent.horizontalCenter;
                y: 96
                text: model.artist;
                font.pixelSize: 12
                font.family: "Microsoft YaHei UI"
                color: Style.lightPeriwinkle
                opacity: artistTxt.opacity
            }

            Image {
                id: img
                x: (parent.width - width) / 2 + Math.max(Math.min(pos, 1), -1) * 49
                Behavior on x {
                    NumberAnimation{
                        duration: MediaPlayerModel.changeSongDuration
                        easing.type: pos === 1 ? Easing.OutQuad : Easing.OutCubic
                    }
                }
                opacity: pos === 0 ? 1 : Math.abs(pos) == 1 ? 0.25 : 0
                Behavior on opacity { NumberAnimation{ duration: MediaPlayerModel.changeSongDuration } }
                y: 121
                source: model.cover
            }
            z: img.opacity > 0.90 ? 1 : -Math.abs(pos);

        }
    }

    Row {
        anchors.horizontalCenter: parent.horizontalCenter;
        y: 270
        id: durationLabel
        visible: true
        Text {
            text: (MediaPlayerModel.timePassed / 60).toFixed(0)
            font.pixelSize: 14
            font.family: "Microsoft YaHei UI"
            color: Style.lightPeriwinkle
        }
        Text {
            text: (MediaPlayerModel.timePassed % 60) < 10 ? ":0" : ":"
            font.pixelSize: 14
            font.family: "Microsoft YaHei UI"
            color: Style.lightPeriwinkle
        }
        Text {
            text: (MediaPlayerModel.timePassed % 60).toFixed(0)
            font.pixelSize: 14
            font.family: "Microsoft YaHei UI"
            color: Style.lightPeriwinkle
        }
    }

    SequentialAnimation {
        running: !MediaPlayerModel.mediaPlayback && MainModel.introSequenceCompleted
        loops: Animation.Infinite
        alwaysRunToEnd: true
        PropertyAnimation {
            target: durationLabel
            property: "opacity"
            duration: 400
            from: 1.0
            to: 0.0
        }
        PauseAnimation {
            duration: 100
        }
        PropertyAnimation {
            target: durationLabel
            property: "opacity"
            duration: 400
            from: 0.0
            to: 1.0
        }
    }

    MediaPlayer {
        id: audioPlayer
        source:MediaPlayerModel.getCurrentAudio();
        autoPlay:MediaPlayerModel.mediaPlayback
        audioOutput: AudioOutput { }
    }

    Connections {
        target: MediaPlayerModel

        onTrackChanged:{
            audioPlayer.source=MediaPlayerModel.getCurrentAudio();
            audioPlayer.play();
        }

        onMediaPlaybackChanged: {
            if(MediaPlayerModel.mediaPlayback){
                audioPlayer.play();
            }else{
                audioPlayer.pause();
            }
        }
    }

}