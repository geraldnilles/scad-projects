
include <../primitives/chamfers.scad>;

pillar_width = 3;
pillar_height = 10;
pillar_spacing = 15;
base_height = 1;

padding = 2;
translate([-padding,-padding,0]){
    cube([pillar_width+2*padding,pillar_spacing+2*padding, base_height]);
}


for( z= [0,10,20,30]){
    translate([0,0,z]){
        cube([pillar_width,pillar_spacing,base_height]);
        chamfered_cube(pillar_width,pillar_width,pillar_height,1);
        translate([0,pillar_spacing-pillar_width,0])
            chamfered_cube(pillar_width,pillar_width,pillar_height,1);
    }
}
