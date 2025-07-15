import Toybox.Activity;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;
import Toybox.System;



class MovingAveragePaceView extends WatchUi.SimpleDataField {
    var previous_pace;
    var a_coefficient;
    var b_coefficient;
    var conversion_factor;
    var _model;

    // Set the label of the data field here.
    function initialize(model) {
        SimpleDataField.initialize();
        _model = model;
        label = "Mov Avg Pace";
        previous_pace = 0.0;
        b_coefficient = 0.97;
        a_coefficient = 1.0 - b_coefficient;
    }

    // Convert the current time in minutes per km to display format
    function formatMinutesSeconds(timeInMinutes as Float) as String {
        var minutes = timeInMinutes.toNumber(); // Integer part: minutes
        var seconds = ((timeInMinutes - minutes) * 60).toNumber(); // Integer part: seconds
        // Pad seconds with leading zero if needed
        var secondsStr = seconds < 10 ? "0" + seconds.toString() : seconds.toString();
        return minutes.toString() + ":" + secondsStr;
    }

    // Called when new data is available
    function compute(info) {
        if (info != null && info.currentSpeed != null)
        {
            var speed = info.currentSpeed; // m/s
            if (speed > 0.0) {
                if ((speed < 0.6) || (speed > 8.5)) {
                    return "##:##";
                } else {
                   // speed_km/min = (speed_m/s / 1000) / 60
                    var conversion_factor = _model.getConversionFactor();
                    var pace = conversion_factor / info.currentSpeed;  // m/km   as (1.0 / speed_in_km_per_minute)
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