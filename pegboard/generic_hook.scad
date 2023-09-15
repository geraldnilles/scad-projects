
include <pegboard.scad>;

external_plate();

$fn=50;


module main(){
    hook_diameter = 7;
    depth = 25;
    
    
    translate([0,0,hole_diameter*2]){
        hull(){
            sphere(d=hook_diameter);
            translate([0,-depth,0]){
                sphere(d=hook_diameter*2/3);
                

            }

        }
        hull(){
            translate([0,-depth,0]){
                sphere(d=hook_diameter*2/3);
                translate([0,-hook_diameter,hook_diameter])
                    sphere(d=hook_diameter/2);


            }
        }
        
        hull(){
            translate([0,1,hook_diameter])
                sphere(d=hook_diameter/4);
            translate([0,-hook_diameter,0])
                sphere(d=hook_diameter/4);
            translate([0,1,-hook_diameter])
                sphere(d=hook_diameter/4);
        }
    }
    
    module supports(){
        base = 5;
        translate([-base,-30,0])
            cube([base*2,25,0.2]);
        translate([0,-10,0])
            cylinder(h=hook_diameter,d1=base,d2=1);
        translate([0,-17.5,0])
            cylinder(h=hook_diameter+0.5,d1=base,d2=1);
        translate([0,-25,0])
            cylinder(h=hook_diameter+1,d1=base,d2=1);
    }
    supports();

    
}



difference(){
    main();
    huge=100;
    translate([0,huge/2,0])
    cube(huge,center=true);
    
}