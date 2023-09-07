hole_pitch = 25.4;
hole_diameter = 5;
board_thickness = 5;
wall_thickness = 0.4*3;

$fn=20;

module peg_lower_support(){
    // Thickness of the slot
    slot = hole_diameter/4;
    // 
    snap_offset = board_thickness+2;
    // Shift everything Down 1 peg hole
    translate([0,0,-hole_pitch]){
        difference(){
            union(){
                hull(){
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
    
}

module peg_hook(){
    hull(){
    sphere(d=hole_diameter+1);
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

module peg_plate_sharp(){
    translate([0,-hole_diameter,hole_diameter/2])
    rotate([0,180,0])
    linear_extrude(hole_pitch+hole_diameter,scale=[1.2,1.0])
        polygon([
            [0,0],
            [hole_diameter*1.5,0],
            [hole_diameter*0.5,hole_diameter],
            [-1*hole_diameter*0.5,hole_diameter],
            [-1*hole_diameter*1.5,0],

        ]);
    /*
    translate([hole_pitch/2,0,0])
    cube([hole_pitch+hole_diameter*2,
            plate_thickness,
            hole_diameter],
            center=true);
    */
}

module peg_plate(){
    minkowski(){
        peg_plate_sharp();
        sphere(0.25,$fn=5);
    }
    translate([0,-hole_diameter,-hole_pitch-hole_diameter/2-0.25])
        cylinder(0.2,5);
}

module peg_hook_template(){
    translate([0,hole_diameter,0]){
        peg_lower_support();
        peg_hook();
        peg_plate();
    }
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

module external_plate(){
    y = hole_diameter+wall_thickness;
    x = hole_pitch-1;
    z = hole_pitch+hole_diameter+wall_thickness;
    
    difference(){
        translate([-x/2,-wall_thickness,-z+hole_diameter/2+wall_thickness*1.5])
            cube([x, y, z]);
        minkowski(){
            translate([0,hole_diameter,0])
                peg_plate();
            sphere(0.25, $fn=5);
        }
    }
    
    // Push-off ribs.  These will push against the wall as it is inserted to toeh hook adapter, creating a snug fit
    rib_width = 2;
    hull(){
        translate([x/3,hole_diameter-rib_width,-hole_pitch])
            cube(rib_width);
        translate([x/3,hole_diameter,0])
            cube(rib_width);
    }
    
    hull(){
        translate([-x/3-rib_width,hole_diameter-rib_width,-hole_pitch])
            cube(rib_width);
        translate([-x/3-rib_width,hole_diameter,0])
            cube(rib_width);
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
