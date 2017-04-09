

// contact lens

phi_cl = 13.8;
RC_cl = 8.6;
e_cl = 1;
d1_cl = sqrt(pow(RC_cl, 2) - pow(phi_cl/2, 2));


module contact_lens(phi_cl, RC_cl, e_cl, d1_cl){
     translate([0, 0, e_cl-RC_cl])
     difference(){
	  difference(){
	       sphere(RC_cl+e_cl, $fn=36);
	       sphere(RC_cl, $fn=36);
	       translate([0, 0, -d1_cl])
		    cube([4 * RC_cl, 4*RC_cl,
			  2*d1_cl + RC_cl],
			 center=true);
	  }
     };
}


%contact_lens(phi_cl, RC_cl, e_cl, d1_cl);

h=5;
module lens_tube(h, phi_cl, RC_cl, e_cl, d1_cl){
     translate([0, 0, -h-d1_cl+2*e_cl])
	  difference(){
	  cylinder(h=h, d=phi_cl+4*e_cl);
	  union(){
	       translate([0, 0, -e_cl/2])
		    cylinder(h=h+e_cl,
			     d=phi_cl+e_cl);
	       translate([0, 0, h-e_cl+0.1])
		    cylinder(h=e_cl, d=phi_cl+3*e_cl);
	  }
     }
}
lens_tube(h, phi_cl, RC_cl, e_cl, d1_cl);
