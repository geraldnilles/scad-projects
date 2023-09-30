
include <pegboard.scad>;
include <../primitives/chamfers.scad>;


$fn = 20;

depth = 37;
spacing_mm = 75;

nozzle_width = 0.6;
wall_layers = 10;




module plate(){
    plate_thickness = wall_layers*nozzle_width;
    plate_width = spacing_mm+10+nozzle_width*wall_layers;
    plate_height = hole_pitch+hole_diameter;
    
    translate([-plate_width/2,-plate_thickness,0])
    chamfered_cube(plate_width,plate_thickness,plate_height,1.5);
}    

module hook(dir=1){
    x = 8;
    z = 10;
    y = 8/2;
    translate([-x/2,-y,0]){
        hull(){
        chamfered_cube(x,y,z*1.5,2);
        translate([0,-depth-7,0])
            chamfered_cube(x,y,z,2);
        }
        
        
        translate([0,-depth-7,0]){
            hull(){
            chamfered_cube(x,y,z,2);
            translate([dir*depth*1.2,0,0])
                chamfered_cube(x,y,z,2);
            }
        }
        
    }

    
}


module main(){        
    plate();
    translate([-spacing_mm/2-5,0,0])
        hook(1);
    translate([spacing_mm/2+5,0,0])
        hook(-1);
    
    translate([0,0,hole_diameter/2]){
        for ( x = [-1,0,1]){
            translate([x*hole_pitch,0,0]){
                peg_lower_support();
                translate([0,0,hole_pitch])
                    peg_hook();
            }
        }
    }

}

difference(){
    main();

}

//translate([-spacing_mm/2,-depth-wall_layers*nozzle_width,0])
//#cube([spacing_mm,depth,spacing_mm]);