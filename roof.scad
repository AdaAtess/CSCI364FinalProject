//Roof module
//call function
roof(10);


//constant dimensions
width = 50;    
depth = 20;   
roof_height = 10;   

module roof(cube_size) {
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

