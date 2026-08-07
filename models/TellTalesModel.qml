pragma Singleton
import QtQuick 2.15

QtObject {
    id: telltalesmodel;

    property bool turnLeftActive: false;
    property bool beamActive: false;
    property bool highBeamsActive: false;
    property bool parkedActive: false;
    property bool airbagActive: false;
    property bool turnRightActive: false;

    property bool turnLeftBlinking: false;
    property bool turnRightBlinking: false;
    property bool turnLeftVisible: false;
    property bool turnRightVisible: false;

    readonly property int opacityChangeDuration: 100;
    property double qtLogoOpacity: 1;
    property double indicatorOpacity: 0.7;


    onTurnLeftBlinkingChanged: { turnLeftVisible=turnLeftBlinking; }
    onTurnRightBlinkingChanged: { turnRightVisible=turnRightBlinking; }

    function toggleLeftTurn(){
        if(TellTalesModel.turnLeftActive){
            TellTalesModel.turnLeftActive=false;
            TellTalesModel.turnLeftBlinking=false;
        }else{
            TellTalesModel.turnLeftActive=true;
            TellTalesModel.turnLeftBlinking=true;
            TellTalesModel.turnRightActive=false;
            TellTalesModel.turnRightBlinking=false;
        }
    }

    function toggleRightTurn(){
        if(TellTalesModel.turnRightActive){
            TellTalesModel.turnRightActive=false;
            TellTalesModel.turnRightBlinking=false;
        }else{
            TellTalesModel.turnRightActive=true;
            TellTalesModel.turnRightBlinking=true;
            TellTalesModel.turnLeftActive=false;
            TellTalesModel.turnLeftBlinking=false;
        }
    }
}
