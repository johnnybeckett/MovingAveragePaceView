import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class MovingAveragePaceApp extends Application.AppBase {
    var _model;

    function initialize() {
        AppBase.initialize();
        _model = new MovingAveragePaceModel();
        _model.readSettings();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        _model.readSettings();
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ new MovingAveragePaceView(_model) ];
    }

}

function getApp() as MovingAveragePaceApp {
    return Application.getApp() as MovingAveragePaceApp;
}