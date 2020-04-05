use <dummies.scad>;
use <turret.scad>;
use <focus_knob.scad>;
use <grip.scad>;
use <detection.scad>;

detection();
%translate([0, 0, -15]) rotate([0, 180, 0]) mock_focus();
