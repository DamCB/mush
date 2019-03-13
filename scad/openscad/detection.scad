use <dummies.scad>;
$fn = 240;

module camera(){
// http://www.arducam.com/spy-camera-raspberry-pi/
// Not the same cam exactly, but view angle is given
// as 54x41°, i.e 0.94 rad
     translate([0, 0, 1.5]) cylinder(d=7.4, h=3);
     translate([0, (11.3-8.5)/2, 0]) cube([8.5, 11.3, 3], center=true);
     translate([0, 11.3-4.25, -3])
          union(){
          rotate([0, 0, -90]) translate([0, 3.75, 0]) rotate([90, 0, 0])
               difference(){
               cylinder(d=4, h=7.5, $fn=36);
               translate([0, 0, -1]) cylinder(d=3.6, h=9, $fn=36);
               translate([0, -5, -1]) cube(10);
          }
          translate([-3.75, -12, -2]) cube([7.5, 12, 0.2], center=false);
     }
}

module camera_stand(){
     difference(){
          cylinder(d=22.9, h=4);
          translate([0, (11.3-8.5)/2, -0.9]) cube([8.6, 11.4, 3], center=true);
          translate([0, 0, 1.5]) cylinder(d=8, h=5);
     }
}

//camera_stand();
camera();
//ring(2, 22.9, 25.4);
