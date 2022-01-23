//Call function
door(10);


// Door module that brings together all elements
module door(cube_size) {
    // dimensions
    width = cube_size/2; 
    height = 10;
    thick = 1;
    x = 1;
    y = thick;
    z = cube_size/10;
    sca = (cube_size/200)*5; //scaling for handle varying w cube_size
    handlex = 9*(cube_size/20); //handle translations according to cube_size
    handley = 0;
    handlez = 10*(cube_size/20); 
    union(){
        scale([x, y, z]){
            cube([width, thick, height]);
            translate([width,0,0]){
                cube([width, thick, height]);
            }
            translate([0,0,0]){
                cube([width/2, thick, height]);
            }
            translate([width/2,-0.1,0]){
                cube([0.5, thick, height]);
            }
            translate([width+width/2,-0.1,0]){
                cube([0.5, thick, height]);
            }
        }
        translate([handlex+(width/2),handley,handlez]){
            scale([sca,sca,sca]){
                handle();
                round_knob();
            }
        }
    }
}
//********* End of Module ***********


module round_knob() {
    translate([0,-2,0])
        sphere(d=2);
    rotate([90,0,0])
        cylinder(d=1, h=2);
}
//********* End of Module ***********


module handle() {
    rotate([90,0,0])
        cylinder(d=1, h=2);
    translate([0,-2,0]) {
        rotate([0,-90,0])
            cylinder(d=1, h=4);
        sphere(d=1);
    }
}
//********* End of Module ***********
