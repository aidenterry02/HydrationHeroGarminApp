using Toybox.Math;

module Utils {
    function toRadians(deg) {
        return deg * Math.PI / 180;
    }

    function toDegrees(rad) {
        return rad * 180 / Math.PI;
    }

    function haversine(lat1, lon1, lat2, lon2) {
        var R = 6371;
        var dLat = toRadians(lat2 - lat1);
        var dLon = toRadians(lon2 - lon1);
        var a = Math.pow(Math.sin(dLat / 2), 2) + Math.cos(toRadians(lat1)) *
                Math.cos(toRadians(lat2)) * Math.pow(Math.sin(dLon / 2), 2);
        return R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    }

    function bearing(lat1, lon1, lat2, lon2) {
        var y = Math.sin(toRadians(lon2 - lon1)) * Math.cos(toRadians(lat2));
        var x = Math.cos(toRadians(lat1)) * Math.sin(toRadians(lat2)) -
                Math.sin(toRadians(lat1)) * Math.cos(toRadians(lat2)) *
                Math.cos(toRadians(lon2 - lon1));
        return (toDegrees(Math.atan2(y, x)) + 360) % 360;
    }
} 
