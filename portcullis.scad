//portcullis scale
//call function

rotate([0,-90,0]){
    scale([0.1,0.1,0.1]){
        portcullis();
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

