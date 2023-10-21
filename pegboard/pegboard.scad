hole_pitch = 25.4;
hole_diameter = 5;
board_thickness = 5;
wall_thickness = 0.6*3;

$fn=20;

include <../primitives/chamfers.scad>;

module peg_lower_support(){
    // Thickness of the slot
    slot = hole_diameter/4;
    // 
    snap_offset = board_thickness+2;
    // Shift everything Down 1 peg hole

        difference(){
            union(){
                hull(){
                    translate([0,0,0.5])
                        sphere(d=hole_diameter+1);
                    translate([0,board_thickness*2,0])
                        sphere(d=hole_diameter);
                
                }
                translate([slot,snap_offset,0])
                    rotate([-90,0,0])
                        cylinder( h=hole_diameter,
                            d1=hole_diameter,d2=1);
                translate([-slot,snap_offset,0])
                    rotate([-90,0,0])
                        cylinder( h=hole_diameter,
                            d1=hole_diameter,d2=1);
            }
            translate([-slot/2,0,-hole_diameter]){
                cube([slot,board_thickness*3,hole_diameter*2]);
            }
        }
    
    
}

module peg_hook(){
    difference(){
        union(){
            hull(){
                sphere(d=hole_diameter);
                translate([0,board_thickness,0])
                    sphere(d=hole_diameter);
            }
            hull(){
                translate([0,board_thickness,0])
                    sphere(d=hole_diameter);
                translate([0,2*board_thickness,board_thickness])
                    sphere(d=hole_diameter);
            }
        }
        // Cutting off the edge of the hook
        translate([0,-hole_diameter/2,(hole_pitch/2)*sqrt(2)]){
            rotate([45,0,0])
                cube(hole_pitch,center=true);
        }
    }
    // Add Fin support that is to be snipped off
    hull(){
        d1 = 1;
        d2 = 1.2;
        translate([0,0,-hole_diameter/2])
            sphere(d=d2);
        translate([0,board_thickness,-hole_diameter/2])
            sphere(d=d2);
        translate([0,0,-hole_diameter/2-board_thickness])
            sphere(d=d2);
    }
    
}

module peg_plate_sharp(){
    difference(){
        linear_extrude(hole_pitch+hole_diameter,scale=[0.8,1.0])
                polygon([
                    [0,0],
                    [hole_diameter*1.5,0],
                    [hole_diameter*0.5,hole_diameter],
                    [-1*hole_diameter*0.5,hole_diameter],
                    [-1*hole_diameter*1.5,0],

                ]);
    translate([0,0,(hole_pitch+hole_diameter)*sqrt(2)])
        rotate([45,0,0])
            cube(hole_pitch,center=true);
    }
}

module peg_plate(support=false){
    r_mink = 0.25;
    // Shift the peg plat up to offset the minkowski
    translate([0,0,r_mink])
        minkowski(){
            peg_plate_sharp();
            sphere(r_mink,$fn=8);
        }
    if(support){
        translate([0,-3,0])
            cylinder(0.2,r=7);
    }
}

module peg_hook_template(support=false){
    translate([0,hole_diameter,hole_diameter/2])
        peg_lower_support();
    translate([0,hole_diameter,hole_pitch+hole_diameter/2])
        peg_hook();
    
    
    peg_plate(support);
    
}

module external_hook(){
    
    translate([hole_diameter*2,-hole_diameter-wall_thickness,0])
        rotate([90,0,0])
            linear_extrude(board_thickness)
                circle(d=hole_diameter);
    translate([0,-board_thickness-hole_diameter-wall_thickness,0])
    rotate([0,0,-75])
        rotate_extrude(angle=75)
            translate([hole_diameter*2, 0, 0])
                circle(d=hole_diameter);
}

module external_plate(support=false){
    y = hole_diameter+wall_thickness;
    // Subtract 1 mm for side by side tolerance purposes
    x = hole_pitch-1;
    z = hole_pitch+hole_diameter+wall_thickness;
    
    difference(){
        union(){
            translate([-x/2,0,0]){
                chamfered_cube(x, y, z,1);
            }
            if(support){
                brim_z=0.2;
                brim_r=6;
                for(a=[x/2,-x/2]){
                    translate([a,0,0])
                        cylinder(h=brim_z,r=brim_r);
                }
            }
        }
         
        translate([0,wall_thickness,-wall_thickness])
            minkowski(){
                peg_plate();
                sphere(0.25, $fn=5);
            }
     }
        
    
    
    // Push-off ribs.  These will push against the wall as it is inserted to toeh hook adapter, creating a snug fit
    rib_width = 3;
    for(a = [x/3, -x/3]){
        hull(){
            translate([a,
                    y-rib_width/4,
                    hole_pitch+rib_width])
                sphere(d=rib_width/2);
            translate([a,
                    y-rib_width/2,
                    rib_width])
                sphere(d=rib_width);
            translate([a,
                    y,
                    hole_pitch])
                sphere(d=rib_width);
        }
    }
    
    
    
}

module caliper_hook_sharp(){
    x_separation = 38;
    y_offset = 12.5;
    hook_length = 10;
    
    cube([hole_diameter,hole_diameter, hook_length]);
    translate([0,0,hook_length])
        cube([hole_diameter,hole_diameter*1.5, hole_diameter]);

    
    translate([x_separation, y_offset,0]){
        cube([hole_diameter,hole_diameter, hook_length]);
        translate([0,0,hook_length])
            cube([hole_diameter,hole_diameter*1.5, hole_diameter]);
        
    }
    
    cube([x_separation+hole_diameter,y_offset+hole_diameter,wall_thickness]);

}

module caliper_hook(){
    minkowski(){
        caliper_hook_sharp();
        sphere(0.25,$fn=5);
    }
}

module double_external_plate(){
    external_plate();
    translate([hole_pitch,0,0])
        external_plate();
}

/* Peg Board Adapter Part */
//peg_hook_template();


/* Accessories */
//double_external_plate();


/* External Hook to a*/
//external_hook();


/* Caliper Hook */
/*
translate([hole_pitch/2+6,-hole_diameter-wall_thickness,-22])
    rotate([90,-90,0])
        caliper_hook();
*/

//external_plate(true);

//peg_plate(true);

//peg_hook_template(true);
//peg_plate_sharp();