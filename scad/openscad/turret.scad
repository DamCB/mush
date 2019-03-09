use <dummies.scad>;

phi_knob_in = 20;
e_nob = 5.;

module turret(){
     difference(){
          union(){
               movement_sphere();
               knob(3, phi_knob_in, e_nob);
          }
          pizza_slice(r=25, w=10, theta=120);
     }
}


module half_turret(){
     difference(){
          turret();
          translate([-20, 0, -20]) cube([40, 40, 40]);
     }
}


module left_turret(){
     union(){
          difference(){
               half_turret();
               translate([phi_knob_in/2+1.25, -0.4, -1.5])
                    rotate(90, [1, 0, 0])
                    magnet();
          }
          translate([-phi_knob_in/2-2.5, 0., -3])
               rotate([0, 0, -6]) union(){
               cube([2.5, 1.25, 1.5]);
               translate([1.25, 1.5, 0])
                    union(){
                    cylinder(r=1.25, h=1.5, center=false, $fn=24);
                    cylinder(r=0.5, h=3, center=false, $fn=24);
               }
          }

     }
}

left_turret();

module right_turret(){
     difference(){
          rotate(180, [0, 0, 1]) half_turret();
          translate([-phi_knob_in/2-2.5, 0., -3.1])
               rotate([0, 0, -6]) union(){
               translate([-0.2, 0, 0]) cube([3., 3, 1.6]);
               translate([1.25, 1.5, 0])
                    cylinder(r=0.6, h=3, center=false, $fn=24);
          }
     }
}

right_turret();
