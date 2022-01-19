// https://gist.github.com/will-hart/df4b2ca99411218e364abef29bb5d26f 

// scale the wall up
wall_scale = 10;

// set wall proportions
wall_length = 1;
wall_thickness = 0.3;
wall_height = 0.8;

// crennelation properties
cren_duty_cycle = 0.5;
cren_period = 0.1;
cren_height = cren_duty_cycle * cren_period;
cren_thickness = cren_duty_cycle * cren_period;

scale(wall_scale) {
    drawEnclosedWall(5);
}

module drawEnclosedWall(num_walls) { 
   union() {
        drawLongWall(0, num_walls);
        translate([num_walls * wall_length, 0, 0]) 
            drawLongWall(90, num_walls);
        translate([num_walls * wall_length, num_walls * wall_length, 0]) 
            drawLongWall(180, num_walls);
        translate([0, num_walls * wall_length, 0]) 
            drawLongWall(270, num_walls);
    } 
}

module drawLongWall(rotation, num_walls) {
    rotate([0, 0, rotation]) union() {
        for(x = [0 : wall_length : (num_walls - 1) * wall_length]) {
            translate([x, 0, 0]) drawWall();
        }
    }
}

module drawWall() {
    union() {
        // wall base
        cube([wall_length, wall_thickness, wall_height]);

        // crennelations
        for (x = [0 : cren_period : wall_length - cren_period]) {
            translate([x, 0, wall_height]) {
                cube([cren_duty_cycle * cren_period, cren_thickness, cren_height]);
            }
        }
    }
}