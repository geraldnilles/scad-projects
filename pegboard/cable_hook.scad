
include <pegboard.scad>;

external_plate();

prong_gap = 5; 
prong_diameter = 5;
prong_length = 35;
prong_angle = 25;


module prong(){
    difference(){
        rotate([-prong_angle,0,0]){
            hull(){
                sphere(d=prong_diameter);
                translate([0,-prong_length,0])
                    sphere(d=prong_diameter);
            }
        }
        translate([-prong_diameter,-wall_thickness/2,-prong_diameter]){
            cube(prong_diameter*2);
        }
    }
}

module main(){
    translate([0,0,-hole_pitch/2]){
        translate([prong_gap*2,0,0])
            prong();
        translate([-prong_gap*2,0,0])
            prong();
        
        prong();
    }
    translate([0,-prong_diameter*3/5,-hole_pitch/2])
        hull(){
        translate([-2*prong_diameter,0,0])
            sphere(d=prong_diameter);
        translate([2*prong_diameter,0,0])
            sphere(d=prong_diameter);
        }
    
}

main();