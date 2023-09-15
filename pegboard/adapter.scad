
include <pegboard.scad>;

$fn = 50;

module main(){
    peg_hook_template(support=true);
    
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
}

main();