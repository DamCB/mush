use <dummies.scad>;
$fn = 36;

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
          cylinder(d=26, h=8);
          translate([0, (11.3-8.5)/2, -0.9]) cube([8.6, 11.4, 3], center=true);
          translate([0, 0, -2.]) cylinder(d=8, h=12);
          translate([0, 0, 2]) cylinder(d=9.5, h=5);
     }
}

module lens_75(){
     translate([0, 0, -7.5]) union(){
          translate([0, 0, 0]) ring(3.2, 4.4, 8.4);
          translate([0, 0, -3.2]) ring(3.2, 7.2, 9.2);
     }
}

module leds_sequins(){
     for (i=[0:5])
          rotate([0, 0, 60*i]) translate([-10, 0, -1]) sequin();


}

//
module sequin(){
     difference() {
          minkowski(){
               cube([1, 7, 2], center=true);
               rotate([0, 90, 0]) cylinder(r=1, h=1, center=true);
          }
          translate([-2, 3.5, 0]) rotate([0, 90, 0]) cylinder(r=0.5, h=4);
          translate([-2, -3.5, 0]) rotate([0, 90, 0]) cylinder(r=0.5, h=4);
     }
     translate([1., 0, 1]) cube([0.4, 0.4, 0.4], center=true);
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
     translate([0, 0, -17.65]) union() {
          camera_stand();
          camera();
     }
}


/* light_rig(phi_in=12); */
/* color(c=[0.2, 0.0, 0.1, 0.3]) { */
/* difference(){ */
/*      union(){ */
/*           detection(); */
/*           lens_75(); */
/*      } */
/*      translate([-30, 0, 0]) cube([60, 60, 60], center=true); */
/* } */
/* } */
//leds0202();
//translate([0, 0, -18] )ring(2, 22.9, 25.4);
//translate([0, 0, -18]) camera_stand();
color([0.1, 0.1, 0.6]) {leds_sequins();}


detection();
lens_75();
