
include <pegboard.scad>;


$fn = 20;


height_units = 2;
width_units = 3;
length_mm = width_units*20;

nozzle_thickness = 0.6;
wall_layers = 4;

module back_wall(x,z,r){
    hull(){
        for(ix = [0,x]){
            for (iz = [0,z]){
                translate([ix,0,iz])
                    sphere(r);
            }
        }
    }
    
}

module floor_wall(x,y,r){
    hull(){
        for(ix = [0,x]){
            for (iy = [0,-y]){
                translate([ix,iy,0])
                    sphere(r);
            }
        }
    }
    
}

module side_wall(y,z,r){
    hull(){
        for(iy = [0,-y]){
            for (iz = [0,z]){
                translate([0,iy,iz])
                    sphere(r);
            }
        }
    }
    
}

module gate(x,z,r){
    hull(){
        translate([0,0,0])
            sphere(r);
        translate([x,0,0])
            sphere(r);
        translate([0,-z/2,z/2])
            sphere(r);
        translate([x,-z/2,z/2])
            sphere(r);
    }
    
    for( xi = [0,x]){
        hull(){
            translate([xi,0,0])
                sphere(r);
            translate([xi,-z/2,z/2])
                sphere(r);
            translate([xi,0,z/2])
                sphere(r);
        }
    }    
    
}


module bin(){
    r = wall_layers*nozzle_thickness/2;
    
    // Rede x by a bit to make room for multiple bins side by side
    x = width_units * hole_pitch-r*4;
    z = height_units * hole_pitch+hole_diameter/2;
    y = length_mm;

    back_wall(x,z,r);
    floor_wall(x,y,r);
    side_wall(y,z,r);
    translate([x,0,0])
        side_wall(y,z,r);
    translate([0,-y,0])
        gate(x,z,r);
}

module hooks(){
    translate([0,0,hole_pitch*height_units])
        for (xi = [0:1:width_units-1]){
            translate([xi*hole_pitch,0,0])
            peg_hook();
        }
}

module lower_supports(){
    for (xi = [0:1:width_units-1]){
            translate([xi*hole_pitch,0,0])
            peg_lower_support();
        }
}

module main(){        

    
    bin();
    
    r = wall_layers*nozzle_thickness/2;
    // Shift the pegs up so that the lower supports are flat with the bottom of the bin
    translate([hole_pitch/2-r*2,r,hole_diameter/2-r]){
        hooks();
        lower_supports();
    }
}

difference(){
    main();



}