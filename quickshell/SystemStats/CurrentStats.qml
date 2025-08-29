pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Hyprland

Singleton {
    id: root
    property real mem_used
    property real mem_total
    property real mem_used_gb
    property real mem_total_gb
    property real lastCpuIdle
    property real lastCpuTotal
    property real cpuPerc

    onMem_usedChanged: {
        const val = formatKib(root.mem_used);
        mem_used_gb = `${val.value.toFixed(2)}`;
    }
    onMem_totalChanged: {
        const val = formatKib(root.mem_total);
        mem_total_gb = `${Math.ceil(val.value)}`;
    }

    function formatKib(kib: real): var {
        const mib = 1024;
        const gib = 1024 ** 2;
        const tib = 1024 ** 3;

        if (kib >= tib)
            return {
                value: kib / tib,
                unit: "TB"
            };
        if (kib >= gib)
            return {
                value: kib / gib,
                unit: "GB"
            };
        if (kib >= mib)
            return {
                value: kib / mib,
                unit: "MB"
            };
        return {
            value: kib,
            unit: "KB"
        };
    }

    FileView {
        id: meminfo

        path: "/proc/meminfo"
        onLoaded: {
            const data = text();
            root.mem_total = parseInt(data.match(/MemTotal: *(\d+)/)[1], 10) || 1;
            root.mem_used = (root.mem_total - parseInt(data.match(/MemAvailable: *(\d+)/)[1], 10)) || 0;
        }
    }
    FileView {
        id: stat

        path: "/proc/stat"
        onLoaded: {
            const data = text().match(/^cpu\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)/);
            if (data) {
                const stats = data.slice(1).map(n => parseInt(n, 10));
                const total = stats.reduce((a, b) => a + b, 0);
                const idle = stats[3] + (stats[4] ?? 0);

                const totalDiff = total - root.lastCpuTotal;
                const idleDiff = idle - root.lastCpuIdle;
                root.cpuPerc = totalDiff > 0 ? (1 - idleDiff / totalDiff) : 0;

                root.lastCpuTotal = total;
                root.lastCpuIdle = idle;
            }
        }
    }

    Timer {
        running: true
        interval: 1000
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            // stat.reload();
            meminfo.reload();
            // storage.running = true;
            // gpuUsage.running = true;
            // sensors.running = true;
        }
    }
}
