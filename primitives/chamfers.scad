


module chamfered_cube(x,y,z,edge){
    difference(){
        cube([x,y,z]);
        
        
        // Buttom Cuts
        translate([0,0,(-sqrt(2)*(edge))/2])
            rotate([45,0,0])
                cube([x,edge,edge]);
        
        translate([0,y,(-sqrt(2)*(edge))/2])
            rotate([45,0,0])
                cube([x,edge,edge]);
        
        translate([0,0,(-sqrt(2)*(edge))/2])
            rotate([0,-45,0])
                cube([edge,y,edge]);
        
        translate([x,0,(-sqrt(2)*(edge))/2])
            rotate([0,-45,0])
                cube([edge,y,edge]);
        
        // Top Cuts
        translate([0,0,z-(sqrt(2)*(edge))/2])
            rotate([45,0,0])
                cube([x,edge,edge]);
        
        translate([0,y,z-(sqrt(2)*(edge))/2])
            rotate([45,0,0])
                cube([x,edge,edge]);
        
        translate([0,0,z-(sqrt(2)*(edge))/2])
            rotate([0,-45,0])
                cube([edge,y,edge]);
        
        translate([x,0,z-(sqrt(2)*(edge))/2])
            rotate([0,-45,0])
                cube([edge,y,edge]);
                
        // Side Cuts
        translate([0,-(sqrt(2)*(edge))/2,0])
            rotate([0,0,45])
                cube([edge,edge,z]);
                
        translate([x,-(sqrt(2)*(edge))/2,0])
            rotate([0,0,45])
                cube([edge,edge,z]);
                

        translate([0,y-(sqrt(2)*(edge))/2,0])
            rotate([0,0,45])
                cube([edge,edge,z]);
                
        translate([x,y-(sqrt(2)*(edge))/2,0])
            rotate([0,0,45])
                cube([edge,edge,z]);

        
    }
  
}


module chamfered_box(x,y,z,edge,wall_thickness){
    difference(){
        chamfered_cube(x,y,z,edge);
        
        translate([wall_thickness, wall_thickness,wall_thickness])
            chamfered_cube(x-wall_thickness*2,
                       y-wall_thickness*2,
                       z-wall_thickness*2,
                       edge/sqrt(2));
            
    }
}

module chamfered_square_ring(x,y,thickness,edge){
    chamfered_cube(x,thickness,thickness,edge);
    chamfered_cube(thickness,y,thickness,edge);
    translate([0,y-thickness,0])
        chamfered_cube(x,thickness,thickness,edge);
    translate([x-thickness,0,0])
        chamfered_cube(thickness,y,thickness,edge);

}

module chamfered_main(){
    chamfered_square_ring(10,20,3,1);
    
}

//chamfered_main();