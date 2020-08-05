use <dummies.scad>;
use <turret.scad>;
use <focus_knob.scad>;
use <grip.scad>;
use <base.scad>;
use <detection.scad>;
$fn = 360;
latitude = 30;
longitude = 20;

//camera_arc();
//camera_stand();
//lens_75_stand();
//focus_knob();


rotate([0, 0, longitude]) union() {
 rotate([0, latitude, 0]) detection();
 sliders();
}

rail();                         /*  */
