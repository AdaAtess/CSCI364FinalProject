//building
scale([0.5,0.5,0.5]){
    building();
}
module building(){
    rotate([0,-90,0]){
        scale([0.1,0.1,0.1]){
            //translate([0,-50,0]){
                portcullis();
            //}
        }
     }
     scale([1,1.5,1]){
         translate([0,-18.5,0]){
             rotate([0,0,90]){
                 wall();
                 }
         }
     }
     translate([0,-50,0]){
         tower();
     }
     translate([15,-50,0]){
         rotate([0,0,0]){
             wall();
         }
     }
     translate([35,-50,0]){
         rotate([0,0,0]){
             wall();
         }
     }
     translate([50,-50,0]){
         tower();
     }
     scale([1,1.5,1]){
         translate([50,-19,0]){
             rotate([0,0,90]){
                 wall();
             }
         }
     }
     translate([50,-2.5,0]){
         arch();
     }
     translate([50,2.5,0]){
         arch();
     }
     scale([1,1.5,1]){
         translate([50,19,0]){
             rotate([0,0,90]){
                 wall();
             }
         }
     }
     translate([50,50,0]){
         tower();
     }
     translate([35,50,0]){
         rotate([0,0,0]){
             wall();
         }
     }
     translate([15,50,0]){
         rotate([0,0,0]){
             wall();
         }
     }
     translate([0,50,0]){
         tower();
     }
     scale([1,1.5,1]){
         translate([0,18.5,0]){
             rotate([0,0,90]){
                 wall();
             }
         }
     }
     makeFloor(50);
     translate([0,-50,0]){
     makeFloor(50);
     }
     
}


            

module wall(dims=[30, 3, 10])
{
    translate([0, 0, dims[2]/2])
    cube(dims, center=true);
    
}

module tower(height = 15)
{
    translate([0, 0, height/2])
    union()
    {
        cylinder(d=height/3, h=height, center=true);
        translate([0,0, height*5/8])
        cylinder(d1=height/2.75, d2=0, h=height/4, center=true);
    }
}

//module portcullis to bring all together
module portcullis() {
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

module arch(){
    scale([0.16,0.16,0.16]){
    pipebend (10,2,169,44);
    columns();
        }
    }
//********** End of Module *********


//module that brings together pipebend
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


//helper module for convexity of pipe
module torus (thickness, dia,)
rotate_extrude(convexity = 10) translate([dia/3, 0, 0]) circle(r = thickness/4) ;
// ********** End of Module **********


//helper module for creating cylinder pipe via wedges
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


//helper module for column cylinder
module stackCylinder(vector, i = 0) {
    if (i < len(vector)) {
        cylinder(h=vector[i][0], d1=vector[i][1], d2=vector[i][2], $fn=vector[i][3]);
        translate([0,0,vector[i][0]]) stackCylinder(vector, i+1);
    }
}

//********** End of Module *******


//module for bringing together a set of cylinder & cubes
module columns() {
    //left column
    numFacets = 30;
    height = 50;
    bottom = 8;
    top = 6;
    hSmallCyl1 = height/50;
    hSmallCyl2 = height/30;
    translate([0,-18,0]){
        stackCylinder([[height, bottom, top, numFacets],
        [hSmallCyl1, top + 0.5, top + 0.5, numFacets*3],
        [hSmallCyl2, top, bottom, numFacets*3]]);
        // small cube on top (left)
        x = bottom;
        y = x;
        z = 1.5;
        centeringCube = -x/2;
        translate([centeringCube, centeringCube, height + + hSmallCyl1 + hSmallCyl2]) {
            cube(size = [x,y,z]);
            };
        }
    translate([0,18,0]){
        stackCylinder([[height, bottom, top, numFacets],
        [hSmallCyl1, top + 0.5, top + 0.5, numFacets*3],
        [hSmallCyl2, top, bottom, numFacets*3]]);
        // small cube on top (right)
        x = bottom;
        y = x;
        z = 1.5;
        centeringCube = -x/2;
        translate([centeringCube, centeringCube, height + + hSmallCyl1 + hSmallCyl2]) {
            cube(size = [x,y,z]);
            };
      }
}
//******** End of Module *******

module makeFloor(cube_size) {
    translate([cube_size / 2, cube_size / 2, 0])
    cube([cube_size, cube_size, 0.5], center = true);
}





