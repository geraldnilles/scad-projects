
include <pegboard.scad>;
include <../primitives/chamfers.scad>;


$fn = 20;
nozzle_width = 0.6;
wall_layers = 10;
wall_z = nozzle_width*wall_layers;

depth = 35+wall_z;
width = 75;
height_units = 2;



module plate(){
    plate_thickness = wall_z;
    plate_width = width+2*nozzle_width*wall_layers;
    plate_height = hole_pitch*height_units+hole_diameter;
    
    translate([-plate_width/2,-plate_thickness,0])
    chamfered_cube(plate_width,plate_thickness,plate_height,1.5);
}    

module hook(){

    hull(){
    translate([-wall_z/2,-wall_z,0])
        chamfered_cube(wall_z,wall_z,wall_z,1.5);
    translate([-wall_z-width/2,-wall_z-depth,0])
        chamfered_cube(wall_z,wall_z,wall_z,1.5);
    }
    
    hull(){
    translate([-wall_z-width/2,-wall_z-depth,0])
        chamfered_cube(wall_z,wall_z,wall_z,1.5);
    translate([-wall_z-width/2,-wall_z,height_units*hole_pitch])
        chamfered_cube(wall_z,wall_z,wall_z,1.5);
    }
    
    hull(){
    translate([-wall_z-width/2,-wall_z-depth,0])
        chamfered_cube(wall_z,wall_z,wall_z,1.5);
    translate([-wall_z/2,-wall_z-depth,height_units*hole_pitch])
        chamfered_cube(wall_z,wall_z,wall_z,1.5);
    }
    
    
    hull(){
    translate([-wall_z/2,-wall_z,0])
        chamfered_cube(wall_z,wall_z,wall_z,1.5);
    translate([width/2,-wall_z-depth,0])
        chamfered_cube(wall_z,wall_z,wall_z,1.5);
    }
    
    hull(){
    translate([width/2,-wall_z-depth,0])
        chamfered_cube(wall_z,wall_z,wall_z,1.5);
    translate([width/2,-wall_z,height_units*hole_pitch])
        chamfered_cube(wall_z,wall_z,wall_z,1.5);
    }

    hull(){
    translate([width/2,-wall_z-depth,0])
        chamfered_cube(wall_z,wall_z,wall_z,1.5);
    translate([-wall_z/2,-wall_z-depth,height_units*hole_pitch])
        chamfered_cube(wall_z,wall_z,wall_z,1.5);
    }


        

    
}


module main(){        
    plate();
    hook();
    
    translate([0,0,hole_diameter/2]){
        for ( x = [-1,0,1]){
            translate([x*hole_pitch,0,0]){
                peg_lower_support();
                translate([0,0,hole_pitch*2])
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