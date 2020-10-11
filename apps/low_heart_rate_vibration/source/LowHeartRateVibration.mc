//!
//! Copyright 2015 by Garmin Ltd. or its subsidiaries.
//! Subject to Garmin SDK License Agreement and Wearables
//! Application Developer Agreement.
//!

using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Application;
using Toybox.Sensor;


class StringView extends WatchUi.View {

    var string_HR = "---bpm";

    var font = Graphics.FONT_SMALL;
    var lineSpacing = Graphics.getFontHeight(font);
    var centerX;
    var centerY;

    function initialize() {
        View.initialize();
        Sensor.setEnabledSensors( [Sensor.SENSOR_HEARTRATE] );
        Sensor.enableSensorEvents( method(:onSnsr) );

    }

    function onLayout(dc) {
        centerX = dc.getWidth() / 2;
        centerY = dc.getHeight() / 2;
    }

    function onUpdate(dc) {
        dc.setColor( Graphics.COLOR_BLACK, Graphics.COLOR_BLACK );
        dc.clear();
        dc.setColor( Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT );

        dc.drawText( centerX, centerY - (lineSpacing / 2), font, string_HR, Graphics.TEXT_JUSTIFY_CENTER );
    }

    function onSnsr(sensor_info)
    {
        var HR = sensor_info.heartRate;
        if( sensor_info.heartRate != null )
        {
            string_HR = HR.toString() + "bpm";
        }
        else
        {
            string_HR = "---bpm";
        }

        WatchUi.requestUpdate();
    }
}

//! Watch Face Page class
class LowHeartRateVibrationApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() {
        return [ new StringView() ];
    }
}
