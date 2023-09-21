
include <pegboard.scad>;
include <../primitives/chamfers.scad>;


$fn = 20;

length_mm = 20;

nozzle_width = 0.6;
wall_layers = 8;



module plate(){
    plate_thickness = wall_layers*nozzle_width;
    plate_width = hole_pitch*0.9;
    plate_height = hole_pitch+hole_diameter;
    
    translate([-plate_width/2,-plate_thickness,0])
    chamfered_cube(plate_width,plate_thickness,plate_height,1.5);
}    

module hook(){
    depth = 20;
    r = 2;
    translate([0,-r,r])
    hull(){
        translate([10,,0,0])
            sphere(r);
        translate([-10,,0,0])
            sphere(r);
        translate([0,-depth,depth])
            sphere(r);
        translate([0,0,depth/2])
            sphere(r);
    }
}


module main(){        
    plate();
    hook();
    
    translate([0,0,hole_diameter/2]){
        peg_lower_support();
        translate([0,0,hole_pitch])
            peg_hook();
    }
}

difference(){
    main();

}