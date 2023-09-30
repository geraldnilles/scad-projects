
include <pegboard.scad>;
include <../primitives/chamfers.scad>;


$fn = 20;

drill_diameter = 60;
spacing_mm = 77;

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
    translate([-4,-20,0])
    chamfered_cube(8,20,10,2);
    $fn=6;
    translate([0,-35,29.7])
    rotate([-90,-0,90])
    rotate_extrude(angle=180)
        translate([drill_diameter/2,0,0])
            rotate([0,0,30])
            circle(d=10);
    
}


module main(){        
    plate();
    translate([-spacing_mm/2,0,0])
        hook();
    translate([spacing_mm/2,0,0])
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