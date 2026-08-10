pragma Singleton
import QtQuick 2.15

QtObject {
    id: normalmodemodel

    enum Menu { MediaPlayerMenu, NavigationMenu, PhoneMenu, CarStatusMenu, MenuCount }
    property int menu: NormalModeModel.MediaPlayerMenu
    property int setupIndex: -1
    property int setupSelect: 0
    property int brightness: 10

    function nextMenu() {
        if (menu === NormalModeModel.MediaPlayerMenu) {
            menu = NormalModeModel.NavigationMenu
        }
        else if (menu === NormalModeModel.NavigationMenu ) {
            menu = NormalModeModel.PhoneMenu
        }
        else if (menu === NormalModeModel.PhoneMenu ) {
            menu = NormalModeModel.CarStatusMenu
        }
        else if (menu === NormalModeModel.CarStatusMenu ) {
            menu = NormalModeModel.MediaPlayerMenu
        }
    }

    function previousMenu() {
        if (menu === NormalModeModel.MediaPlayerMenu) {
            menu = NormalModeModel.CarStatusMenu
        }
        else if (menu === NormalModeModel.NavigationMenu ) {
            menu = NormalModeModel.MediaPlayerMenu
        }
        else if (menu === NormalModeModel.PhoneMenu ) {
            menu = NormalModeModel.NavigationMenu
        }
        else if (menu === NormalModeModel.CarStatusMenu ) {
            menu = NormalModeModel.PhoneMenu
        }
    }

    readonly property var setupItems:[
        { name: "胎压监测", icon: ""},
        { name: "续航里程", icon: ""},
        { name: "水温状态", icon: ""},
        { name: "音量调节", icon: ""},
        { name: "屏幕亮度", icon: ""}

    ]
}
