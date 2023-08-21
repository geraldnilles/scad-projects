
union(){
//$fn = 100;

// Adding 2mm for margin
baffle_cutout_diameter = 45+1;
driver_depth = 30;

bolt_circle_diameter = 56; 
bolt_diameter = 3;
bolt_depth = 15;
bolt_height = 5;


// Adding 1mm for margin
plate_diamter = 66+2;
plate_height = 4;

roundover_radius = 25/8;

// Driver Coil
translate([0,0,-driver_depth])
    cylinder(driver_depth,d=baffle_cutout_diameter);

// Roundover for baffel cutout
rotate_extrude(angle=360)
    // Translate up and in 0.1mm to ensure intersection with the plate and baffle cutout cylinder
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

// Front Mouting Plate
// Extrea headroom for the speaker cone
cylinder(10+plate_height,d=plate_diamter);

}
