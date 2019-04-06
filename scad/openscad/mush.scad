use <dummies.scad>;
use <turret.scad>;
use <focus_knob.scad>;
use <grip.scad>;
use <detection.scad>;

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
$fn = 100;


right_turret();
right_grip(e=e_sphere,
           phi_sphere=phi_sphere,
           shift=clear/2);
union(){
     left_turret();
     left_grip(e=e_sphere,
               phi_sphere=phi_sphere,
               shift=clear/2);
}

light_rig(phi_in=12);
detection();
%translate([0, 0, -15]) rotate([0, 180, 0]) mock_focus();
