use <dummies.scad>;
$fn = 36;

sphere_phi_out = 72;
sphere_phi_in = 62;
stand_width = 12;
thickness = (sphere_phi_out-sphere_phi_in)/2;
shift = (sphere_phi_out+sphere_phi_in)/4;

module hex_adjustment_screw
(
    //THORLABS P/N F3SS8
)
{
    color([0, 0, 0])
    union()
    {
	difference()
	{
	    metric_thread(3, 0.25, 7.6);
	    translate([0, 0, -0.1]) cylinder(r=0.75, h=2.1, $fn=6);
	}
	translate([0, 0, 7.]) sphere(d=1.5, $fn=100);
    }
}



module adjuster_nut
(
    //THORLABS P/N N250L3
)
{
    difference()
    {
	union()
	{
	    cylinder(r=3, h=2, $fn=6);
	    translate([0, 0, 2]) metric_thread(4.5, 0.5, 3);
	}
	translate([0, 0, -1]) metric_thread(3, 0.25, 7.6, internal=true);
    }
}


module camera(){
// http://www.arducam.com/spy-camera-raspberry-pi/
// Not the same cam exactly, but view angle is given
// as 54x41°, i.e 0.94 rad
// 180 rotate due to initial inverted design I'm too lazy to correct
     translate([0, 0, 5]) rotate([180, 0, 0]) union(){
          translate([0, 0, 2]) cylinder(d=7.4, h=3);
          translate([0, 1.5, 1.5]) cube([8.5, 11.3, 3], center=true);
          translate([0, 7, -1.2])
               union(){
               /* rotate([0, 0, -90]) translate([0, 3.75, 0]) rotate([90, 0, 0]) */
               /*      difference(){ */
               /*      cylinder(d=4, h=7.5); */
               /*      translate([0, 0, -1]) cylinder(d=3.6, h=9, $fn=36); */
               /*      translate([0, -5, -1]) cube(10); */
               /* } */
               translate([-3.75, 0, 1.]) cube([7.5, 10, 0.2], center=false);
          }
     }
}



// This is a crudely simply metric thread
// not ISO
module metric_thread(diameter=8, pitch=1, length=1,
    internal=false, n_starts=1, $fn=36)
{
   // Number of turns needed.
   n_turns = floor(length/pitch);
   n_segments = $fn;
   h = pitch * cos(30);

   union()
   {

       // Solid center, including Dmin truncation.
       if (internal) {
           cylinder(r=diameter/2 - h*5/8, h=length, $fn=n_segments);
       } else {

           // External thread includes additional relief.
           cylinder(r=diameter/2 - h*5.3/8, h=length, $fn=n_segments);
       }
   }
}


module hex_adjustment_screw
(
    //THORLABS P/N F3SS8
)
{
    color([0, 0, 0])
    union()
    {
	difference()
	{
	    metric_thread(3, 0.25, 7.6);
	    translate([0, 0, -0.1]) cylinder(r=0.75, h=2.1, $fn=6);
	}
	translate([0, 0, 7.]) sphere(d=1.5, $fn=100);
    }
}



module camera_stand(){
     difference(){
          union(){
                translate([0, 6, 7]) difference(){
                    translate([0, 0, -2]) rotate([0, 90, 0])
                         cylinder(d=18, h=stand_width, center=true);
                    rotate([0, 90, 0])
                         cylinder(d=8, h=2*stand_width, center=true);
                    translate([-50, -100, -50]) cube([100, 100, 100]);
               }
               translate([0, 1, 12.5]) union(){
                    translate([0, -8, 0]) cylinder(d=stand_width, h=3, center=true);
                    translate([0, -2, 0]) cube([stand_width, stand_width+2, 3], center=true);
               }
               translate([0, 2, 1])
                    cube([stand_width, stand_width+5, 4], center=true);
          }
          translate([0, 0, 5]) rotate([0, 0, 180]) union(){
               translate([0, 2.5, 1.5]) cube([8.6, 13.6, 3], center=true);
               translate([0, 0, -8]) cylinder(d=7.8, h=12);
               //translate([0, 0, 3]) ring(6, 22, 30);
          }
          translate([0, 0, 10]) adjuster_nut();
          translate([0, 0, 10.1]) adjuster_nut();
          translate([0, 0, 12])
               cylinder(d=2.8, h=10, center=true);
          translate([0, -8, 12])
               cylinder(d=4.1, h=12, center=true);
          translate([0,  8, 12])
               cylinder(d=4.1, h=18, center=true);
     }
}

module camera_arc(){
     rotate ([0, 90, 0]) difference(){
     union(){
          difference(){
               translate([-5, 0, 0]) cylinder(d=sphere_phi_out, h=stand_width, center=true);
               cylinder(d=sphere_phi_in, h=stand_width+2, center=true);
               translate([0, -50, -50]) cube([100, 100, 100]);
          }
          translate([0,  shift, 0]) rotate([90, 0, 0])
               cylinder(h=thickness, d=stand_width, center=true);
          translate([0,  -shift, 0]) rotate([90, 0, 0])
               cylinder(h=thickness, d=stand_width, center=true);
          translate([-sphere_phi_in/2-6, -15, -stand_width/2]) cube([10, 30, stand_width]);
     }
     translate([-sphere_phi_out/2-11, -20, -stand_width/2-1]) cube([10, 40, stand_width+2]);
     rotate([0, 90, 0 ]) cylinder(d=6.1, h=sphere_phi_out+12, center=true);
     rotate([90, 0, 0 ]) cylinder(d=6.1, h=sphere_phi_out+12, center=true);
     translate([0, -8, 0]) rotate([0, 90, 0 ]) cylinder(d=4.1, h=sphere_phi_out+8, center=true);
     translate([0,  8, 0]) rotate([0, 90, 0 ]) cylinder(d=4.1, h=sphere_phi_out+8, center=true);
     }
}


module focus_knob(){

     translate([0, 0, 13]) cylinder(d=6, h=12, center=true);
     translate([0, 0, 20.5]) difference(){
          cylinder(d=25, h=6, center=true);
          for (i = [0: 30: 330]){
               rotate([0, 0, i]) translate([14, 0, -4]) cylinder(d=6, h=8);
               }
     }

 rotate([0, 0, 180]) hex_adjustment_screw();
}



module lens_75(){
     translate([0, 0, 3.2]) union(){
          translate([0, 0, 0]) ring(3.2, 4.4, 8.4);
          translate([0, 0, 3.2]) ring(3.2, 7.2, 9.2);
     }
}


module lens_75_stand(){
     difference(){
          translate([0, 0, 2.]) cube([stand_width, stand_width, 4], center=true);
          translate([0, 0, -2]) cylinder(d=9.3, h=5.2);
          translate([0, 0, -2]) cylinder(d=8., h=12);
     }
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

lens_bfl = 5.2;

module detection(){
     translate([0, 0, 20]) focus_knob();
     translate([0, -8, 24]) cylinder(d=4, h=12.7, center=true);
     translate([0,  8, 24]) cylinder(d=4, h=12.7, center=true);

     translate([0, 0, 20]) adjuster_nut();
     camera_arc();
     translate([0, 0, 0]) rotate([0, 0, 0]) union() {
          translate([0, 0, 10]) union(){
               camera_stand();
               camera();
          }
          translate([0, 0, lens_bfl]) union(){
               lens_75_stand();
               lens_75();
          }
     }
}

detection();
