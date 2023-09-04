include <../rpi.scad>;
include <pegboard.scad>;


double_external_plate();

difference(){
translate([-hole_pitch,-16,-hole_pitch])
    difference(){
        cube([80,15,30]);
        translate([-0.1,1.6,1.6])
        cube([85,15-3,35]);
    }


translate([-25,-3,32])
rotate([0,90,-90]){
    model_rpi();
    pi_usbc_feed();
}
}
