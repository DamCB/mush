use <dummies.scad>;
//$fn = 240;

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

module lens_75(){
     translate([0, 0, -7.5]) union(){
          translate([0, 0, 0]) ring(3.2, 4.4, 8.4);
          translate([0, 0, -3.2]) ring(3.2, 7.2, 9.2);
     }
}

module leds0202(ofst=0){
     for (i=[0:7])
          rotate([0, 0, 45*i])
               translate([-11.75, 0, -0.5]) cube([0.95+ofst, 2+ofst, 2+ofst], center=true);
}

module light_rig(phi_in=12){
     difference(){
          union(){
               translate([0, 0, -0.5]) rotate_extrude(){
                    translate([phi_in/2, 0, 0.]) circle(0.5);
               }
               ring(1, phi_in, 24);
          }
          leds0202(ofst=0.1);
     }
}



module detection(){
     translate([0, 0, -18]) union() {
          %camera_stand();
          camera();
          for (i=[0:3])
               rotate(i*90) translate([0, 8, 4.1]) cylinder(d=4, h=12.);
     }
     lens_75();
}

$fn=100;
//light_rig(phi_in=12);
detection();

//leds0202();
//translate([0, 0, -18] )ring(2, 22.9, 25.4);
