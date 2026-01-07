import QtQuick.Shapes 1.9
import QtQuick

// import ".."

Shape {
    id: root
    property string clr: "pink"
    property bool is_left: true
    property bool is_top: true
    property int size: 32

    width: size
    height: size
    layer.enabled: true
    layer.samples: 8
    anchors.right: !is_left ? parent.right : false
    anchors.bottom: is_top ? false : parent.bottom
    ShapePath {
        strokeWidth: 0
        // strokeColor: "green"
        fillColor: root.clr

        // Define the starting point of the path
        startX: root.is_left ? root.size : 0
        startY: root.is_top ? 0 : root.size

        PathArc {
            // direction: root.is_left || root.is_top ? PathArc.Counterclockwise : PathArc.Clockwise
            direction: if (root.is_left) {
                if (!root.is_top) {
                    return PathArc.Clockwise;
                }
                return PathArc.Counterclockwise;
            } else {
                if (!root.is_top) {
                    return PathArc.Counterclockwise;
                }
                return PathArc.Clockwise;
            }
            x: root.is_left ? 0 : root.size
            y: root.is_top ? root.size : 0
            radiusX: root.size
            radiusY: root.size
        }
        PathArc {
            x: root.is_left ? 0 : root.size
            y: root.is_top ? 0 : root.size
        }

        // PathArc {
        //     x: r.edgeSize
        //     y: r.edgeSize
        //     radiusX: r.edgeSize
        //     radiusY: r.edgeSize
        // }
    }
}
