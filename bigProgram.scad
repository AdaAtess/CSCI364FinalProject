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
bigProgram(4,4,2,[19, 21, 0, 18, 10, 13, 2, 7, 21, 17, 8, 15, 18, 10, 18, 19, 11, 2, 5, 1, 17, 21, 19, 3, 1, 1, 1, 17, 11, 17, 8, 5]);

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
    if (value==13){
        twoRoomAlongY(cube_size);}
    if (value==14){
       oneRoomX(cube_size);}
    if (value==15){
        oneRoomY(cube_size);} 
    if (value==16){
        oneRoomParallelX(cube_size);}
    if (value==17){
        oneRoomParallelY(cube_size);}  
      
    if (value==18){
        translate([5,5,0])
        buildColumn(10);
    }
    if (value==19){
        cone_top_turret();
        }
    if (value==20){
        translate([0,5,0])
        arch();
        }
    if (value==21){
        portcullis(cube_size);
    }
    if (value==22){
        door(cube_size);
    }
    if (value==23){
        roof(cube_size);
    }
        
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
    translate([0, cube_size - 1, 0])
    cube([cube_size, 1, cube_size]); 
}

module oneRoomParallelY(cube_size) {
    translate([cube_size / 2, cube_size / 2 , 0])
    cube([cube_size, cube_size, 0.5], center = true);
    translate([cube_size - 1, 0, 0])
    cube([1, cube_size, cube_size]); 
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
        bottomDiameter = height/3;
        numFacets = 30;
        topDiameter = bottomDiameter * 3/4;
        hSmallCyl1 = height/50;
        hSmallCyl2 = height/30;

        // flat cube on top
        x = bottomDiameter;
        y = x;
        z = bottomDiameter/6;
        centeringCube = -x/2;

        stackCylinder([
            [height - hSmallCyl1 - hSmallCyl2 - z, bottomDiameter, topDiameter, numFacets],
            [hSmallCyl1, topDiameter + 0.5, topDiameter + 0.5, numFacets*3],
            [hSmallCyl2, topDiameter, bottomDiameter, numFacets*3]
        ]);

        translate([centeringCube, centeringCube, height - z]) 
        {
            cube(size = [x,y,z]);
        };
    }
}

//module portcullis to bring all together
module portcullis(cube_size) {
    sca = cube_size/100;
    translate([0,cube_size-(cube_size/2),0]){
        rotate([0,-90,0]){
            scale([sca,sca,sca]){
                width = 100;
                height = 100;
                line = ((width/2) -4) - 16;
                hline = 6;
                
                translate([0,-width/2,0]) vertical_side();
                translate([0,(width/2)-4,0]) vertical_side();
                
                translate([0,line,0]) vertical();
                translate([0,line - 16,0]) vertical();
                translate([0,line - 32,0]) vertical();
                translate([0,line - 48,0]) vertical();
                translate([0,line - 64,0]) vertical();
                
                translate([6,-width/2,0]) bottom_horizontal_front();
                translate([hline + 12.5,-width/2,0]) horizontal_front();
                translate([hline + 25,-width/2,0]) horizontal_front();
                translate([hline + 37.5,-width/2,0]) horizontal_front();
                translate([hline + 50,-width/2,0]) horizontal_front();
                translate([hline + 62.5,-width/2,0]) horizontal_front();
                translate([hline + 75,-width/2,0]) horizontal_front();
                translate([104.5-15,(-width/2)-4,0]) cube([4,96+12,1.7]);
                
                translate([height-11,-width/2+25,0]) hook();
                translate([height-11,(width/2)-25,0]) hook();
            }
      }
   }
}
//******** End of Module **********


//the bottom horizontal line w extra design on it
module bottom_horizontal_front() {
  cube([4,96,1.5]);
  translate([1,2,0]) cube([2,92,1.7]);
  translate([2,2,1.3]) cylinder(1,.5,.5, $fn=20);
  translate([2,2,.9]) cylinder(1,2,2, $fn=20);
  translate([2,10+3*12.7,.9]) cylinder(1,2,2, $fn=20);
  translate([2,94,.9]) cylinder(1,2,2, $fn=20);
  translate([2,94,1.3]) cylinder(1,.5,.5, $fn=20);
  for (i = [0 : 6]) {
    if(i != 3) {
      translate([2,10.5+i*12.5,.9]) cylinder(1,1.5,1.5, $fn=20);
    }
    translate([2,10.5+i*12.5,1.3]) cylinder(1,.5,.5, $fn=20);
    translate([2,10.5-4.2+i*12.5,1.1]) cylinder(1,.5,.5, $fn=20);
    translate([2,10.5+4.2+i*12.5,1.1]) cylinder(1,.5,.5, $fn=20);
  }
}
//******** End of Module **********


//horizontal front lines
module horizontal_front() {
  cube([4,96,1.5]);
  translate([1,2,0]) cube([2,92,1.7]);
  for (i = [0 : 6]) {
    translate([2,10.5+i*12.5,1.1]) cylinder(1,.5,.5, $fn=20);
  }
}
//******** End of Module **********


//vertical sides with designs on them
module vertical_side() { 
  cube([104.5-15,4,1.7]);
  translate([7,1,0]) cube([104.5-7-15,2,1.9]);
  for (i = [0 : 5]) {   //small circles on them
    translate([20.5+i*12.5,2,1.3]) cylinder(1,.5,.5, $fn=20);
  }
}
//******** End of Module **********


//vertical lines with triangular end
module vertical() { 
  translate([6,0,0]) cube([98.5-15,4,1]);
  difference() {
    cube([6,4,1.5]);
    translate([6,4,-1]) rotate([0,0,atan(2/6)+90]) cube([10,10,5]); //right tan side
    translate([6,0,-1]) rotate([0,0,90-atan(2/6)+90]) cube([10,10,5]); //left tan side
    translate([6,0,1.5]) rotate([-atan(1.5/6),0,90]) cube([10,10,5]); //on tan
  }
}
//******** End of Module **********


//tiny half circles on top
module hook() { 
  scale([1,2,1]) difference() {
    cylinder(1, 12.5/2, 12.5/2);
    translate([0,0,-1]) cylinder(4, 8/2, 8/2);
    translate([-10,-10,-1]) cube([10,20,4]);
  }
}
//******** End of Module **********





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





module roof(cube_size) {
    //constant dimensions
    width = 50;    
    depth = 20;   
    roof_height = 10;  
    
    points = [ 
        [0, 0, 0], [width, 0, 0], [width,depth, 0], [0, depth, 0], //rectangle base corners
        [width / 2, 0, roof_height], [width / 2,depth,roof_height]      //roof corners
    ];
    faces = [ 
        [0, 1, 2, 3],   // base
        [3, 4, 0],      // left triangle
        [1, 5, 2],      // right triangle
        [4, 5, 1, 0],   // front side
        [5, 4, 3, 2]    // back side
    ];
    x = cube_size/width;
    y = cube_size/depth;
    z = cube_size/depth;
    scale([x,y,z]){
        polyhedron(points, faces, convexity = 10);
    }
}
//******** End of Module ********




