# QtInstrumentCluster（Qt 车载仪表盘）

基于 **Qt Quick（QML + C++）** 的汽车仪表盘演示程序——包含双圆形机械仪表、指示灯（tell-tale）、媒体播放器和驾驶状态模拟的仿真 HMI。

本项目 fork 自 [ShanavasPS/QtInstrumentCluster](https://github.com/ShanavasPS/QtInstrumentCluster)（该仓库由 Qt Quick Ultralite Automotive Cluster 官方示例移植而来，去掉了商业授权限制），作为个人学习项目并在此基础上做了功能与工程化改进。

## 功能特性

- **双圆形仪表**：左侧速度表 + 右侧转速表，指针平滑动画
- **指示灯（Tell-tale）**：转向灯、远光灯、安全气囊、驻车灯等
- **状态栏**：ODO 里程、续航里程（RANGE）、油量、电量
- **媒体播放器**：专辑封面切换动画
- **驾驶模拟**：虚拟驾驶员自动加速、换挡、遵守限速
- **键盘交互**：空格键暂停/恢复模拟，左右方向键切换歌曲

## 我的改进（学习成果）

1. **修复了错误的 `Q_PROPERTY` 声明**（`src/mainmodel.h`、`src/mainmodel.cpp`）
   - 原代码把 `speed/rpm/odo/range` 四个属性声明为 `CONSTANT`（"属性永不变化"），但它们的值每个模拟周期都在变——这对 QML 引擎是一个错误承诺。
   - 已改为 `NOTIFY` 信号声明，并新增 4 个专用信号（`speedChanged`、`rpmChanged`、`odoChanged`、`rangeChanged`），在 setter 中发出。这是 Qt 属性系统的正确用法（READ / WRITE / NOTIFY）。

2. **用 QML 属性绑定替代手动拷贝数据**（`models/MainModel.qml`）
   - 原实现通过 `modelUpdated()` 槽函数把 C++ 单例的值手动拷贝到 QML 属性。
   - 现在 `speed` 和 `rpm` 直接绑定 C++ 属性，`NOTIFY` 信号触发时自动更新——代码更少，更符合 Qt/QML 惯例。

3. **动手实验验证架构理解**
   - 修改 `DriveState.cpp` 中的限速值，观察虚拟驾驶员随之刹车（数据层 → 视图层联动）。
   - 修改 `Units.qml` 中的仪表量程（`maximumSpeed: 200 → 120`），观察刻度变密、指针更灵敏（视图层）。

## 架构

```
SimulationController（QTimer，500ms 周期）
        └─> DriveState（虚拟驾驶员：加速与限速逻辑）
                └─> Drivetrain（车辆物理：转速、换挡、速度、里程、油量、电量）
                        └─> MainModel（C++ 单例，Q_PROPERTY + NOTIFY 信号）
                                └─> QML 视图（仪表、指示灯、状态栏、媒体播放器）
```

C++ 负责数据与逻辑，QML 负责渲染，中间通过带 Qt 属性信号的 C++ 单例桥接。

## 构建与运行

**依赖**：Qt 6.x（MinGW 64-bit）、Qt Creator、CMake、Ninja。

方式 A — Qt Creator：
1. 打开 `QtInstrumentCluster.pro`
2. 使用 `Desktop Qt 6.x MinGW 64-bit` 套件配置（Release）
3. 点击运行

方式 B — 命令行：
```
D:/Qt/6.x.x/mingw_64/bin/qmake.exe QtInstrumentCluster.pro
D:/Qt/Tools/mingw*/bin/mingw32-make.exe
./release/QtInstrumentCluster.exe
```

## 键盘操作

| 按键 | 功能 |
|---|---|
| 空格 | 暂停 / 恢复模拟 |
| ← / → | 上一首 / 下一首 |
