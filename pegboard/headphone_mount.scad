
include <pegboard.scad>;
include <../primitives/chamfers.scad>;

peg_hook_template(support=false);
// Add Fin support that is to be snipped off
    hull(){
        d1 = 1;
        d2 = 0.6;
        translate([0,hole_diameter,hole_pitch])
            sphere(d=d2);
        translate([0,hole_diameter+board_thickness,hole_pitch])
            sphere(d=d2);
        translate([0,hole_diameter,hole_pitch-board_thickness])
            sphere(d=d2);
    }

$fn=40;
length = 60;
diameter = 30;


module hook(){
    rotate([90,0,0])
        cylinder(h=length,d=diameter);
    translate([0,-length,0])
        rotate([90,0,0])
            cylinder(h=3,d=diameter+20);
    
}



module main(){
    
        
    translate([0,1,0])
    hook();
    
}

difference(){
    main();
    huge=1000;
    translate([0,huge/2+1,0])
        cube(huge,center=true);
    translate([0,0,-huge/2])
        cube(huge,center=true);


}