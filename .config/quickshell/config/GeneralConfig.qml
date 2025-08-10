import Quickshell.Io

JsonObject {
    property Rounding rounding: Rounding {}
    property Spacing spacing: Spacing {}
    property Padding padding: Padding {}
    property FontFamily fontFamily: FontFamily {}
    property FontSize fontSize: FontSize {}
    readonly property Anim anim: Anim {}

    component Rounding: JsonObject {
        readonly property int small: 12
        readonly property int normal: 17
        readonly property int large: 25
        readonly property int full: 1000
    }

    component Spacing: JsonObject {
        readonly property int smaller: 7
        readonly property int small: 10
        readonly property int normal: 12
        readonly property int large: 15
        readonly property int larger: 20
        readonly property int largest: 30
    }

    component Padding: JsonObject {
        readonly property int smaller: 5
        readonly property int small: 7
        readonly property int normal: 10
        readonly property int large: 12
        readonly property int larger: 15
        readonly property int largest: 20
    }

    component FontFamily: JsonObject {
        readonly property string sans: "IBM Plex Sans"
        readonly property string mono: "JetBrains Mono NF"
        readonly property string material: "Material Symbols Rounded"
    }

    component FontSize: JsonObject {
        readonly property int smaller: 11
        readonly property int small: 12
        readonly property int normal: 13
        readonly property int large: 15
        readonly property int larger: 18
        readonly property int largest: 28
    }

    component AnimCurves: JsonObject {
        readonly property list<real> emphasized: [0.05, 0, 2 / 15, 0.06, 1 / 6, 0.4, 5 / 24, 0.82, 0.25, 1, 1, 1]
        readonly property list<real> emphasizedAccel: [0.3, 0, 0.8, 0.15, 1, 1]
        readonly property list<real> emphasizedDecel: [0.05, 0.7, 0.1, 1, 1, 1]
        readonly property list<real> standard: [0.2, 0, 0, 1, 1, 1]
        readonly property list<real> standardAccel: [0.3, 0, 1, 1, 1, 1]
        readonly property list<real> standardDecel: [0, 0, 0, 1, 1, 1]
        readonly property list<real> expressiveFastSpatial: [0.42, 1.67, 0.21, 0.9, 1, 1]
        readonly property list<real> expressiveDefaultSpatial: [0.38, 1.21, 0.22, 1, 1, 1]
        readonly property list<real> expressiveEffects: [0.34, 0.8, 0.34, 1, 1, 1]
    }

    component AnimDurations: JsonObject {
        readonly property int small: 200
        readonly property int normal: 400
        readonly property int large: 600
        readonly property int largest: 1000
        readonly property int expressiveFastSpatial: 350
        readonly property int expressiveDefaultSpatial: 500
        readonly property int expressiveEffects: 200
    }

    component Anim: JsonObject {
        readonly property AnimCurves curves: AnimCurves {}
        readonly property AnimDurations durations: AnimDurations {}
    }
}
