use <dummies.scad>;
use <detection.scad>;

sphere_phi_out = 72;
rail_phi = 100;
sphere_phi_in = 62;
stand_width = 12;
latitude = 30;



module ring(h, d_in, d_out){
     difference(){
          cylinder(d=d_out, h=h);
          translate([0, 0, -1])
               cylinder(d=d_in, h=h+2);
     }
}

module slider(){
     translate([0, -sphere_phi_out/2+1, 0]) rotate([90, 0, 0]) difference(){
          cylinder(d=6, h=8, center=true);
          cylinder(d=4, h=12, center=true);
     }
     translate([0, 0, -stand_width/2]) difference(){
          cylinder(h=stand_width, d=rail_phi);
          translate([0, 100-sphere_phi_out/2-0.5, 0]) cube([200, 200, 200], center=true);
          translate([70, 0, 0]) cube(100, center=true);
          translate([-70, 0, 0]) cube(100, center=true);
          union(){
               translate([0, 0, stand_width/2+2]) ring(h=6, d_in=rail_phi-4, d_out=rail_phi+2);
               translate([0, 0, -stand_width/2+2]) ring(h=6, d_in=rail_phi-4, d_out=rail_phi+2);
          }
     }
}

module sliders(){
     slider();
     rotate([0, 0, 180]) slider();
}

module rail(){
     difference(){
          translate([0, 0, -stand_width/2]) ring(h=stand_width, d_in=rail_phi-2, d_out=rail_phi+8);
          translate([0, 0, -stand_width/2+2]) ring(h=stand_width-4, d_in=rail_phi-3, d_out=rail_phi+4);
     }

}


sliders();
rotate([0, latitude, 0]) detection();
rail();
