$fa = 1;
$fs = 0.4;
$fn=64;
module cone_top_turret(){
    color("white")
    translate([5,5,0])
    cylinder(h=5,d=10);
    color("#2BC176")
    translate([5,5,5])
    cylinder(h=5, r1=5, r2=0);
}
cone_top_turret();