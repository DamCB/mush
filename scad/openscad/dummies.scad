// contact lens

phi_cl = 13.8;
RC_cl = 8.6;
e_cl = 1;
d1_cl = sqrt(pow(RC_cl, 2) - pow(phi_cl/2, 2));


$fn = 24;

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
     piston_z = 2.;
     l_piston = 30;
     translate([0, 0, piston_z])
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

piston_z = 2.;
center_z = 5;
sphere_phi_in = 20;
sphere_phi_out = 23.5;


module movement_sphere(){
translate([0, 0, center_z])
difference() {
     difference() {
	  sphere(sphere_phi_out/2);
	  sphere(sphere_phi_in/2);
     }
     translate([0, 0, -20]) cube([40, 40, 40], center=true);
     }
}


module sphere_band(w=10){
     difference(){
	  movement_sphere();
	  union(){
	  translate([20+w/2, 0, 10])
	       cube([40, 40, 40], center=true);
	  translate([-20-w/2, 0, 10])
	       cube([40, 40, 40], center=true);
	  }
     }

}

module rail(){
     difference(){
	  difference(){
	       sphere_band(15);
	       difference(){
		    union(){
			 translate([0, 0, 0.3]) sphere_band(6);
			 translate([0, 0, -0.3]) sphere_band(6);
		    }
		    translate([0, 0, -12])
			 cube([40, 40, 40], center=true);
	       }
	  }
     }
}

module knob(h, d_in, e){
     difference(){
	  cylinder(h=h, d=d_in+e, center=true);
	  cylinder(h=h+1, d=d_in, center=true);
	  }

     }

module turret(){
     union(){
	       rail();
	       translate([0, 0, 5.1])
	       knob(2, sphere_phi_in, 3.8);
     }
}


module rotation_knob(){
     color([0.6, 0.1, 0.1, 0.6])
     difference(){
	  translate([0, 0, 2.5])
	       knob(6.1, sphere_phi_out+0.2, 6);
	  translate([0, 0, 4.1])
	       knob(1.2, sphere_phi_in, 3);
     }
}

module focus_knob(){
     color([0.1, 0.6, 0.1, 0.6])
	  translate([0, 0, 1])
	       knob(5, sphere_phi_out+6.4, 6);
}

module loli_turret(phi, theta){
     rotate([0, 0, phi]) union() {
	  color([0.1, 0.4, 0.4, 0.5]) lolipop(-theta);
	  turret();
     }
}
