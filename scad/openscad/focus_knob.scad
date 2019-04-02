

module inner_barrel(phi_in=23.9, phi_out=38, hh=13.5){
     difference(){
          cylinder(d=phi_out, h=hh, center=true);
          cylinder(d=phi_in, h=hh+0.4, center=true);
     }
}

module outer_barrel(phi_in1=38.1, phi_out1=41.7, h1=21.7, phi_out2=26, h2=3.6, phi_in2=23){

     difference(){
          union(){
               translate([0, 0, (h1+h2)/2])
                    cylinder(d=phi_out2, h=h2+0.2, center=true);
               cylinder(d=phi_out1, h=h1, center=true);
          }
          union(){
               translate([0, 0, (h1+h2)/2])
                    cylinder(d=phi_in2, h=h2+5, center=true);
               translate([0, 0, -2]) cylinder(d=phi_in1, h=h1, center=true);
          }
     }
}



module mock_focus(){
     inner_barrel();
     outer_barrel();
}

mock_focus();
