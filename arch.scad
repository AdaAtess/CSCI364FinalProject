$fa = 1;
$fs = 0.4;
$fn=64;
pipebend (10,2,172,53);

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

translate([0,-23,0]){
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

translate([0,23,0]){
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
