using Toybox.Application;

class MainApp extends Application.AppBase {
    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() {
        return [ new MainView() ];
    }

    function onStop(state) {}
} 