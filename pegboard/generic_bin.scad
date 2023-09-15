
include <pegboard.scad>;
include <../primitives/chamfers.scad>;



$fn=40;

height_units = 2;
width_units = 2;
length_mm = 50;

nozzle_thickness = 0.6;
wall_layers = 4;


module bin(){
    
}


module main(){
    
    peg_hook_template();
        

    
    bin();
    
}

difference(){
    main();



}