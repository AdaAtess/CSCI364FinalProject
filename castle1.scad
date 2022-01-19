

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
    walls_to_draw = 5;
    
    color("DarkGray") union() {
        // drawEnclosedWall(walls_to_draw);
        
        for (x = [0 : 1]) {
            for (y = [0 : 1]) {
                translate([
                    x * walls_to_draw * wall_length - x * 2 * wall_thickness, 
                    y * walls_to_draw * wall_length - y * 2 * wall_thickness, 0]) drawTower(2, 1.5);
            }
        }
        
        translate([
            0.5 * walls_to_draw * wall_length - 3 * wall_thickness, 
            0.5 * walls_to_draw * wall_length - 3 * wall_thickness, 0]) drawTower(6, 2);
    }
    
    translate([-25, -25, -0.1]) color("MediumSeaGreen") cube([50, 50, 0.1]);

    translate([0.5 * walls_to_draw * wall_length, 0.5 * walls_to_draw * wall_length, 2 * wall_height]) {
        union() {
            color("DarkGoldenrod") 
                cylinder(h = 2.5 * wall_height, r = 0.05, $fn = 30);
            color("Crimson") translate([0, 0, 2.2 * wall_height]) cube([0.5, 0.05, 0.2]);
        }
    }
}


module drawEnclosedWall(num_walls) { 
    difference() {
       union() {
            drawLongWall(0, num_walls);
            translate([num_walls * wall_length, 0, 0]) 
                drawLongWall(90, num_walls);
            translate([num_walls * wall_length, num_walls * wall_length, 0]) 
                drawLongWall(180, num_walls);
            translate([0, num_walls * wall_length, 0]) 
                drawLongWall(270, num_walls);
        }
       
        drawEntrance(0.5 * num_walls * wall_length);
    }
}

module drawTower(dim_scale, tower_height) {
    dim = dim_scale * wall_thickness;
    difference() {
        union() {
            cube([dim, dim, tower_height]);
            drawCrennelations(dim_scale * wall_thickness, tower_height);
            translate([dim, 0, 0]) rotate([0, 0, 90]) drawCrennelations(dim_scale * wall_thickness, tower_height);        
            translate([dim, dim, 0]) rotate([0, 0, 180]) drawCrennelations(dim_scale * wall_thickness, tower_height);        
            translate([0, dim, 0]) rotate([0, 0, 270]) drawCrennelations(dim_scale * wall_thickness, tower_height);
        }
        translate([0.45 * dim, -0.01 * dim, 0.7 * tower_height]) cube([0.1 * dim, 1.1 * dim, 0.1 * tower_height]);
        rotate([0, 0, 90]) translate([0.45 * dim, -1.01 * dim, 0.7 * tower_height]) cube([0.1 * dim, 1.1 * dim, 0.1 * tower_height]);
    }
}

module drawEntrance(x_offset) {
    x = x_offset - 0.4 * wall_length;
    y = -0.1 * wall_thickness;
    z = -0.1 * wall_height;
    
    translate([0, 0, -0.2 * wall_height]) union() {
        translate([x, y, z]) cube([0.8 * wall_length, 1.2 * wall_thickness, 0.6 * wall_height]);
        translate([x_offset, 1.1 * wall_thickness, 0.5 * wall_height]) {
            rotate([90, 0, 0]) {
                cylinder(h = 1.2 * wall_thickness, r = 0.4 * wall_length, $fn = 25, centre = true);
            }
        }
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
        drawCrennelations(wall_length, wall_height);
    }
}

module drawCrennelations(cren_length, cren_z_offset) {
    for (x = [0 : cren_period : cren_length - cren_period]) {
        translate([x, 0, cren_z_offset]) {
            cube([cren_duty_cycle * cren_period, cren_thickness, cren_height]);
        }
    }
}