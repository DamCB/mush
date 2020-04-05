use <detection.scad>;
$fn=120;
sphere_phi_out = 72;
sphere_phi_in = 62;
stand_width = 12;

module rotation_ring(){
     translate([0, 0, -stand_width/2]) difference(){
          cylinder(d=sphere_phi_out+2*stand_width, h=stand_width);
          translate([0, 0, -1])
               cylinder(d=sphere_phi_out+2, h=stand_width+2);
     }
}
rotation_ring();
detection($fn=120);
