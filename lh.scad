// https://www.thingiverse.com/thing:41145/files

difference ()
{cube([40, 40, 30]);
translate( [2, 2, -1] )
cube([36, 36, 29]);
translate( [15, -1, -1] )
cube([10, 4, 11]);
translate( [5, -1, 15] )
cube([5, 5, 10]);
translate( [30, -1, 15] )
cube([5, 5, 10]);
translate( [38, 5, 15] )
cube([5, 5, 10]);
translate( [38, 30, 15] )
cube([5, 5, 10]);
translate( [5, 36, 15] )
cube([5, 5, 10]);
translate( [30, 36, 15] )
cube([5, 5, 10]);
translate( [-1, 5, 15] )
cube([5, 5, 10]);
translate( [-1, 30, 15] )
cube([5, 5, 10]);
translate( [20, -2, 10] )
rotate([45,90,135]) cylinder(5,5,5);
}


translate( [-11, 12, 5] )
cylinder(h = 10, r1 = 12, r2 = 11, center = true);
translate( [-11, 12, 15] )
cylinder(h = 10, r1 = 11, r2 = 10, center = true);
translate( [-11, 12, 25] )
cylinder(h = 10, r1 = 10, r2 = 9, center = true);
translate( [-11, 12, 35] )
cylinder(h = 10, r1 = 9, r2 = 8, center = true);
translate( [-11, 12, 45] )
cylinder(h = 10, r1 = 8, r2 = 7, center = true);
translate( [-11, 12, 51] )
cylinder(h = 2, r1 = 11, r2 = 11, center = true);

{
	translate([-11, 12, 52]) {
				for (i = [0:5]) {
			echo(360*i/6, sin(360*i/6)*80, cos(360*i/6)*80);
			translate([sin(360*i/6)*10, cos(360*i/6)*10, 0 ])
				cylinder(h = 5, r=1);

		}

	}
}

difference ()
{translate( [-11, 12, 58] )
cylinder(h = 2, r1 = 11, r2 = 11, center = true);
translate( [-11, 12, 58] )
cylinder(h = 6, r1 = 8, r2 = 8, center = true);

}


difference ()//dome
{translate([-11,12,65]) sphere(6);
translate( [-19,3,62] )
cube([15, 15, 3]);
}

difference ()
{translate( [-11, 12, 58] )
cylinder(h = 15, r1 = 6, r2 = 6, center = true);
translate( [-11, 12, 58] )
cylinder(h = 15, r1 = 4, r2 = 4, center = true);
translate( [-13, 5, 61] )
cube([3, 15, 3]);
translate( [-18, 11, 61] )
cube([15, 3, 3]);
}

translate( [20, 20, 30] )//roof
polyhedron(
  points=[ [20,20,0],[20,-20,0],[-20,-20,0],[-20,20,0],[0,0,20]  ],  
 triangles=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4], [1,0,3],[2,1,3] ]
 );

difference ()
{translate( [-16, -2, 0] )
cube([10, 5, 10]);
translate( [-14, -3, 0] )
cube([6, 3, 10]);
}

difference ()
{translate( [-11, -2, 10] )
rotate([45,90,135]) cylinder(5,5,5);
translate([-11, -3, 10])rotate([45,90,135])  cylinder(3,3,3.5);
translate( [-14, -3, 5] )
cube([6, 4, 6]);

}
translate([-11,12,73]) cylinder(h = 5, r1 = 1.25, r2 = .5, center = true);