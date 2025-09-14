import QtQuick.Shapes 1.9
import QtQuick
import Quickshell

PanelWindow {
    width: 256
    height: 256
    // color: "transparent"

    Shape {
        layer.enabled: true
        // layer.smooth: true
        layer.samples: 8
        width: 200
        height: 200

        ShapePath {
            strokeWidth: 2
            strokeColor: MyColor.primary
            fillColor: MyColor.bg // Optional: for filling the shape

            // Define the starting point of the path
            startX: 0
            startY: 0

            // Add path elements to define the shape
            // PathLine {
            //     x: 0
            //     y: 0
            // }

            PathArc {
                x: 25
                y: 25
                radiusX: 25
                radiusY: 25
                direction: PathArc.Counterclockwise
                // useLargeArc: true
            }
            PathArc {
                x: 50
                y: 50
                radiusX: 25
                radiusY: 25
                // direction: PathArc.Counterclockwise
                // useLargeArc: true
            }
            PathLine {
                x: 50
                y: 150
            }
            PathArc {
                x: 25
                y: 175
                radiusX: 25
                radiusY: 25
                // useLargeArc: true
            }
            PathArc {
                x: 0
                y: 200
                radiusX: 25
                radiusY: 25
                direction: PathArc.Counterclockwise
                // useLargeArc: true
            }
            // PathLine {
            //     x: 50
            //     y: 150
            // }
            // PathLine {
            //     x: 0
            //     y: 200
            // }
        }
    }
    Shape {
        width: 200
        Path {
            startX: 20
            startY: 0
            PathCubic {
                x: 180
                y: 0
                control1X: -10
                control1Y: 90
                control2X: 210
                control2Y: 90
            }
        }
    }
    Path {
        startX: 0
        startY: 100
        PathLine {
            x: 200
            y: 100
        }
    }
}
