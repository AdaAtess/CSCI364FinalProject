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


stackCylinder([
    [height, bottom, top, numFacets],
    [hSmallCyl1, top + 0.5, top + 0.5, numFacets*3],
    [hSmallCyl2, bottom, top, numFacets*3]
]);

// translate([0,0,0]) 
// {
//     cylinder(h = height, d1 = bottom, d2 = top, $fn = numFacets);
// };

// translate([0,0,height]) 
// {
//     cylinder(h = hSmallCyl1, d1 = top + 0.5, d2 = top + 0.5, $fn = numFacets*3);
// };

// translate([0,0,height + hSmallCyl1]) 
// {
//     cylinder(h = hSmallCyl2, d1 = top, d2 = bottom, $fn = numFacets*3);
// };

x = bottom;
y = x;
z = 1.5;
centeringCube = -x/2;
translate([centeringCube, centeringCube, height + + hSmallCyl1 + hSmallCyl2]) 
{
    cube(size = [x,y,z]);
};

