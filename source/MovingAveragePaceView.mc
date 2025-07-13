import Toybox.Activity;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;

class MovingAveragePaceView extends WatchUi.SimpleDataField {
    var previous_pace;
    var a_coefficient;
    var b_coefficient;

    // Set the label of the data field here.
    function initialize() {
        SimpleDataField.initialize();
        label = "Moving Average Pace";
        previous_pace = 0.0;
        b_coefficient = 0.97;
        a_coefficient = 1.0 - b_coefficient;
    }


    function formatMinutesSeconds(timeInMinutes as Float) as String {
        var minutes = timeInMinutes.toNumber(); // Integer part: minutes
        var seconds = ((timeInMinutes - minutes) * 60).toNumber(); // Integer part: seconds
        // Optional: Pad seconds with leading zero if needed
        var secondsStr = seconds < 10 ? "0" + seconds.toString() : seconds.toString();
        return minutes.toString() + ":" + secondsStr;
    }
    function compute(info) {
        if (info != null && info.currentSpeed != null)
        {
            var speed = info.currentSpeed; // m/s
            if (speed > 0.0) {
                // speed_km/min = (speed_m/s / 1000) / 60
                // (1.0) / speed_m/s
                var pace = 16.6666666667 / info.currentSpeed;  // m/km   as (1.0 / speed_in_km_per_minute)
                if ((pace >= 15.0) || (pace < 2.0)) {
                    return "##:##";
                } else {
                    if (0.0 == previous_pace) {
                        previous_pace = pace;
                    } else {
                        previous_pace = b_coefficient * previous_pace + a_coefficient * pace;
                    }
                    return formatMinutesSeconds(previous_pace);
                }
            }
        }
        return "--:--";
    }
}