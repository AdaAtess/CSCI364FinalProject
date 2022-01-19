module bigProgram() {
    
}

module emptyModule() {
}
module cone_top_turret(){
    $fa = 1;
    $fs = 0.4;
    $fn=64;
    color("white")
    translate([5,5,0])
    cylinder(h=5,d=10);
    color("#2BC176")
    translate([5,5,5])
    cylinder(h=5, r1=5, r2=0);
}
module arch() {
    $fa = 1;
$fs = 0.4;
$fn=64;
scale([0.16,0.16,0.16]){
pipebend (10,2,169,44);
}

module pipebend (thickness, id, od, ang) 
rotate([0,-90,0]){
    intersection (){
    difference(){
        torus (thickness, od);
        torus (id,od);
        }
    wedge (thickness, (od+thickness)/1.7,ang);
    }
 }
 

// ********* End of Module ***********


module torus (thickness, dia,)
rotate_extrude(convexity = 10) translate([dia/3, 0, 0]) circle(r = thickness/4) ;
// ********** End of Module **********



module wedge (thickness, rad, ang) 
translate ([0,0,-(thickness/2)-1]) {
linear_extrude (height = thickness+10) {
polygon(points=[
	[rad*cos(ang/2),-rad*sin(ang/2)],
	[0,0],
	[rad*cos(ang/2),rad*sin(ang/2)],
	[rad*cos(ang/3),rad*sin(ang/3)],
	[rad*cos(ang/6),rad*sin(ang/6)],
	[rad,0],
	[rad*cos(ang/6),-rad*sin(ang/6)],
	[rad*cos(ang/3),-rad*sin(ang/3)]],
paths=[[0,1,2,3,4,5,6,7]]);}
}
// ********* End of Module *******


module stackCylinder(vector, i = 0) {
    if (i < len(vector)) {
        cylinder(h=vector[i][0], d1=vector[i][1], d2=vector[i][2], $fn=vector[i][3]);
        translate([0,0,vector[i][0]]) stackCylinder(vector, i+1);
    }
}

numFacets = 30;
height = 50;
bottom = 8;
top = 6;
hSmallCyl1 = height/50;
hSmallCyl2 = height/30;

scale([0.16,0.16,0.16]){
translate([0,-18,0]){
stackCylinder([
    [height, bottom, top, numFacets],
    [hSmallCyl1, top + 0.5, top + 0.5, numFacets*3],
    [hSmallCyl2, top, bottom, numFacets*3]
]);

// small cube on top
x = bottom;
y = x;
z = 1.5;
centeringCube = -x/2;
translate([centeringCube, centeringCube, height + + hSmallCyl1 + hSmallCyl2]) 
{
    cube(size = [x,y,z]);
};
}
}

scale([0.16,0.16,0.16]){
translate([0,18,0]){
stackCylinder([
    [height, bottom, top, numFacets],
    [hSmallCyl1, top + 0.5, top + 0.5, numFacets*3],
    [hSmallCyl2, top, bottom, numFacets*3]
]);

// small cube on top
x = bottom;
y = x;
z = 1.5;
centeringCube = -x/2;
translate([centeringCube, centeringCube, height + + hSmallCyl1 + hSmallCyl2]) 
{
    cube(size = [x,y,z]);
};
}
}
}
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

module cornerRoomOrigin(cube_size) {
    translate([cube_size / 2, cube_size / 2, 0])
    cube([cube_size, cube_size, 0.5], center = true);
    cube([1, cube_size, cube_size]);
    cube([cube_size, 1, cube_size]);
}

module cornerRoomAlongX(cube_size) {
    translate([cube_size / 2, cube_size / 2 , 0])
    cube([cube_size, cube_size, 0.5], center = true);
    translate([cube_size - 1, 0, 0])
    cube([1, cube_size, cube_size]);
    cube([cube_size, 1, cube_size]);
}

module cornerRoomAlongY(cube_size) {
    translate([cube_size / 2, cube_size / 2 , 0])
    cube([cube_size, cube_size, 0.5], center = true);
    translate([0, cube_size - 1, 0])
    cube([cube_size, 1, cube_size]);
    cube([1, cube_size, cube_size]); 
}

module cornerRoomAlongXandY(cube_size) {
    translate([cube_size / 2, cube_size / 2 , 0])
    cube([cube_size, cube_size, 0.5], center = true);
    translate([cube_size - 1, 0, 0])
    cube([1, cube_size, cube_size]);
    translate([0, cube_size - 1, 0])
    cube([cube_size, 1, cube_size]);   
}

module makeFloor(cube_size) {
    translate([cube_size / 2, cube_size / 2, 0])
    cube([cube_size, cube_size, 0.5], center = true);
}

module oneRoomX(cube_size) {
    translate([cube_size / 2, cube_size / 2 , 0])
    cube([cube_size, cube_size, 0.5], center = true);
    cube([cube_size, 1, cube_size]);
}

module oneRoomY(cube_size) {
    translate([cube_size / 2, cube_size / 2 , 0])
    cube([cube_size, cube_size, 0.5], center = true);
    cube([1, cube_size, cube_size]);    
}

module oneRoomParallelX(cube_size) {
    translate([cube_size / 2, cube_size / 2 , 0])
    cube([cube_size, cube_size, 0.5], center = true);
    translate([cube_size - 1, 0, 0])
    cube([1, cube_size, cube_size]);  
}

module oneRoomParallelY(cube_size) {
    translate([cube_size / 2, cube_size / 2 , 0])
    cube([cube_size, cube_size, 0.5], center = true);
    translate([0, cube_size - 1, 0])
    cube([cube_size, 1, cube_size]); 
}

module threeRoomTowardsX(cube_size) {
    translate([cube_size / 2, cube_size / 2, 0])
    cube([cube_size, cube_size, 0.5], center = true);
    translate([cube_size, 0, 0])
    cube([1, cube_size + 1, cube_size]);
    translate([0, cube_size, 0])
    cube([cube_size, 1, cube_size]);
    cube([1, cube_size, cube_size]);
}

module threeRoomAwayX(cube_size) {
    translate([cube_size / 2, cube_size / 2 , 0])
    cube([cube_size, cube_size, 0.5], center = true);
    translate([cube_size - 1, 0, 0])
    cube([1, cube_size, cube_size]);
    cube([1, cube_size, cube_size]);
    cube([cube_size, 1, cube_size]);
}

module threeRoomTowardsY(cube_size) {
    translate([cube_size / 2, cube_size / 2 , 0])
    cube([cube_size, cube_size, 0.5], center = true);
    translate([cube_size - 1, 0, 0])
    cube([1, cube_size, cube_size]);
    translate([0, cube_size - 1, 0])
    cube([cube_size, 1, cube_size]);
    cube([cube_size, 1, cube_size]);
}

module threeRoomAwayY(cube_size) {
    translate([cube_size / 2, cube_size / 2 , 0])
    cube([cube_size, cube_size, 0.5], center = true);
    translate([0, cube_size - 1, 0])
    cube([cube_size, 1, cube_size]);
    cube([1, cube_size, cube_size]);
    cube([cube_size, 1, cube_size]);
}

module twoRoomAlongX(cube_size) {
    translate([cube_size / 2, cube_size / 2, 0])
    cube([cube_size, cube_size, 0.5], center = true);
    translate([0, cube_size, 0])
    cube([cube_size, 1, cube_size]);
    cube([cube_size, 1, cube_size]);
}

module twoRoomAlongY(cube_size) {
    translate([cube_size / 2, cube_size / 2 , 0])
    cube([cube_size, cube_size, 0.5], center = true);
    translate([cube_size - 1, 0, 0])
    cube([1, cube_size, cube_size]);
    cube([1, cube_size, cube_size]);
}

module createWall(wall_x, wall_y, wall_z) {
    translate([0,0, wall_z / 2])
    cube([wall_x, wall_y, wall_z], center = true);
}
module buildColumn(cubeSize) { 
    module stackCylinder(vector, i = 0) {
        if (i < len(vector)) {
            cylinder(h=vector[i][0], d1=vector[i][1], d2=vector[i][2], $fn=vector[i][3]);
            translate([0,0,vector[i][0]]) stackCylinder(vector, i+1);
        }
    }

    height = cubeSize;
    column(height);

    // ********* Column Module ***********
    module column(height) {
        bottomDiameter = height/2.5;
        numFacets = 30;
        topDiameter = bottomDiameter * 3/4;
        hSmallCyl1 = height/50;
        hSmallCyl2 = height/30;

        stackCylinder([
            [height, bottomDiameter, topDiameter, numFacets],
            [hSmallCyl1, topDiameter + 0.5, topDiameter + 0.5, numFacets*3],
            [hSmallCyl2, topDiameter, bottomDiameter, numFacets*3]
        ]);

        // flat cube on top
        x = bottomDiameter;
        y = x;
        z = bottomDiameter/7;
        centeringCube = -x/2;
        translate([centeringCube, centeringCube, height + hSmallCyl1 + hSmallCyl2]) 
        {
            cube(size = [x,y,z]);
        };
    }
}