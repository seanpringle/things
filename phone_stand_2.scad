use <lib.scad>

phone = [75.5, 9.6, 155];

union() {
	difference() {
		difference() {
			scale([1,1.2])
				cylinder(r1=40, r2=15, h=100, $fn=72);
			scale([1,1.2])
				translate([0,0,-1])
				cylinder(r1=35, r2=10, h=102, $fn=72);
		}
		#translate([0,10,110])
			rotate([-25,0,0])
			color([0,0,0])
			cube(size=phone, center=true);
		translate([0,0,118])
			rotate([-25,0,0])
			color([0,0,0])
			cube(size=add(phone,[0,20,0]), center=true);
		translate([0,-50,69])
			cube(size=[50,50,50], center=true);
		rotate([0,0,0])
			translate([0,-36,-2])
			rotate([90,0,0])
			scale([1,1])
			cylinder(r=25,h=30,center=true,$fn=72);
		rotate([0,0,120])
			translate([0,-36,-2])
			rotate([90,0,0])
			scale([1,1])
			cylinder(r=25,h=30,center=true,$fn=72);
		rotate([0,0,-120])
			translate([0,-36,-2])
			rotate([90,0,0])
			scale([1,1])
			cylinder(r=25,h=30,center=true,$fn=72);
		translate([0,30,40])
			cylinder(r=11,h=120,center=true,$fn=72);
		translate([21,12,40])
			cylinder(r=5,h=120,center=true,$fn=72);
		translate([-21,12,40])
			cylinder(r=5,h=120,center=true,$fn=72);
		translate([0,-30,30])
			cube([20,30,50], center=true);
		translate([0,-30,45])
			rotate([90,45,0])
			cube(size=[20,20,20],center=true);
		translate([-19,-27,45.3])
			rotate([90,45,0])
			cube(size=[5,5,5],center=true);
		translate([19,-27,45.3])
			rotate([90,45,0])
			cube(size=[5,5,5],center=true);
	}
	translate([-35,-20,0])
		cube([70,5,5]);
}