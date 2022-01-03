module stackCylinder(vector, i = 0) {
    if (i < len(vector)) {
        cylinder(h=vector[i][0], d1=vector[i][1], d2=vector[i][2], $fn=vector[i][3]);
        translate([0,0,vector[i][0]]) stackCylinder(vector, i+1);
    }
}


height = 50;
bottomDiameter = 8;
topDiameter = 6;
column(height, bottomDiameter, topDiameter);

// ********* Column Module ***********
module column(height, bottomDiameter, topDiameter) {
numFacets = 30;
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
z = 1.5;
centeringCube = -x/2;
translate([centeringCube, centeringCube, height + hSmallCyl1 + hSmallCyl2]) 
{
    cube(size = [x,y,z]);
};
}
// ********* End of Module ***********
