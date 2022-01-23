module makeRoom(cube_size) {
    translate([cube_size / 2, cube_size / 2 , 0])
    cube([cube_size, cube_size, 0.5], center = true);
    translate([cube_size - 1, 0, 0])
    cube([1, cube_size, cube_size]);
    translate([0, cube_size - 1, 0])
    cube([cube_size, 1, cube_size]);
    cube([1, cube_size, cube_size]);
    cube([cube_size, 1, cube_size]);
}
makeRoom(10);
