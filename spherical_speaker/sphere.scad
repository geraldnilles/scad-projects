speaker_depth = 200;
speaker_z_flat_height = 15;
speaker_y_flat_height = 15;

r = speaker_depth/2;
sphere_volume = 4/3*PI*r^3;
volume_z_cap = (1/3)*PI*speaker_z_flat_height^2*(3*r - speaker_z_flat_height);
volume_y_cap = (1/3)*PI*speaker_y_flat_height^2*(3*r - speaker_y_flat_height);

speaker_volume = sphere_volume - volume_z_cap - volume_y_cap;

// Speaker Volume (in liters
echo(speaker_volume/1e6);



driver_hole = 75;
bolt_cicle_diameter = 85;
bolt_hole = 2.5;

tweeter_hole = 46;
tweeter_bolt_circle_diamter = 56;

target_port_area = 707;
    port_x = 50;
    port_y = 104;
    port_z = target_port_area/port_x;

echo(port_x*port_z/100);

wall = 8;
$fn=60;
module box(){
    slice_y = speaker_depth/2-speaker_y_flat_height;
    slice_z = speaker_depth/2-speaker_z_flat_height;
    difference(){
        translate([0,slice_y,slice_z])
            sphere(d=speaker_depth);
        translate([0,0,-speaker_depth])
            cube(speaker_depth*2, center=true);
        translate([0,-speaker_depth,0])
            cube(speaker_depth*2, center=true);

    }
}

module shell(){
    difference(){
        minkowski(){
            box();
            sphere(wall);
        }
        box();
        
        translate([0,-wall+2,speaker_depth/2-speaker_z_flat_height])
        rotate([90,0,0]){
            include <dayton_pc83-4.scad>
        }
        
        
        translate([0,wall*2.2,speaker_depth*4/5])
        rotate([42,0,0]){
            include <dayton_nd25fa-4.scad>
        }
        
    }
}

module port(){

    translate([0,0,port_z/2])
        cube([port_x,port_y,port_z],center=true);
}

module port_shell(){
    translate([0,port_y/2-wall/2+wall,0])
    difference(){
        minkowski(){
            port();
            sphere(wall/2);
        }
        scale([1,1.5,1])
        port();
        
    }
}

//box();

// This funnel is is used for pouring resin into the the shell
module resin_cone(){
    size = 30;
    translate([0,
        speaker_depth-speaker_y_flat_height+wall/2,
        (speaker_depth-speaker_z_flat_height)/2-wall])
    rotate([-90,0,0])
        difference(){
        cylinder(h=size,d1=5, d2=size*2);
        translate([0,0,2])
            cylinder(30,d1=5, d2=60);
        }
}

// This chimney is for venting the resin pour
module resin_chimney(){
    size = 30;
    translate([size,
        speaker_depth-speaker_y_flat_height,
        (speaker_depth-speaker_z_flat_height)/2-wall])
    rotate([-90,0,0])
        cylinder(h=size,d=wall);
}


resin_cone();
resin_chimney();


difference(){
    union(){
    shell();
    port_shell();
    }
    translate([0,port_y/2-wall/2,0])
        scale([1,1.1,1])
        port();
}
