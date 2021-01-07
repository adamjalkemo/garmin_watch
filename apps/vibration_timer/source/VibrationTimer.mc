//!
//! Copyright 2015 by Garmin Ltd. or its subsidiaries.
//! Subject to Garmin SDK License Agreement and Wearables
//! Application Developer Agreement.
//!

using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Application;
using Toybox.Attention;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Timer;

const MILLISECONDS_PER_SECOND = 1000;


class DurationNPD extends WatchUi.NumberPickerDelegate {
    var duration = null;

    function initialize() {
        NumberPickerDelegate.initialize();
    }

    function onNumberPicked(value) {
        duration = value;
    }
}

class TimerView extends WatchUi.View {

    const FONT = Graphics.FONT_SMALL;
    var lineSpacing = Graphics.getFontHeight(FONT);
    var centerX;
    var centerY;
    var delegate = new DurationNPD();
    var initialized = false;
    var timerSet = false;

    function initialize() {
        View.initialize();
    }

    function onLayout(dc) {
        centerX = dc.getWidth() / 2;
        centerY = dc.getHeight() / 2;
    }

    function onUpdate(dc) {
        dc.setColor( Graphics.COLOR_BLACK, Graphics.COLOR_BLACK );
        dc.clear();
        dc.setColor( Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT );

        if (delegate.duration == null) {
            if (!initialized) {
                initialized = true;
                var value = Gregorian.duration({:hours=>8, :minutes=>0, :seconds=>0});
                var np = new WatchUi.NumberPicker(WatchUi.NUMBER_PICKER_TIME, value);
                WatchUi.pushView(np, delegate, WatchUi.SLIDE_IMMEDIATE);
                WatchUi.requestUpdate();
            }
        } else {
            if (!timerSet) {
                timerSet = true;
                var vibrationTimer = new Timer.Timer();
                vibrationTimer.start(method(:reccuringVibration), delegate.duration.value() * MILLISECONDS_PER_SECOND, false);
            }

            var timeOfVibration = Time.now().add(delegate.duration);
            var info = Gregorian.info(timeOfVibration, Time.FORMAT_MEDIUM);
            var alarmString = Lang.format(
                "Vibration starts at $1$:$2$:$3$",
                [
                    info.hour,
                    info.min,
                    info.sec
                ]
            );
            dc.drawText( centerX, centerY - (lineSpacing / 2), FONT, alarmString, Graphics.TEXT_JUSTIFY_CENTER );
        }
    }

    function reccuringVibration() {
        vibrate();
        var vibrationTimer = new Timer.Timer();
        vibrationTimer.start(method(:vibrate), 15 * MILLISECONDS_PER_SECOND, true);
    }

    function vibrate()
    {
        if (Attention has :vibrate)
        {
            var vibrateData = [
                new Attention.VibeProfile( 50, 100 )
            ];

            Attention.vibrate(vibrateData);
        }
    }

    function requestUpdate()
    {
        WatchUi.requestUpdate();
    }
}

//! Watch Face Page class
class VibrationTimer extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() {
        return [ new TimerView() ];
    }
}
