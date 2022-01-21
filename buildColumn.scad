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

        // flat cube on top
        x = bottomDiameter;
        y = x;
        z = bottomDiameter/7;
        centeringCube = -x/2;

        stackCylinder([
            [height - hSmallCyl1 - hSmallCyl2 - z, bottomDiameter, topDiameter, numFacets],
            [hSmallCyl1, topDiameter + 0.5, topDiameter + 0.5, numFacets*3],
            [hSmallCyl2, topDiameter, bottomDiameter, numFacets*3]
        ]);

        translate([centeringCube, centeringCube, height + hSmallCyl1 + hSmallCyl2]) 
        {
            cube(size = [x,y,z]);
        };
    }
}

buildColumn(10);
// ********* End of Column Module ***********
