
include <pegboard.scad>;
include <../primitives/chamfers.scad>;

external_plate();

$fn=40;
hook_pitch = 17;
hook_width = hook_pitch*0.4;
hook_diameter = 7;

depth = 30;

module hook(){
    
    translate([-hook_diameter/2,-depth,hole_pitch-hole_diameter/2]){
        chamfered_cube(hook_diameter,hook_diameter,hook_diameter+hole_diameter/2,1);
    }

    hull(){
    translate([-hook_diameter/2,-depth,hole_pitch-hole_diameter/2])
        chamfered_cube(hook_diameter,depth+2,hook_diameter,1);
    translate([0,0,hook_diameter])
        sphere(1);
    }
    

    
}

module loop(){
    translate([0,-depth*3/4,0]){
        translate([hook_pitch/2-hook_diameter/2,0,0]){
            chamfered_cube(hook_diameter,depth+2,hook_diameter,1);
        }
        translate([-hook_pitch/2-hook_diameter/2,0,0]){
            chamfered_cube(hook_diameter,depth+2,hook_diameter,1);
        }
        translate([-hook_pitch/2,0,0]){
            chamfered_cube(hook_pitch,hook_diameter,hook_diameter,1);
        }
    }
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
    translate([0,huge/2+1,0])
        cube(huge,center=true);
    translate([0,-depth*0.35,hook_pitch*1/3])
        cylinder(h=hole_pitch,d1=hook_pitch*0.6, d2=hook_pitch*1.3);

}