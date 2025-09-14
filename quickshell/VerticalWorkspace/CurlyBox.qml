import QtQuick.Shapes 1.9
import QtQuick
// import Quickshell
import ".."

Shape {
    id: r
    layer.enabled: true
    // layer.smooth: true
    layer.samples: 8
    property bool onLeft: true
    property int totalWidth: 50
    property int totalHeight: 300
    property int usableHeight: totalHeight - (totalWidth * 2)
    property int edgeSize: totalWidth / 2
    property bool inverted: false
    onInvertedChanged: {
        onLeft = !onLeft;
    }

    property string borderColor: MyColor.primary

    width: totalWidth
    height: totalHeight

    ShapePath {
        strokeWidth: 2
        strokeColor: r.borderColor
        fillColor: MyColor.bg // Optional: for filling the shape

        // Define the starting point of the path
        startX: r.onLeft ? 0 : r.totalWidth
        startY: 0

        PathArc {
            x: r.edgeSize
            y: r.edgeSize
            radiusX: r.edgeSize
            radiusY: r.edgeSize
            direction: r.onLeft ? PathArc.Counterclockwise : PathArc.Clockwise
        }
        PathArc {
            x: r.onLeft ? r.totalWidth : 0
            y: r.totalWidth
            radiusX: r.edgeSize
            radiusY: r.edgeSize
            direction: !r.onLeft ? PathArc.Counterclockwise : PathArc.Clockwise
            // direction: PathArc.Counterclockwise
        }
        PathLine {
            x: r.onLeft ? r.totalWidth : 0
            y: r.totalHeight - r.totalWidth
        }
        PathArc {
            x: r.edgeSize
            y: r.totalHeight - r.edgeSize
            radiusX: r.edgeSize
            radiusY: r.edgeSize
            direction: !r.onLeft ? PathArc.Counterclockwise : PathArc.Clockwise
        }
        PathArc {
            x: r.onLeft ? 0 : r.totalWidth
            y: r.totalHeight + 0
            radiusX: r.edgeSize
            radiusY: r.edgeSize
            direction: r.onLeft ? PathArc.Counterclockwise : PathArc.Clockwise
        }
    }
    Behavior on borderColor {
        ColorAnimation {
            duration: 250
            easing.type: Easing.Linear
        }
    }
}
