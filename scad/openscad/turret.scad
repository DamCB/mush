use <dummies.scad>;

sphere_phi_in = 20;
sphere_phi_out = 24;

phi_knob_in = 20;
phi_knob_out = 25.4;
w_knob = (phi_knob_out - phi_knob_in)/2;
e_knob = 3;
hh = e_knob/3-0.1;

$fn = 100;

module turret(){
     difference(){
          union(){
               movement_sphere();
               ring(e_knob, phi_knob_in, phi_knob_out);
          }
          pizza_slice(r=25, w=10, dtheta=120);
     }
}


module half_turret(){
     difference(){
          turret();
          translate([-20, -0.05, -20]) cube([40, 40, 40]);
     }
}


module left_turret(){
     union(){
          difference(){
               half_turret();
               translate([phi_knob_in/2+w_knob/2, -0.5, -1.5])
                    rotate(90, [1, 0, 0])
                    magnet();
               translate([-phi_knob_in/2-w_knob/2, 0., -2*hh+0.3])
                    cube([w_knob+0.2, w_knob+0.2, hh+0.3], center=true);

          }
          translate([-phi_knob_in/2-w_knob/2, 0, -hh/2])
                    cylinder(d=w_knob, h=hh, $fn=36, center=true);
          translate([-phi_knob_in/2-w_knob/2, 0, -e_knob+hh/2])
                    cylinder(d=w_knob, h=hh, $fn=36, center=true);
          translate([-phi_knob_in/2-w_knob/2, 0., -2*hh+0.3])
                    cylinder(d=1., h=e_knob, $fn=36, center=true);

     }
}

left_turret();

module right_turret(){
     difference(){
          union(){
               difference(){
                    rotate(180, [0, 0, 1]) half_turret();
                    translate([phi_knob_in/2+w_knob/2, 0.5, -1.5])
                         rotate(90, [1, 0, 0])
                         magnet();
                    translate([-phi_knob_in/2-w_knob/2, 0, 0.3])
                         cube([w_knob+0.4, w_knob+0.4, hh+1.8], center=true);
                    translate([-phi_knob_in/2-w_knob/2, 0, -e_knob+hh/2])
                         cube([w_knob+0.2, w_knob+0.2, hh+0.3], center=true);
               }
               translate([-phi_knob_in/2-w_knob/2, 0., -2*hh+0.3])
                    cylinder(d=w_knob, h=hh, center=true, $fn=30);
          }
          translate([-phi_knob_in/2-w_knob/2, 0., -2*hh+0.3])
               cylinder(d=1.2, h=hh+0.4, center=true, $fn=30);
     }
}


right_turret();
