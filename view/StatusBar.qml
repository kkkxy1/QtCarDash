import QtQuick 2.12
import Units 1.0
import MainModel 1.0
import Style 1.0

Item {

    Text {
        id: odo
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 27;
        anchors.left: parent.left;
        anchors.leftMargin: 30;
        text: "ODO";
        color: "#657080"
        font.pixelSize: 12;
        font.family: "Microsoft YaHei UI";
    }

    Text {
        id: odoValue
        anchors.baseline: odo.baseline;
        anchors.left: odo.right;
        anchors.leftMargin: 4;
        text: Units.toInt(Units.kilometersToLongDistanceUnit(MainModel.odo));
        color: Style.lightPeriwinkle;
        font.pixelSize: 20;
        font.family: "Microsoft YaHei UI";
    }

    Text {
        id: odoUnit
        anchors.baseline: odo.baseline;
        anchors.left: odoValue.right;
        anchors.leftMargin: 4;
        text: Units.longDistanceUnit;
        color: "#657080"
        font.pixelSize: 12;
        font.family: "Microsoft YaHei UI";
    }

    Text {
        id: range
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 27;
        x: 170
        text: "RANGE";
        color: "#657080"
        font.pixelSize: 12;
        font.family: "Microsoft YaHei UI";
    }

    Text {
        id: rangeValue
        anchors.baseline: range.baseline;
        anchors.left: range.right;
        anchors.leftMargin: 4;
        text: Units.toInt(Units.kilometersToLongDistanceUnit(MainModel.range))+"/200";
        color: Style.lightPeriwinkle;
        font.pixelSize: 20;
        font.family: "Microsoft YaHei UI";
    }

    Text {
        id: rangeUnit
        anchors.baseline: range.baseline;
        anchors.left: rangeValue.right;
        anchors.leftMargin: 4;
        text: Units.longDistanceUnit;
        color: "#657080"
        font.pixelSize: 12;
        font.family: "Microsoft YaHei UI";
    }


    LinearGauge {
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 27;
        x: 534;
        image: "qrc:/images/status/fuel.png";
        emptyText: "R";
        fullText: MainModel.fuelLevel.toFixed(2) + "/1.00";
        value: MainModel.fuelLevel;
    }

    LinearGauge {
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 27;
        // x: 408;
        x:660
        image:"qrc:/images/status/temp.png";
        emptyText: "C";
        fullText: "H";
        value: MainModel.temp / 180;
    }

    // LinearGauge {
    //     anchors.bottom: parent.bottom;
    //     anchors.bottomMargin: 27;
    //     x: 660;
    //     image: "qrc:/images/status/battery.png";
    //     emptyText: "E";
    //     fullText: MainModel.batteryLevel.toFixed(2)+"/1.00"
    //     value: MainModel.batteryLevel;
    // }
}
