import Toybox.Application;
import Toybox.Activity;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;
import Toybox.System;

class MovingAveragePaceModel  {
    var _conversion_factor;

    function initialize() {
        readSettings();
    }

    function readSettings() {
        _conversion_factor = (getApp().getProperty("useImperial") == true) ? 26.8224 : 16.6666666667;
    }

    function getConversionFactor()
    {
        return _conversion_factor;
    }
}