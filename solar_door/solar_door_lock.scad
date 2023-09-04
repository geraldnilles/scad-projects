
solar_cell_x = 50;
solar_cell_y = 50;
solar_cell_z = 2.6;
solar_cell_corner_radius = 3;

pcb_x = 27;
pcb_y = 28;
pcb_z = 11;

screw_diamter = 3;
screw_head_diamter = 8;
screw_height = 15;

box_corner_radius = 5;

window_width_rel = 0.93;

$fn=70;


module solar_cell(){
    hull(){
    translate([solar_cell_x/2-solar_cell_corner_radius,
                solar_cell_y/2-solar_cell_corner_radius])
        cylinder(h=solar_cell_z, r=solar_cell_corner_radius);
    translate([solar_cell_x/2-solar_cell_corner_radius,
                -solar_cell_y/2+solar_cell_corner_radius])
        cylinder(h=solar_cell_z, r=solar_cell_corner_radius);
    translate([-solar_cell_x/2+solar_cell_corner_radius,
                solar_cell_y/2-solar_cell_corner_radius])
        cylinder(h=solar_cell_z, r=solar_cell_corner_radius);
    translate([-solar_cell_x/2+solar_cell_corner_radius,
                -solar_cell_y/2+solar_cell_corner_radius])
        cylinder(h=solar_cell_z, r=solar_cell_corner_radius);
    }
}

module pcb(){
    translate([solar_cell_x/2+pcb_x/2,0,-pcb_z/2+solar_cell_z])
    cube([pcb_x,pcb_y,pcb_z],center=true);
}


module screw(){
    translate([0,0,-screw_height])
    cylinder(screw_height,d=screw_diamter);
    cylinder(screw_height,d=screw_head_diamter);

}

module screws(){
    translate([solar_cell_x/2+pcb_x/2,pcb_y*3/4,-pcb_z/2])
        screw();
    translate([solar_cell_x/2+pcb_x/2,-pcb_y*3/4,-pcb_z/2])
        screw();
}

module box(){
    difference(){
        hull(){
            translate([solar_cell_x/2+pcb_x,solar_cell_y/2,0])
                sphere(r=box_corner_radius);
            translate([solar_cell_x/2+pcb_x,-solar_cell_y/2,0])
                sphere(r=box_corner_radius);
            translate([-solar_cell_x/2,solar_cell_y/2,0])
                sphere(r=box_corner_radius);
            translate([-solar_cell_x/2,-solar_cell_y/2,0])
                sphere(r=box_corner_radius);
            translate([solar_cell_x/2+pcb_x,solar_cell_y/2,-pcb_z])
                sphere(r=box_corner_radius);
            translate([solar_cell_x/2+pcb_x,-solar_cell_y/2,-pcb_z])
                sphere(r=box_corner_radius);
            translate([-solar_cell_x/2,solar_cell_y/2,-pcb_z])
                sphere(r=box_corner_radius);
            translate([-solar_cell_x/2,-solar_cell_y/2,-pcb_z])
                sphere(r=box_corner_radius);
            
        }
        // Cut off the bottom rounded edge
        // Pick a very large dimension for cutting an entire plane
        big = solar_cell_x*3;
        translate([-big/2,-big/2,-big-pcb_z+solar_cell_z])
            cube([big,big,big]);
        
        scale([window_width_rel,window_width_rel,2])
            solar_cell();
        
        hull(){
            solar_cell();
            translate([0,0,-big])
            solar_cell();
        }
        
        hull(){
            pcb();
            translate([0,0,-big])
            pcb();
        }
        
        screws();
        
    }
}

//solar_cell();
//pcb();
//screws();
box();