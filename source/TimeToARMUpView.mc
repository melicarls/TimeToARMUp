using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time as Time;
using Toybox.Time.Gregorian as Calendar;

class TimeToARMUpView extends Ui.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    var background;
    function onLayout(dc) {
        background = Ui.loadResource(Rez.Drawables.background);
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

	var screenType;
	var backgroundX;
 	var backgroundY;
 	var dateX;
 	var dateY;
 	var timeX;
 	var timeY;
 	var batteryX;
 	var batteryY;
 	var sloganX;
 	var sloganY;
 	var sloganSize;
    // Update the view
    
	function onUpdate(dc) {
	    // Set background color
        dc.clear();
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());
           
        // Get the screen shape   
        screenType = Sys.getDeviceSettings().screenShape;
         
        // Get the current time
        var clockTime = Sys.getClockTime();
        var clockHour = clockTime.hour;

		var todaysDate = Calendar.info(Time.now(), Time.FORMAT_LONG);
		var dayOfWeek = todaysDate.day_of_week;
        var month = todaysDate.month;
		var day = todaysDate.day;

        var clockMinute = clockTime.min.format("%02d");
        
        if (!Sys.getDeviceSettings().is24Hour) {
 			if ( clockTime.hour > 12 ) {
 				clockHour = clockTime.hour-12;
 			}
 		}
 		
        var timeString = Lang.format("$1$:$2$", [clockHour, clockMinute]);
 		var dateString = Lang.format("$1$, $2$ $3$", [dayOfWeek, month, day]);

 		var batteryStatus = Sys.getSystemStats().battery.toLong();
 		var batteryString = Lang.format("$1$%", [batteryStatus]);
 		
 		// Set variables to draw layout
 		var x = dc.getWidth();
 		var y = dc.getWidth();
 		
        if (screenType == Sys.SCREEN_SHAPE_RECTANGLE) {
        	// Rectangle layout
        	backgroundX = -8;
        	backgroundY = 50;
        	dateX = 105;
        	dateY = 2;
        	timeX = 105;
        	timeY = 33;
        	batteryX = 185;
        	batteryY = 115;
        	sloganX = 105;
        	sloganY = 125;
        	sloganSize = Gfx.FONT_SMALL;
        } else {
        	// Round screen layout
        	backgroundX = 0;
        	backgroundY = 60;
        	dateX = 105;
        	dateY = 3;
        	timeX = 105;
        	timeY = 18;
        	batteryX = 175;
        	batteryY = 35;
        	sloganX = 105;
        	sloganY = 150;
        	sloganSize = Gfx.FONT_MEDIUM;
        }

		// Draw layout
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
		
		// Draw background     
        dc.drawBitmap(backgroundX, backgroundY, background);

		// Draw the slogan
		dc.drawText(sloganX, sloganY, sloganSize, "Time to ARM up!", Gfx.TEXT_JUSTIFY_CENTER);
		
		// Draw the time
		dc.drawText(dateX, dateY, Gfx.FONT_MEDIUM, dateString, Gfx.TEXT_JUSTIFY_CENTER);
		dc.drawText(timeX, timeY, Gfx.FONT_SYSTEM_NUMBER_HOT, timeString, Gfx.TEXT_JUSTIFY_CENTER);
		
		// Draw the battery status
		if (batteryStatus > 50) {
	    	dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);
		} else if (batteryStatus > 20) {
			dc.setColor(Gfx.COLOR_ORANGE, Gfx.COLOR_TRANSPARENT);
		} else {
			dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
		}
		
		dc.drawText(batteryX, batteryY, Gfx.FONT_XTINY, batteryString, Gfx.TEXT_JUSTIFY_CENTER);
	}


    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
