

// contact lens

phi_cl = 13.8;
RC_cl = 8.6;
e_cl = 1;
d1_cl = sqrt(pow(RC_cl, 2) - pow(phi_cl/2, 2));


$fn = 72;

module contact_lens(phi_cl, RC_cl, e_cl, d1_cl){
     translate([0, 0, RC_cl-e_cl])
     difference(){
	  difference(){
	       sphere(RC_cl+e_cl);
	       sphere(RC_cl);
	       translate([0, 0, d1_cl])
		    cube([4 * RC_cl, 4*RC_cl,
			  2*d1_cl + RC_cl],
			 center=true);
	  }
     };
}



h=5;
module lens_tube(h, phi_cl, RC_cl, e_cl, d1_cl){
     translate([0, 0, RC_cl-d1_cl])
	  union(){
	  translate([0, 0, h])
	       difference(){
	       cylinder(h=e_cl, d=phi_cl+4*e_cl);
	       translate([0, 0, -e_cl/2])
	       cylinder(h=2*e_cl, d=5.2);
	       }
	  difference(){
	       cylinder(h=h, d=phi_cl+4*e_cl);
	       union(){
		    translate([0, 0, -e_cl/2])
		    cylinder(h=h+e_cl,
			     d=phi_cl+e_cl);
		    translate([0, 0, e_cl/2])
		    cylinder(h=e_cl, d=phi_cl+3*e_cl);
	  }
     }}
}


module piston(){
     z_piston = 2.;
     l_piston = 30;
     translate([0, 0, z_piston])
	  union(){
	  cylinder(h=l_piston, d=5);
	  cylinder(h=1., d=phi_cl*0.8);
     }
}

module lolipop(theta){
     center_z = 5;
     translate([0, 0, center_z])
     rotate([theta, 0, 0])
     translate([0, 0, -center_z])
	  union(){
	  contact_lens(phi_cl, RC_cl, e_cl, d1_cl);
	  lens_tube(h, phi_cl, RC_cl, e_cl, d1_cl);
	  piston();
	  }
     }

theta=30;
z_piston = 2.;
center_z = 5;

%lolipop(0);
lolipop(theta);
%lolipop(-theta);

module movement_sphere(){
%translate([0, 0, center_z])
difference() {
     difference() {
	  sphere(16);
	  sphere(15);
     }
     translate([0, 0, -20]) cube([40, 40, 40], center=true);
     }
}

module rail(){
     //rail
     }

movement_sphere();
