import QtQuick 2.7
import QtPositioning 5.2

Item {
    property alias gridCanvas: gridCanvas
    Canvas {
        id: gridCanvas
        anchors.fill: parent
        property var lineHeight: 100
        property var lineWidth: 100
        onPaint: {
            if (height < 5000) {
                var ctx = getContext("2d")
                ctx.strokeStyle = "black"
                ctx.fillStyle = "black"
                ctx.beginPath()
                ctx.lineWidth = 0.75

                for (var i = 1; i < 10; i++) {
                    ctx.moveTo(0, height * i / 10.0)
                    ctx.lineTo(width , height * i / 10.0)
                    ctx.fillStyle = "black"
                    ctx.fillText(i, 0, i * height / 10.0 + height / 20.0)
                }
                for (var i = 1; i < 10; i++) {
                    ctx.moveTo(width * i / 10.0, 0)
                    ctx.lineTo(width * i / 10.0, height)
                    ctx.rotate(Math.PI/2);
                    ctx.fillStyle = "black"

                    var alfabet = "ABCDEFGHIGKLMNOPQRSTUVWXYZ";

                    ctx.fillText(alfabet.charAt(i),
                                0, -width * i / 10.0 - width / 20.0)

                    ctx.rotate(-Math.PI/2);
                }
            }
            ctx.stroke()
        }

        function clear_canvas() {
            //var ctx = getContext("2d");
            //ctx.reset();
            //requestPaint();
        }
    }
}
