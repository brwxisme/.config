import QtQuick 2.15

Item {
    id: root
    property color color: "#b5662e"
    property real strokeWidth: 8
    property bool flip: false   // set true if you want the brace mirrored horizontally

    // default size matches your uploaded image aspect; scale as needed
    width: 68
    height: 238

    Canvas {
        id: canvas
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);

            ctx.lineWidth = strokeWidth;
            ctx.lineCap = "round";
            ctx.lineJoin = "round";
            ctx.strokeStyle = root.color;

            // Normalized Catmull-Rom -> Cubic-Bezier segments (derived from your image)
            var beziers = [
                {
                    start: [0.0588235294, 0.0252100840],
                    c1: [0.0870098039, 0.0378151260],
                    c2: [0.0931372549, 0.0693277311],
                    end: [0.2279411765, 0.1008403361]
                },
                {
                    start: [0.2279411765, 0.1008403361],
                    c1: [0.3627450980, 0.1323529412],
                    c2: [0.7487745098, 0.1631652661],
                    end: [0.8676470588, 0.2142857143]
                },
                {
                    start: [0.8676470588, 0.2142857143],
                    c1: [0.9865196078, 0.2654061625],
                    c2: [0.9289215686, 0.3438375350],
                    end: [0.9411764706, 0.4075630252]
                },
                {
                    start: [0.9411764706, 0.4075630252],
                    c1: [0.9534313725, 0.4712885154],
                    c2: [0.9705882353, 0.5329131653],
                    end: [0.9411764706, 0.5966386555]
                },
                {
                    start: [0.9411764706, 0.5966386555],
                    c1: [0.9117647059, 0.6603641457],
                    c2: [0.8921568627, 0.7254901961],
                    end: [0.7647058824, 0.7899159664]
                },
                {
                    start: [0.7647058824, 0.7899159664],
                    c1: [0.6372549020, 0.8543417367],
                    c2: [0.2745098039, 0.9509803922],
                    end: [0.1764705882, 0.9831932773]
                }
            ];

            function tx(nx) {
                return (root.flip ? (1 - nx) : nx) * width;
            }
            function ty(ny) {
                return ny * height;
            }

            // Move to the first start point
            ctx.beginPath();
            var first = beziers[0].start;
            ctx.moveTo(tx(first[0]), ty(first[1]));

            // Draw all bezier segments
            for (var i = 0; i < beziers.length; ++i) {
                var s = beziers[i];
                ctx.bezierCurveTo(tx(s.c1[0]), ty(s.c1[1]), tx(s.c2[0]), ty(s.c2[1]), tx(s.end[0]), ty(s.end[1]));
            }

            ctx.stroke();
        }

        // repaint when important properties change
        onWidthChanged: requestPaint()
        onHeightChanged: requestPaint()
    }
}
