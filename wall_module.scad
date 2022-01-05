module createWall(wall_x, wall_y, wall_z) {
    translate([0,0, wall_z / 2])
    cube([wall_x, wall_y, wall_z], center = true);
}
createWall(wall_x=1,wall_y=10,wall_z=4);

