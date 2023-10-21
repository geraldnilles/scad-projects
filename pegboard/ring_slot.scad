
include <pegboard.scad>;
include <../primitives/chamfers.scad>;

use <plate.scad>;


$fn = 20;
nozzle_width = 0.6;
wall_layers = 10;
wall_z = nozzle_width*wall_layers;

depth = 35+wall_z;
width = 75;
height_units = 3;
width_units = 4;



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
    //plate();
    hook();
    plate(width_units,height_units,wall_z);
    
    /*
    translate([-width/2,-depth,0])
        #cube([width,depth-wall_z, 50]);
    */

}

difference(){
    main();

}

//translate([-spacing_mm/2,-depth-wall_layers*nozzle_width,0])
//#cube([spacing_mm,depth,spacing_mm]);