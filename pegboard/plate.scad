
include <pegboard.scad>;
include <../primitives/chamfers.scad>;





module plate(width_units, height_units,thickness){
    
    module block(){
        chamfered_cube(thickness,thickness,thickness,1.5);
    }
    
    module outer_cross(bottom_coords,top_coords){
        hull(){
            translate(bottom_coords[0])
                block();
            translate(top_coords[len(top_coords)-1])
                block();
        }
        hull(){
            translate(top_coords[0])
                block();
            translate(bottom_coords[len(bottom_coords)-1])
                block();
        }
    }
    
    module vertical_bars(bottom_coords,top_coords){
        for (i = [ 0 : len(bottom_coords) - 1 ]) 
        {
            hull(){
                translate(bottom_coords[i])
                    block();
                translate(top_coords[i])
                    block();
            }
        }
    }
    
    module bottom_bar(bottom_coords){
        hull(){
            translate(bottom_coords[0])
                block();
            translate(bottom_coords[len(bottom_coords)-1])
                block();
        }
    }
    
    module lower_supports(bottom_coords){
        for (i = [ 0 : len(bottom_coords) - 1 ]) {
            translate(bottom_coords[i])
                peg_lower_support();
        }
    }
    
    module top_supports(top_coords){
        for (i = [ 0 : len(top_coords) - 1 ]) {
            translate(top_coords[i])
                peg_hook();
        }
    }

    
    bottom_coords = [
        for (w_u = [-(width_units-1)/2:1:(width_units-1)/2]) 
            [w_u*hole_pitch,0,0]
        ];
        
    top_coords = [
        for (w_u = [-(width_units-1)/2:1:(width_units-1)/2]) 
            [w_u*hole_pitch,0,hole_pitch*height_units]
        ];
    translate([-thickness/2,-thickness,0]){
        outer_cross(bottom_coords,top_coords);
        vertical_bars(bottom_coords,top_coords);
        bottom_bar(bottom_coords);
        
    }
    translate([0,0,hole_diameter/2]){
        lower_supports(bottom_coords);
        top_supports(top_coords);
    }
    
}    


module main(){
    nozzle_width = 0.6;
    wall_layers = 10;
    thickness = nozzle_width*wall_layers;

    plate(4,2,thickness);


}

main();

//translate([-spacing_mm/2,-depth-wall_layers*nozzle_width,0])
//#cube([spacing_mm,depth,spacing_mm]);