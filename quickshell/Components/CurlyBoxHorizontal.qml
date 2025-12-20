import QtQuick.Shapes 1.9
import QtQuick
// import Quickshell
import ".."

Shape {
    id: r
    layer.enabled: true
    // layer.smooth: true
    layer.samples: 8
    property bool onBot: true
    property int totalWidth: 300
    property int totalHeight: 50
    property int usableWidth: totalWidth - (totalHeight * 2)
    property int edgeSize: totalHeight / 2
    property string bgColor: MyColor.bg
    property bool inverted: false
    onInvertedChanged: {
        onBot = !onBot;
    }

    property string borderColor: MyColor.primary

    width: totalWidth
    height: totalHeight

    ShapePath {
        strokeWidth: 2
        strokeColor: r.borderColor
        fillColor: r.bgColor // Optional: for filling the shape

        // Define the starting point of the path
        startX: 0
        startY: r.onBot ? r.totalHeight : 0

        PathArc {
            x: r.edgeSize
            y: r.edgeSize
            radiusX: r.edgeSize
            radiusY: r.edgeSize
            direction: r.onBot ? PathArc.Counterclockwise : PathArc.Clockwise
        }
        PathArc {
            x: r.totalHeight
            y: !r.onBot ? r.totalHeight : 0
            radiusX: r.edgeSize
            radiusY: r.edgeSize
            direction: !r.onBot ? PathArc.Counterclockwise : PathArc.Clockwise
            // direction: PathArc.Counterclockwise
        }
        PathLine {
            x: r.totalWidth - r.totalHeight
            y: !r.onBot ? r.totalHeight : 0
        }
        PathArc {
            x: r.totalWidth - r.edgeSize
            y: r.edgeSize
            radiusX: r.edgeSize
            radiusY: r.edgeSize
            direction: !r.onBot ? PathArc.Counterclockwise : PathArc.Clockwise
        }
        PathArc {
            y: !r.onBot ? 0 : r.totalHeight
            x: r.totalWidth + 0
            radiusX: r.edgeSize
            radiusY: r.edgeSize
            direction: r.onBot ? PathArc.Counterclockwise : PathArc.Clockwise
        }
    }
    Behavior on borderColor {
        ColorAnimation {
            duration: 250
            easing.type: Easing.Linear
        }
    }
}
