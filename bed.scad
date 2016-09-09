// Structural CD Plywood 2400 x 1200mm 9mm $37
// CustomWood MDF 2400 x 1200 x 9mm $24
// Porta 42 x 42mm 2.4m Standard and Better Pine DAR $15
// Porta 40 x 18mm 2.4m Clear Pine DAR Moulding $17

// 8 x 15 = 120
// 9 x 17 = 153
// 5 x 24 = 120
//        = 393


// 11 * 7 = 77
// 10 * 6 = 60
// 3 x 24 = 72
//        = 209 + 52


function mattress_vec(x, y, z) = [
	x + 2040,
	y + 1070,
	z + 250
];

function frame_vec(x, y, z) = [
	x + 2250,
	y + 1200,
	z + 1200
];

function frame_vec(x, y, z) = [
	x + 2100,
	y + 1100,
	z + 1200
];

function mattress_vec(x, y, z) = [
	x + 1880,
	y + 920,
	z + 250
];

function mattress_x() = mattress_vec(0, 0, 0)[0];
function mattress_y() = mattress_vec(0, 0, 0)[1];
function mattress_z() = mattress_vec(0, 0, 0)[2];

function frame_x() = frame_vec(0, 0, 0)[0];
function frame_y() = frame_vec(0, 0, 0)[1];
function frame_z1() = frame_vec(0, 0, 0)[2];
function frame_z2() = frame_z1() + 400;
function frame_base() = 100;
function frame_cladding() = 9;

function mattress_dvec(x, y, z) = [
	x + (frame_x() - mattress_x())/2,
	y + (frame_y() - mattress_y())/2,
	z + frame_base() + frame_sq() + 25,
];

function beam_vec(len) = [
	len,
	70,
	45
];

function beam_width(len) = beam_vec(1)[1];
function beam_thick(len) = beam_vec(1)[2];

function mattress_dvec(x, y, z) = [
	x + (frame_x() - mattress_x())/2,
	y + (frame_y() - mattress_y())/2,
	z + frame_base() + beam_width() + 25,
];

module mattress()
{
	translate(mattress_dvec(0, 0, 0)) color("ivory", 1)
		cube(mattress_vec(0, 0, 0));
}

module slat()
{
	translate([0, 0, 0]) rotate([0, 0, 90])
		cube([frame_y(), 42, 19]);
}

module leg()
{
	translate([beam_thick(), 0, 0]) rotate([0, -90, 0])
		cube(beam_vec(frame_z2()));
}

module ybeam()
{
	translate([0, 0, 0]) rotate([90, 0, 90])
		cube(beam_vec(frame_y() - beam_thick() - beam_thick()));
}

module xbeam()
{
	translate([0, beam_thick(), 0]) rotate([90, 0, 0])
		cube(beam_vec(frame_x()));
}

module surface()
{
	translate([0, 0, 0]) rotate([0, 0, 0])
		cube([frame_x() + frame_cladding() + frame_cladding(), frame_y() + frame_cladding() + frame_cladding(), frame_cladding()]);
}

module xside()
{
	translate([0, frame_cladding(), 0]) rotate([90, 0, 0])
		cube([frame_x() + frame_cladding() + frame_cladding(), frame_z1() - frame_base(), frame_cladding()]);
}

module yside()
{
	translate([0, 0, 0]) rotate([0, -90, 0])
		cube([frame_z1() - frame_base(), frame_y(), frame_cladding()]);
}

module legs()
{
	translate([
		0,
		beam_thick(),
		0
	])
	leg();

	translate([
		0,
		frame_y() - beam_width() - beam_thick(),
		0
	])
	leg();

	translate([
		frame_x() - beam_thick(), 
		frame_y() - beam_width() - beam_thick(), 
		0
	])
	leg();

	translate([
		frame_x() - beam_thick(), 
		beam_thick(), 
		0
	])
	leg();
}

module ybeam_head_z1()
{
	translate([
		beam_thick(), 
		beam_thick(),
		frame_z1() - beam_width(),
	])
	ybeam();
}

module ybeam_head_base()
{
	translate([
		beam_thick(), 
		beam_thick(),
		frame_base(),
	])
	ybeam();
}

module ybeam_head_z2()
{
	translate([
		beam_thick(), 
		beam_thick(),
		frame_z2() - beam_width(),
	])
	ybeam();
}

module ybeam_head_shelf()
{
	translate([
		beam_thick(), 
		beam_thick(),
		frame_base() + 600,
	])
	ybeam();
}

module ybeam_foot_z1()
{
	translate([
		frame_x() - beam_thick() - beam_thick(), 
		beam_thick(), 
		frame_z1() - beam_width(),
	])
	ybeam();
}

module ybeam_foot_base()
{
	translate([
		frame_x() - beam_thick() - beam_thick(), 
		beam_thick(), 
		frame_base(),
	])
	ybeam();
}

module ybeam_foot_z2()
{
	translate([
		frame_x() - beam_thick() - beam_thick(), 
		beam_thick(), 
		frame_z2() - beam_width(),
	])
	ybeam();
}

module ybeams()
{
	ybeam_head_z1();
	ybeam_head_z2();
	ybeam_head_base();
	ybeam_head_shelf();

	ybeam_foot_z1();
	ybeam_foot_base();
	ybeam_foot_z2();

	translate([
		frame_x()/3,
		beam_thick(),
		frame_z1() - beam_width(),
	])
	ybeam();

	translate([
		frame_x() - frame_x()/3 - beam_thick(),
		beam_thick(),
		frame_z1() - beam_width(),
	])
	ybeam();

	translate([
		frame_x()/3,
		beam_thick(),
		frame_z2() - beam_width(),
	])
	ybeam();

	translate([
		frame_x() - frame_x()/3 - beam_thick(),
		beam_thick(),
		frame_z2() - beam_width(),
	])
	ybeam();
}

module xbeams()
{
	translate([
		0,
		0,
		frame_z1() - beam_width(),
	])
	xbeam();

	translate([
		0,
		0,
		frame_base(),
	])
	xbeam();

	translate([
		0,
		0,
		frame_z2() - beam_width(),
	])
	xbeam();

	translate([
		0,
		frame_y() - beam_thick(),
		frame_z1() - beam_width(),
	])
	xbeam();

	translate([
		0,
		frame_y() - beam_thick(),
		frame_base(),
	])
	xbeam();

	translate([
		0,
		frame_y() - beam_thick(),
		frame_z2() - beam_width(),
	])
	xbeam();
}

module slats()
{
	for (i = [0:20])
		translate([
			beam_thick()*4 + i*beam_thick()*2,
			0,
			frame_base() + beam_width()
		])
		slat();
}

module cladding_z1()
{
	translate([
		-frame_cladding(),
		-frame_cladding(),
		frame_z1(),
	])
	surface();
}

module cladding_z2()
{
	translate([
		-frame_cladding(),
		-frame_cladding(),
		frame_z2(),
	])
	surface();
}

module cladding_base()
{
	translate([
		-frame_cladding(),
		-frame_cladding(),
		frame_base() - frame_cladding(),
	])
	surface();
}

module cladding_back()
{
	translate([
		-frame_cladding(),
		frame_y(),
		frame_base(),
	])
	xside();
}

module cladding_front()
{
	difference()
	{
		translate([
			-frame_cladding(),
			-frame_cladding(),
			frame_base(),
		])
		xside();

		translate([
			100,
			-500,
			frame_z1() - 950,
		])
		cube([frame_x() - 200, 1000, 800]);
	}
}

module cladding_head()
{
	translate([
		0,
		0,
		frame_base(),
	])
	yside();
}

module cladding_foot()
{
	translate([
		frame_x() + frame_cladding(),
		0,
		frame_base(),
	])
	yside();
}

module cladding()
{
	cladding_z1();
	//cladding_z2();
	cladding_base();
	cladding_back();
	//cladding_front();
	cladding_head();
	cladding_foot();
}

module shelf()
{
	translate([0, beam_width() + beam_thick(), frame_base() + 600 + beam_width()])
		cube([150, frame_y() - beam_width() - beam_width() - beam_thick() - beam_thick(), 19]);
}

module box()
{
	color("red")
		cube([350, 350, 250]);
}

module bed()
{
	mattress();

	color("brown", 1) legs();
	color("green", 1) ybeams();
	color("navy", 1) xbeams();
	color("orange", 1) slats();
	color("white", 1) cladding();

	shelf();
/*
	translate([beam_thick() + 20, 50, frame_z1() + frame_cladding()]) box();
	translate([beam_thick(), 450, frame_z1() + frame_cladding()]) box();
	translate([beam_thick() + 20 + 400, 50, frame_z1() + frame_cladding()]) box();
	translate([beam_thick() + 20 + 800, 50, frame_z1() + frame_cladding()]) box();
	translate([beam_thick() + 20 + 1200, 50, frame_z1() + frame_cladding()]) box();
	translate([beam_thick() + 20 + 1600, 50, frame_z1() + frame_cladding()]) box();
	translate([beam_thick() + 40 + 1600, 450, frame_z1() + frame_cladding()]) box();
*/
}

bed();