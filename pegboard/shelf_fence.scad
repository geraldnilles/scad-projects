fence_height = 15;
fence_thickness = 0.6*4;

wire = 3.3;
width = 26;

$fn = 100;



module plate(){
    x = width+wire;
    y = fence_height;
    z = fence_thickness;
    
    translate([-wire,-wire/2+0.5,0])
    cube([x,y,z]);
}

module wires(){
    pitch = width-wire;
    translate([0,0,-5]){
    cylinder(h=10,d=wire);
    translate([pitch,0,0])
        cylinder(h=10,d=wire);
    }
}

difference(){
    plate();
    wires();
}
