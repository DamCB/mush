

// contact lens

phi_cl = 13.8;
RC_cl = 8.6;
e_cl = 1;


module contact_lens(phi_cl, RC_cl, e_cl){
     d1_cl = sqrt(pow(RC_cl, 2) - pow(phi_cl/2, 2));
     translate([0, 0, e_cl-RC_cl])
     difference(){
	  difference(){
	       sphere(RC_cl+e_cl, $fn=36);
	       sphere(RC_cl, $fn=36);
	       translate([0, 0, -d1_cl]) cube([4 * RC_cl, 4*RC_cl,
					       2*d1_cl + RC_cl],
					      center=true);
	  }
     };
}


%contact_lens(phi_cl, RC_cl, e_cl);
