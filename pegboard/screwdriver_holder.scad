
include <pegboard.scad>;

external_plate();

$fn=40;
hook_pitch = 15;
hook_width = hook_pitch*3/5;
hook_diameter = 7;

depth = 25;

module hook(){
    d = 3;
    
    
    
    translate([0,0,-hole_diameter]){
        hull(){
            translate([(hook_width-d)/2,0,0])
                sphere(d=d);
            translate([-(hook_width-d)/2,0,0])
                sphere(d=d);
            translate([0,0,-hook_width])
                sphere(d=d);
            translate([0,-depth,0]){
                sphere(d=hook_width);
                

            }

        }
        hull(){
            translate([0,-depth,0]){
                sphere(d=hook_width);
                translate([0,-hook_diameter,hook_diameter])
                    sphere(d=d);


            }
        }
    }
}

module loop(){
    translate([0,-hole_pitch/2+hole_diameter/2,-hole_pitch+hole_diameter]){
        rotate([35,0,0]){
            rotate_extrude(){
                translate([(hole_pitch-hole_diameter)/2,0,0]){
                    circle(d=hole_diameter);
                }
            }
        }
    }
    /*
    
    rotate([35,0,0])
        minkowski(){
            difference(){
                cylinder(h=hole_diameter/2,d=hole_pitch,center=true);
                cylinder(h=hole_diameter/2+1,d=hole_pitch-hole_diameter,center=true);

            }
            sphere(1);
        }
    */
}

module main(){
    
        
    
    loop();
    
    translate([hook_pitch/2,0,0])
        hook();
    translate([-hook_pitch/2,0,0])
        hook();
    
}

difference(){
    main();
    huge=100;
    translate([0,huge/2-1,0])
    cube(huge,center=true);
}