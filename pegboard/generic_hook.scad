
include <pegboard.scad>;

external_plate();

$fn=50;


module main(){
    hook_diameter = 7;
    depth = 25;
    
    
    
    translate([0,0,-hole_pitch+hole_diameter]){
        hull(){
            sphere(d=hook_diameter);
            translate([0,-depth,0]){
                sphere(d=hook_diameter);
                

            }

        }
        hull(){
            translate([0,-depth,0]){
                sphere(d=hook_diameter);
                translate([0,-hook_diameter,hook_diameter])
                    sphere(d=hook_diameter/2);


            }
        }
    }
    
}

difference(){
    main();
    huge=100;
    translate([0,huge/2-1,0])
    cube(huge,center=true);
}