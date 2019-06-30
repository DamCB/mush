use <dummies.scad>;
$fn = 36;
phi_ext = 26;





module camera(){
// http://www.arducam.com/spy-camera-raspberry-pi/
// Not the same cam exactly, but view angle is given
// as 54x41°, i.e 0.94 rad
     translate([0, 0, 2]) cylinder(d=7.4, h=3);
     translate([0, 1.5, 1.5]) cube([8.5, 11.3, 3], center=true);
     translate([0, 7, -1.2])
          union(){
          rotate([0, 0, -90]) translate([0, 3.75, 0]) rotate([90, 0, 0])
               difference(){
               cylinder(d=4, h=7.5);
               translate([0, 0, -1]) cylinder(d=3.6, h=9, $fn=36);
               translate([0, -5, -1]) cube(10);
          }
          translate([-3.75, -12, -2]) cube([7.5, 12, 0.2], center=false);
     }
}



module base_plate(){
     difference(){
          cylinder(d=phi_ext, h=6);
          for (i=[0:5])
               rotate([0, 0, 60*i]) translate([-phi_ext/2+1, 0, 0.9])
                    union(){
                    translate([0, -3.5, -1]) cylinder(h=10, d=3);
                    translate([0, 3.5, -1]) cylinder(h=10, d=3);
               }
     }
}


module camera_stand(){
     difference(){
          base_plate();
          translate([0, 2.5, 1.5]) cube([8.6, 13.6, 3], center=true);
          translate([0, 0, -2]) cylinder(d=7.8, h=12);
          translate([0, 0, 3]) ring(6, 22, 30);
     }
}


module lens_75(){
     translate([0, 0, -5.2]) union(){
          translate([0, 0, 0]) ring(3.2, 4.4, 8.4);
          translate([0, 0, -3.2]) ring(3.2, 7.2, 9.2);
     }
}


module lens_75_stand(){
     difference(){
          base_plate();
          translate([0, 0, -2]) cylinder(d=9.3, h=5.2);
          translate([0, 0, -2]) cylinder(d=8.1, h=12);
     }
}


module sequins_stand(){
     difference(){
          translate([0, 0, -5])  base_plate();
          for (i=[0:5])
               rotate([0, 0, 60*i]) translate([-10, 0, -1])
                    union(){
                    cube([2.2, 9.2, 4.2], center=true);
                    translate([2, 0, 0.1]) cube([4, 6, 4.1], center=true);
               }
          translate([0, 0, -8]) cylinder(d=16, h=12);

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


module detection(){
     translate([0, 0, -17.65]) union() {
          camera_stand();
          camera();
          translate([0, 0, 6.05]) lens_75_stand();
     }
}


/* difference(){ */
/*      union(){ */
/*           color(c=[0.2, 0.0, 0.1, 0.3]) {detection();} */
/*           color(c=[0.8, 0.0, 0.1, 0.3]) {lens_75();} */
/*      } */
/*      translate([-30, 0, 0]) cube([60, 60, 60], center=true); */
/* } */


difference(){
     union(){

color([0.1, 0.1, 0.6]) {translate([0, 0, 0.1]) leds_sequins();}
sequins_stand();
color(c=[0.4, 0.8, 0.4]) {detection();}

color(c=[0.8, 0.1, 0.1]) {lens_75();}
translate([0, 0, 2.1]) ring(1, 22.9, phi_ext);

     }
     translate([-30, 0, 0]) cube([60, 60, 60], center=true);
}


//detection();
