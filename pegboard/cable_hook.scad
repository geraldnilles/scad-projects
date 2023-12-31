
include <pegboard.scad>;

external_plate();

$fn=50;
hook_pitch = 9;
hook_width = hook_pitch*3/5;
hook_diameter = 7;

depth = 25;

module hook(){
    d = 3;
    
    
    
    translate([0,0,-hole_pitch+hole_diameter]){
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
                    sphere(d=d/2);


            }
        }
    }
}

module main(){
    hook();
    translate([hook_pitch,0,0])
        hook();
    translate([-hook_pitch,0,0])
        hook();
    
}

difference(){
    main();
    huge=100;
    translate([0,huge/2-1,0])
    cube(huge,center=true);
}