
solar_cell_x = 50;
solar_cell_y = 50;
solar_cell_z = 2.6;
solar_cell_corner_radius = 3;

pcb_x = 27;
pcb_y = 28;
pcb_z = 11;

screw_diamter = 4;
screw_head_diamter = 8;
screw_height = 15;


window_width_rel = 0.9;

$fn=100;


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

solar_cell();
pcb();
screws();
