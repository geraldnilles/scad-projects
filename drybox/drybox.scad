spool_diameter = 202;
spool_height = 80;

wall_thickness = 7;
floor_thickness = 1.2;
height_margin = 0.2;


module spool(){
$fn=10;
translate([0,0,spool_diameter/2])
    rotate([90,0,0])
        cylinder(h=spool_height,d=spool_diameter,center=true);
}

module spool_inside(){  
    spool();
    translate([-spool_diameter/2,-spool_height/2,-spool_height*height_margin])
        cube([spool_diameter,spool_height,spool_diameter*(1+height_margin)/2]);
}

//spool_inside();

module spool_shell(){
    difference(){
        minkowski(){
            spool_inside();
            sphere(wall_thickness);
        }
        spool_inside();
    
    big = spool_diameter*1.5;
    translate([-big/2,-big/2,-big-spool_height*height_margin-floor_thickness])
        cube(big);
    }
}


module slice(){
    x = spool_diameter*1.5;
    y = spool_height*1.5;
    z = spool_diameter*1.5;
    hull(){
    translate([-x/2,-y/2,spool_diameter/2])
        cube([x,y,z]);
    
    translate([0,0,spool_diameter/8]){
        cube([1,1,1]);
    }
    }

}

module slice_inv(){
    x = spool_diameter*1.5*0.99;
    y = spool_height*1.5*0.99;
    z = spool_diameter*1.5*0.99;
    difference(){
        translate([-x/2,-y/2,-z/2])
            cube([x,y,z]);
        slice();
    }
}

module bottom(){
    difference(){
        spool_shell();
        slice();
    }
}

module top(){
    difference(){
        spool_shell();
        slice_inv();
    }
}


top();
//bottom();