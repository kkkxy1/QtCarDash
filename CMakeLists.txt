cmake_minimum_required(VERSION 3.21)

project(QtInstrumentCluster VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 6.2 REQUIRED COMPONENTS Quick Gui LinguistTools)
find_package(Qt6 6.2 REQUIRED COMPONENTS Quick Gui LinguistTools Multimedia)

qt_standard_project_setup()

qt_add_executable(QtInstrumentCluster WIN32
    main.cpp
    qml.qrc
    src/DriveState.cpp
    src/DriveTrain.cpp
    src/mainmodel.cpp
    src/simulationcontroller.cpp
)

target_include_directories(QtInstrumentCluster PRIVATE src)
target_link_libraries(QtInstrumentCluster PRIVATE Qt6::Quick)
target_link_libraries(QtInstrumentCluster PRIVATE Qt6::Quick Qt6::Multimedia)

# Headers are listed for IDE navigation and AUTOMOC scanning
target_sources(QtInstrumentCluster PRIVATE
    src/DriveState.h
    src/DriveTrain.h
    src/mainmodel.h
    src/mathutils.h
    src/simulationcontroller.h
)

# Compile .ts translations and embed them under the /i18n/ resource prefix
qt_add_translations(QtInstrumentCluster
    TS_FILES QtInstrumentCluster_en_GB.ts
)
