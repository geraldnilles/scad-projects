
include <pegboard.scad>;
include <../primitives/chamfers.scad>;


$fn = 20;

length_mm = 70;
spacing_mm = 75;

nozzle_width = 0.6;
wall_layers = 10;




module plate(){
    plate_thickness = wall_layers*nozzle_width;
    plate_width = spacing_mm+nozzle_width*wall_layers;
    plate_height = hole_pitch+hole_diameter;
    
    translate([-plate_width/2,-plate_thickness,0])
    chamfered_cube(plate_width,plate_thickness,plate_height,1.5);
}    

module hook(){
    x = nozzle_width*wall_layers;
    z = x*2;
    translate([-x/2,-length_mm,0]){
        translate([spacing_mm/2,0,0]){
            chamfered_cube(x,length_mm,z,2);
            rotate([25,0,0])
                chamfered_cube(x,x,z*2,2);
            
        }
        translate([-spacing_mm/2,0,0]){
            chamfered_cube(x,length_mm,z,2);
            rotate([25,0,0])
                chamfered_cube(x,x,z*2,2);
        }
    }
    
}


module main(){        
    plate();
    hook();
    
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