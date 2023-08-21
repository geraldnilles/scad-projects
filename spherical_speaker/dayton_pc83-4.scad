
union(){
//$fn = 100;

baffle_cutout_diameter = 77;
driver_depth = 46.5;

bolt_circle_diameter = 92; 
bolt_diameter = 3;
bolt_depth = 15;
bolt_height = 5;

plate_diamter = 101;
plate_height = 2;

roundover_radius = 25/6;

// Driver Coil
translate([0,0,-driver_depth])
    cylinder(driver_depth,d=baffle_cutout_diameter);

// Roundover for baffel cutout
rotate_extrude(angle=360)
    translate([baffle_cutout_diameter/2-0.1,-roundover_radius+0.1,])
        //rotate([0,90,0])
        difference(){
            square(roundover_radius);
            translate([roundover_radius,0,0])
            circle(r=roundover_radius);
        }


rotate([0,0,45])
// Front Mouting Screws
for ( i = [bolt_circle_diameter/2,-bolt_circle_diameter/2]){
    translate([i,0,-bolt_depth])
        cylinder(bolt_depth+bolt_height,d=bolt_diameter);
    translate([0,i,-bolt_depth])
        cylinder(bolt_depth+bolt_height,d=bolt_diameter);
}

// Basic circular plate 
//cylinder(plate_height,d=plate_diamter);



// Rounded Square Mouting Plate
intersection(){
    // Imaginary chord between the left and right tips of the plate
    // 2mm added for margin
    c=sqrt(2*((plate_diamter+2)/2)^2);
    
    // Height of the the plate at the center 
    // 2mm added for margin
    h = 83+2;
    // Distance between the chord and the top of the bow
    a = (h - c)/2;
    // THe radius of the circuit that would intersect with the corners and the tip of the bow
    r = ((c/2)^2 - a^2)/(2*a);
    echo (r);
    
    // How much each circle needs to be translated to intersect 
    y = r-h/2;
    translate([y,0,0])
        cylinder(plate_height,d=r*2);
    translate([-y,0,0])
        cylinder(plate_height,d=r*2);
    translate([0,y,0])
        cylinder(plate_height,d=r*2);
    translate([0,-y,0])
        cylinder(plate_height,d=r*2);
}

}



    
