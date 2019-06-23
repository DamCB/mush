module _lower_grip(){
     union(){
          difference(){
               union(){
                    hull(){
                         translate([0., -1.]) circle(0.5);
                         translate([1.25, -1.]) circle(0.5);
                    }
                    translate([0., -1]) square([1.75, 1]);
               }
               hull(){
                    circle(0.55);
                    translate([-0.95, 0.5]) circle(0.05);
                    translate([-1., -0.5]) square(1.);
                    translate([-0.95, -0.5]) circle(0.05);
               }
          }
     }
}


module _upper_grip(){
     union(){
          difference(){
               union(){
                    translate([-1.25, 0.5]) circle(1);
                    translate([-1.5, 0.5]) square(0.5);
                    hull(){
                         translate([-1., 1.]) circle(0.5);
                         translate([1.25, 1.]) circle(0.5);
                    }
                    translate([0., 0]) square([1.75, 1]);
               }
               hull(){
                    circle(0.55);
                    translate([-0.95, 0.5]) circle(0.05);
                    translate([-1., -0.5]) square(1.);
                    translate([-0.95, -0.5]) circle(0.05);
               }
          }
     }
}



module _grip(e=2.){
     union(){
          translate([0., -(e-1)/2]) _lower_grip();
          translate([0.55, -(e-1)/2]) square([1.2, e - 1]);
          translate([0., (e-1)/2]) _upper_grip();
     }
}


module left_grip(e=2., phi_sphere=20., shift=1.){
     angle = (2*(shift+1.75) / phi_sphere) * 180/3.1415926;
     difference(){
          union(){
               rotate([0, 10, 0]) rotate([0, 0, 90]) rotate([0, -90, 0])
                    rotate_extrude(angle=20){
                    rotate([0, 0, angle])
                         translate([phi_sphere/2, 0])
                         rotate([0, 0, -90]) _grip(e);}
          }
          union(){
               rotate([0, 0, 180]) translate([2.5, -15, 0]) rotate([0, -10, 0]) cube([30, 30, 30]);
               translate([2.2, -15, 0]) rotate([0, -10, 0]) cube([30, 30, 30]);
          }
     }
}

module right_grip(e=2., phi_sphere=20., shift=1.){
     mirror([0, 1, 0]) left_grip(e=e, phi_sphere=phi_sphere, shift=shift);
}

module _hole(e=2., phi_sphere=20., clear=4.)
{
     angle = (2*(clear/2. + 1.75) / phi_sphere) * 180/3.1415926;
     offset(r=0.15){
          union(){
               rotate([0, 0, angle])
                    translate([phi_sphere/2, 0])
                    union(){
                    rotate([0, 0, -90]) _grip(e=e);
                    translate([-e/2-1, -clear-1.]) square([2+e, clear]);
               }
               rotate([0, 0, -angle])
                    translate([phi_sphere/2, 0])
                    mirror([0, 1, 0])
                    union(){
                    rotate([0, 0, -90]) _grip(e=e);
                    translate([-e/2-1, -clear-1.]) square([2+e, clear]);
               }
               translate([phi_sphere/2+0.8, 0]) square([e+1, 2], center=true);
          }
     }
}
$fn = 360;
right_grip(e=2., phi_sphere=20., shift=3);
left_grip(e=2., phi_sphere=20., shift=3);

module sphere_hole(e=2, phi_sphere=20., clear=1, aperture=120){
     rotate([0, aperture/2, 0])
          rotate([0, 0, 90])
          rotate([0, -90, 0])
          rotate_extrude(angle=aperture){
          _hole(e=e, phi_sphere=phi_sphere, clear=clear);
     }
}
