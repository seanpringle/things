difference() {
	union() {
		difference() {
			translate([12.5,28,0]) cube([5,75,25]);
			rotate([-14,0,0]) translate([10,20,30]) cube([10,110,30]);
		}
		difference() {
			cube([30,30,25]);
			translate([-1,5,5]) cube([40,20,30]);
		}
		difference() {
			cube([30,120,5]);
			translate([15,120,-1]) cylinder(r=18,h=30);
		}
		difference() {
			translate([15,120,0]) cylinder(r=20,h=5);
			translate([15,120,-1]) cylinder(r=15,h=7);
		}
	}
	translate([15,120,-1]) rotate([0,0,-40]) cube([25,0.5,7]);
	translate([30,-1,5]) rotate([0,-30,0]) cube([30,40,30]);
	translate([0,-1,5]) rotate([0,-60,0]) cube([30,40,30]);
	translate([88.4,68.5,-1]) cylinder(r=70,h=10,$fn=72);
	translate([-58.4,68.5,-1]) cylinder(r=70,h=10,$fn=72);
}