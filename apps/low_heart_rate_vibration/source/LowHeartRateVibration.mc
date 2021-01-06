//!
//! Copyright 2015 by Garmin Ltd. or its subsidiaries.
//! Subject to Garmin SDK License Agreement and Wearables
//! Application Developer Agreement.
//!

using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Application;
using Toybox.Sensor;
using Toybox.Attention;


class StringView extends WatchUi.View {

    var string_HR = "---bpm";
    var min_HR = 300;

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
            updateMinAndMaybeVibrate(HR);
        }
        else
        {
            string_HR = "---bpm";
        }

        WatchUi.requestUpdate();
    }

    function updateMinAndMaybeVibrate(HR)
    {
        if( min_HR > HR )
        {
            min_HR = HR;
            if (Attention has :vibrate)
            {
                var vibrateData = [
                    new Attention.VibeProfile(  50, 200 ),
                    new Attention.VibeProfile(  100, 100 ),
                    new Attention.VibeProfile(  50, 200 )
                ];

                Attention.vibrate(vibrateData);
            }
        }
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
