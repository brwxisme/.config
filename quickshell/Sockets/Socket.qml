import Quickshell
import Quickshell.Io
import ".."
import QtQuick

Item {
    id: root
    property string socketPath: "/home/brew/quickshell_socket.sock"
    SocketServer {
        id: socket

        active: false
        // active: true
        path: "/home/brew/quickshell_socket.sock"
        handler: Socket {
            onConnectedChanged: {
                console.log(connected ? "new connection!" : "connection dropped!");
            }
            parser: SplitParser {
                onRead: message => {
                    Globals.keypressed_from_socket(message);
                // console.log(`read message from socket: ${message}`);
                }
            }
        }
    }

    Process {
        id: check_socket
        command: ["sh", "-c", "ls /home/brew/ | grep 'quickshell_socket'"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                if (text.length <= 0) {
                    console.log("AAAAAAAAAAAAAAAAAAA");
                }
                // socket.active = text.length <= 0;
                socket.active = true;
                console.log(" XXXXXXXXXXXXXX socket ls result ", text.length <= 0, text);
            }
        }
    }
    Component.onCompleted: {
        check_socket.running = true;
    }
}
