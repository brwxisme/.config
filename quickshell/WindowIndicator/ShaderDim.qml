import QtQuick
import Quickshell

Scope {
    PanelWindow {
        implicitWidth: 800
        implicitHeight: 600
        // transparent: true
        color: "transparent"

        // 🔵 Something to see through
        Rectangle {
            anchors.fill: parent
            color: "#2ecc71" // green background
        }

        ShaderEffect {
            anchors.fill: parent

            property vector2d resolution: Qt.vector2d(width, height)
            property vector2d holeCenter: Qt.vector2d(width / 2, height / 2)
            property real holeRadius: 80
            property real feather: 25

            fragmentShader: `
            uniform highp float qt_Opacity;
            uniform highp vec2 resolution;
            uniform highp vec2 holeCenter;
            uniform highp float holeRadius;
            uniform highp float feather;

            varying highp vec2 qt_TexCoord0;

            void main() {
                highp vec2 p = qt_TexCoord0 * resolution;
                highp float d = distance(p, holeCenter);

                highp float alpha = smoothstep(
                    holeRadius,
                    holeRadius + feather,
                    d
                );

                gl_FragColor = vec4(0.0, 0.0, 0.0, alpha);
            }
        `
        }
    }
}
