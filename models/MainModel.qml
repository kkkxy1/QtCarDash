pragma Singleton
import QtQuick 2.15
import Units 1.0
import MainModelData 1.0
import QtQuick.Controls 2.15

QtObject {
    id: mainmodel

    enum ClusterMode { ModeNormal, ModeSport, ModeEco }
    property int clusterMode: MainModel.ModeNormal
    property bool introSequenceStarted: false
    property bool introSequenceCompleted: false
    property bool simulationRunning: false

    property int speedLimitWarning: SpeedLimitValues.Slow
    readonly property int initialOdo: 300
    property int odo: initialOdo

    readonly property int fullRange: 895
    property int range: fullRange - odo
    property real speed: MainModelData.speed
    property real rpm: MainModelData.rpm
    property string gearShiftText: "P"
    property real temp: MainModelData.coolantTemp

    property real fuelLevel: MainModelData.fuelLevel
    property real batteryLevel: MainModelData.batteryLevel

    readonly property int maxSpeed: Units.longDistanceUnitToKilometers(Units.maximumSpeed)
    readonly property int maxRpm: 7000

    property bool telltalesVisible: true
    property bool clusterVisible: true
    property real clusterOpacity: 0
    property real gaugesOpacity: 0

    readonly property int clusterOpacityChangeDuration: 750
    readonly property int gaugesOpacityChangeDuration: 750;

    readonly property int gaugesValueChangeDurationNormal: 500
    readonly property int gaugesValueChangeDurationSlow: 1250
    property int gaugesValueChangeDuration: gaugesValueChangeDurationNormal

    property bool laneAssistCarMoving: simulationRunning

    Component.onCompleted: {
        MainModelData.modelUpdated.connect(modelUpdated);
    }

    function modelUpdated(){
        TellTalesModel.qtLogoOpacity = 0
        MainModel.odo = MainModelData.odo
        MainModel.range = MainModelData.range
    }
}
