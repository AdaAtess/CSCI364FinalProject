//Call function
door(10);


// Door module that brings together all elements
module door(cube_size) {
    // dimensions 
    height = 20;
    thick = 1;
    
    union(){
        cube([cube_size, thick, height]);
        translate([9,0,10]){
            scale([0.5,0.5,0.5]){
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
