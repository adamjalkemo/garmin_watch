//!
//! Copyright 2015 by Garmin Ltd. or its subsidiaries.
//! Subject to Garmin SDK License Agreement and Wearables
//! Application Developer Agreement.
//!

using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Application;

class StringView extends WatchUi.View {

    var hello_world;

    var font = Graphics.FONT_SMALL;
    var lineSpacing = Graphics.getFontHeight(font);
    var centerX;
    var centerY;

    function initialize() {
        View.initialize();
    }

    function onLayout(dc) {
        hello_world = WatchUi.loadResource( Rez.Strings.hello_world );

        centerX = dc.getWidth() / 2;
        centerY = dc.getHeight() / 2;
    }

    function onUpdate(dc) {
        dc.setColor( Graphics.COLOR_BLACK, Graphics.COLOR_BLACK );
        dc.clear();
        dc.setColor( Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT );

        dc.drawText( centerX, centerY - (lineSpacing / 2), font, hello_world, Graphics.TEXT_JUSTIFY_CENTER );
    }

}

//! Watch Face Page class
class HelloWorldApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() {
        return [ new StringView() ];
    }
}
