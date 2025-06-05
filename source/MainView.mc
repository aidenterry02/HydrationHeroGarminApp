using Toybox.Application;
using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Position;
using Toybox.Sensor;
using Toybox.Lang;

class MainView extends WatchUi.View {
    var _position = null;
    var _heading = 0;
    var _mode = "WATER";
    var _target = null;

    function initialize() {
        View.initialize();
        Sensor.enableSensorEvents(method(:onSensor));
    }

    function onPosition(location) {
        _position = location;
        requestUpdate();
    }

    function onSensor(sensorInfo as Sensor.Info) as Void {
        if (sensorInfo != null && sensorInfo.heading != null) {
            // Convert heading from radians to degrees if needed
            _heading = Math.toDegrees(sensorInfo.heading);
            requestUpdate();
        }
    }

    function onTap(x, y) {
        // Switch between water and liquor
        _mode = (_mode == "WATER") ? "LIQUOR" : "WATER";
        requestUpdate();
    }

    function onUpdate(dc) {
        dc.clear();

        if (_position == null) {
            dc.drawText(
                dc.getWidth()/2,
                dc.getHeight()/2,
                Graphics.FONT_SMALL,
                WatchUi.loadResource(Rez.Strings.GettingGPS),
                Graphics.TEXT_JUSTIFY_CENTER
            );
            return;
        }

        // Get the correct location
        var targetList = (_mode == "WATER") ? Locations["WATER_SOURCES"] : Locations["LIQUOR_STORES"];
        _target = targetList[0]; // just use the first one for now

        // Get distance and direction
        var dist = Utils.haversine(_position["latitude"], _position["longitude"], _target["lat"], _target["lon"]);
        var dir = Utils.bearing(_position["latitude"], _position["longitude"], _target["lat"], _target["lon"]);

        // Draw mode & distance
        var centerX = dc.getWidth() / 2;
        var centerY = dc.getHeight() / 2;

        var modeText = (_mode == "WATER")
            ? WatchUi.loadResource(Rez.Strings.WaterMode)
            : WatchUi.loadResource(Rez.Strings.LiquorMode);

        dc.drawText(centerX, centerY - 20, Graphics.FONT_LARGE, modeText, Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(centerX, centerY, Graphics.FONT_XTINY, dist.format("%.2f") + " " + WatchUi.loadResource(Rez.Strings.DistanceUnit), Graphics.TEXT_JUSTIFY_CENTER);

        // Draw dial
        var radius = 40;
        dc.drawCircle(centerX, centerY + 40, radius);

        // Draw pointer
        var angle = (dir - _heading + 360) % 360;
        var angleRad = Math.toRadians(angle - 90);

        var endX = centerX + radius * Math.cos(angleRad);
        var endY = centerY + 40 + radius * Math.sin(angleRad);

        dc.drawLine(centerX, centerY + 40, endX, endY);
    }
} 