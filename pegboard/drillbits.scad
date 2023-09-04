
include <pegboard.scad>;

external_plate();

bit_height = 15;
bit_width = 8;
wall_thickness = 3*0.4;

module bit(){
    translate([0,0,wall_thickness])
    cylinder(bit_height,d=bit_width,$fn=6);
}

module bit_array(rows=3,cols=4){
    for ( x = [0:rows-1])
        for ( y = [0:cols-1])
            translate([x*(bit_width+wall_thickness),y*(bit_width+wall_thickness),0])
                bit();
    


}

module bit_box(rows=3,cols=4)
{
        translate([-bit_width/2-wall_thickness,
                -bit_width/2-wall_thickness,
                0])    
        cube([rows*(bit_width+wall_thickness)+wall_thickness,
                cols*(bit_width+wall_thickness)+wall_thickness,
                bit_height]);
}

module main(rows=5,cols=5){
    translate([-(bit_width+wall_thickness)*(rows-1)/2,
            -(bit_width+wall_thickness)*(cols)+bit_width/2-wall_thickness,
            -hole_pitch-1.9])
        difference(){
            bit_box(rows,cols);
            bit_array(rows,cols);
        }
    }


main();