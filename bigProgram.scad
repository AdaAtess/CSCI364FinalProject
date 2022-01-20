module bigProgram(x,y,z,mlist) {
    //Maybe I should store everything in nested lists for the different levels, rows, columns?
    //or I could make getNeighbor module(s) that help me navigate the list
    for (zLoc=[0:10:((z-1)*10)]){
      for (yLoc=[0:10:((y-1)*10)]){
         for (xLoc=[0:10:((x-1)*10)]){
        //next line is a weird fix to get around the way variables work in SCAD
        position=(zLoc/10)*x*y+(yLoc/10)*x+xLoc/10;
        color("LightSkyBlue")
        translate([xLoc,yLoc,zLoc])
        chooseModule(x,y,z,mlist,position);
    }}}
    
}

//testing code goes here
//bigProgram(2,3,2,[18,18,8,9,10,20,0,0,1,1,19,0]);

//Some of the modules need to be adjusted to fit
//entirely in the cube and line up with each other
//I need to add/modify my versions of things with arguments that can vary what they are next to or on top of

module chooseModule(x,y,z,mlist,position){
    value=mlist[position];//get the code for the current cube
    //Remember that position starts at 0
    cube_size=10;
    if (value==1){
        makeFloor(10);}
    if (value==3){
        makeRoom(10);}
     if (value==4){
       threeRoomTowardsX(10);}
     if (value==5){
         threeRoomTowardsY(10);
        }  
     if (value==6){
         threeRoomAwayX(cube_size);
        }  
     if (value==7){
         threeRoomAwayY(cube_size);
        } 
    if (value==8){
        cornerRoomOrigin(cube_size);
        }  
    if (value==9){
        cornerRoomAlongX(cube_size);
        }     
    if (value==10){
       cornerRoomAlongY(cube_size);
        }     
     if (value==11){
        cornerRoomAlongXandY(cube_size);
        }     
     if (value==12){
        twoRoomAlongX(cube_size);
        }     
      
    if (value==18){
        translate([5,5,0])
        buildColumn(10);
    }
    if (value==19){
        cone_top_turret();}
    if (value==20){
        translate([0,5,0])
        arch();}
        
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