use <dummies.scad>;
use <grip.scad>;

phi_sphere = 38;
e_sphere = 3.;
phi_sphere_in = phi_sphere - e_sphere;
phi_sphere_out = phi_sphere + e_sphere;

phi_knob_in = phi_sphere_in;
phi_knob_out = phi_knob_in + 6;
w_knob = (phi_knob_out - phi_knob_in)/2;
e_knob = 4;
hh = e_knob/3-0.1;
clear = 2;
$fn = 36;

module turret(){
     difference(){
          union(){
               movement_sphere(phi_sphere_in, phi_sphere_out);
               ring(e_knob, phi_knob_in, phi_knob_out);
          }
          sphere_hole(e=e_sphere,
                      phi_sphere=phi_sphere,
                      clear=clear,
                      aperture=175);
     }
}


module half_turret(){
     difference(){
          turret();
          translate([-25, -0.05, -25]) cube([50, 50, 50]);
     }
}


module left_turret(){
     union(){
          difference(){
               half_turret();
               translate([phi_knob_in/2+w_knob/2, -0.5, -1.5])
                    rotate(90, [1, 0, 0])
                    magnet();
               translate([-phi_knob_in/2-w_knob/2, 0., -2*hh+0.5])
                    cube([w_knob+0.2, w_knob+0.2, hh+0.3], center=true);

          }
          translate([-phi_knob_in/2-w_knob/2, 0, -hh/2])
                    cylinder(d=w_knob, h=hh, $fn=36, center=true);
          translate([-phi_knob_in/2-w_knob/2, 0, -e_knob+hh/2])
                    cylinder(d=w_knob, h=hh, $fn=36, center=true);
          translate([-phi_knob_in/2-w_knob/2, 0., -2*hh+0.5])
                    cylinder(d=1., h=e_knob, $fn=36, center=true);

     }
}

module right_turret(){
     difference(){
          union(){
               difference(){
                    rotate(180, [0, 0, 1]) half_turret();
                    translate([phi_knob_in/2+w_knob/2, 0.5, -1.5])
                         rotate(90, [1, 0, 0])
                         magnet();
                    translate([-phi_knob_in/2-w_knob/2, 0, 0.])
                         cube([w_knob+0.4, w_knob+0.4, hh+1.5], center=true);
                    translate([-phi_knob_in/2-w_knob/2, 0, -e_knob+hh/2-0.05])
                         cube([w_knob+0.4, w_knob+0.2, hh+0.5], center=true);
               }
               translate([-phi_knob_in/2-w_knob/2, 0., -2*hh+0.5])
                    cylinder(d=w_knob, h=hh, center=true, $fn=30);
          }
          translate([-phi_knob_in/2-w_knob/2, 0., -2*hh+0.6])
               cylinder(d=1.2, h=hh+0.6, center=true, $fn=30);
     }
}


right_turret();
/* right_grip(e=e_sphere, */
/*            phi_sphere=phi_sphere, */
/*            shift=clear/2); */


translate([-phi_knob_in/2-w_knob/2, 0, 0])
rotate([0, 0, 0])
translate([phi_knob_in/2+w_knob/2, 0, 0])
union(){
     left_turret();
     /* left_grip(e=e_sphere, */
     /*           phi_sphere=phi_sphere, */
     /*           shift=clear/2); */
}
