wire = 2.2;
width = 20;
height = 65;


difference(){
cylinder(h=height,d1=width/2,d2=width);


translate([-wire/2,-width/2,-0.01])
    cube([wire,width,wire*2]);
    
translate([-width/2,-wire/2,-0.01])
    cube([width,wire,wire]);
}