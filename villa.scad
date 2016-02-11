room_size = 4000;
one_wall = 200;
two_wall = one_wall*2;
slab_thickness = 100;
one_story = 3000;
house_width = room_size*4;
eaves_width = 800;
fascia_height = 200;
roof_width = house_width+(eaves_width*2);
courtyard_width = room_size*2;
high_window_height = 400;
full_window_height = one_story-600;
half_window_height = 1100;
door_width = 800;
door_height = 2000;
hall_width = 800;

single_bed_length = 2000;
single_bed_width = 900;
single_bed_height = 500;

double_bed_length = 2000;
double_bed_width = 1800;
double_bed_height = 500;

bench_depth = 700;

yonder = 100000;

living_x = house_width - two_wall;
living_y = room_size - two_wall;

bedroom_1_x = room_size - two_wall - (hall_width+one_wall);
bedroom_1_y = room_size - one_wall/2;

bedroom_2_x = bedroom_1_x;
bedroom_2_y = bedroom_1_y;

bedroom_3_x = room_size - two_wall - hall_width - one_wall;
bedroom_3_y = living_y;

master_x = room_size + hall_width + one_wall/2;
master_y = living_y;

master_wardrobe_x = house_width/2 - master_x - two_wall - one_wall/2;
master_wardrobe_y = master_y/2 - one_wall/2;

master_ensuite_x = house_width/2 - master_x - two_wall - one_wall/2;
master_ensuite_y = master_y/2 - one_wall/2;

laundry_x = master_x - hall_width - one_wall;
laundry_y = master_y/2 - one_wall/2;

bathroom_x = master_x - hall_width - one_wall;
bathroom_y = master_y/2 - one_wall/2;

east_hall_x = hall_width;
east_hall_y = room_size*2;

kitchen_x = room_size - two_wall - east_hall_x;
kitchen_y = room_size - one_wall/2;

west_hall_x = hall_width;
west_hall_y = room_size*2;

storeroom_x = kitchen_x - one_wall;
storeroom_y = room_size - one_wall/2;

courtyard_x = courtyard_width;
courtyard_y = courtyard_width;

entry_x = room_size - two_wall;
entry_y = room_size/2;

function bedroom_1(x, y) = [
	one_wall + x,
	room_size + y,
	slab_thickness
];

function bedroom_2(x, y) = [
	one_wall + x,
	room_size + room_size + one_wall/2 + y,
	slab_thickness
];

function bathroom(x, y) = [
	room_size + x,
	room_size + room_size + room_size + one_wall + y,
	slab_thickness
];

function bedroom_3(x, y) = [
	one_wall + x,
	room_size + room_size + room_size + one_wall + y,
	slab_thickness
];

function master(x, y) = [
	house_width - room_size*2 + one_wall/2 + x,
	room_size + room_size + room_size + one_wall + y,
	slab_thickness
];

function master_wardrobe(x, y) = master(master_x + one_wall + x, y);
function master_ensuite(x, y) = master(master_x + one_wall + x, master_y/2 + one_wall/2 + y);

function laundry(x, y) = [
	one_wall + bedroom_3_x + one_wall + hall_width + one_wall + x,
	room_size + room_size + room_size + one_wall + y,
	slab_thickness,
];

function bathroom(x, y) = [
	one_wall + bedroom_3_x + one_wall + hall_width + one_wall + x,
	room_size + room_size + room_size + one_wall + laundry_y + one_wall + y,
	slab_thickness,
];

function east_hall(x, y) = [
	room_size*3 + one_wall + x,
	room_size + y,
	slab_thickness
];

function kitchen(x, y) = [
	room_size*3 + one_wall + east_hall_x + x,
	room_size*1 + y,
	slab_thickness
];

function west_hall(x, y) = [
	room_size - west_hall_x - one_wall + x,
	room_size + y,
	slab_thickness
];

function living(x, y) = [
	one_wall + x,
	one_wall + y,
	slab_thickness
];

function storeroom(x, y) = [
	room_size*3 + east_hall_x + two_wall + x,
	room_size*2 + one_wall/2 + y,
	slab_thickness
];

function courtyard(x, y) = [
	room_size + x,
	room_size + y,
	0
];

function entry(x, y) = [
	house_width/2 - entry_x/2 + x,
	-entry_y + y,
	slab_thickness
];

module single_bed()
{
	color("cornsilk", 1)
		cube([single_bed_length, single_bed_width, single_bed_height]);
}

module double_bed()
{
	color("cornsilk", 1)
		cube([double_bed_length, double_bed_width, double_bed_height]);
}

module doorway()
{
	translate([0, -1, 10]) cube([door_width, one_wall+2, door_height]);
}

module window(w=room_size/2)
{
	translate([0, -1, door_height - half_window_height])
		cube([w, one_wall+2, half_window_height]);
}

module high_window(w=room_size/2)
{
	translate([0, -1, door_height + 100 ])
		cube([w, one_wall+2, high_window_height]);
}

module double_doorway()
{
	translate([0, -1, 10]) cube([door_width*2, one_wall+2, door_height]);
}

module full_window()
{
	translate([200, -1, 0])
		cube([room_size-(door_width/2), one_wall+2, full_window_height]);
}

module bench(length)
{
	translate([0, 0, 800])
		cube([length, bench_depth, 100]);
}

module master_door_west()
{
	translate(master(0, laundry_y - door_width))
		rotate([0, 0, 90]) doorway();
}

module master_door_south()
{
	translate(master(master_x - door_width, -one_wall))
		rotate([0, 0, 0]) doorway();
}

module master_window()
{
	// master window
	translate(master((master_x-(room_size/2))/2, master_y))
		high_window();
}

module master_ensuite_window_east()
{
	translate(master_ensuite(master_ensuite_x + one_wall, master_ensuite_y/4))
		rotate([0, 0, 90]) high_window(master_ensuite_y/2);
}

module master_ensuite_window_north()
{
	translate(master_ensuite((master_ensuite_x-(room_size/2))/2, master_ensuite_y))
		high_window();
}

module master_wardrobe_door()
{
	translate(master_wardrobe(0, master_wardrobe_y - door_width))
		rotate([0, 0, 90]) doorway();
}

module master_ensuite_door()
{
	translate(master_ensuite(0, 0))
		rotate([0, 0, 90]) doorway();
}

module master_courtyard_window()
{
	translate(master(-one_wall/2, -one_wall))
		full_window();
}

module master_ensuite_wardrobe_door()
{
	translate(master_ensuite(master_ensuite_x - door_width, -one_wall))
		rotate([0, 0, 0]) doorway();
}

module bathroom_door()
{
	translate(bathroom(0, 0))
		rotate([0, 0, 90]) doorway();
}

module bathroom_window()
{
	translate(bathroom((bathroom_x-(room_size/2))/2, bathroom_y))
		high_window();
}

module laundry_doors()
{
	translate(laundry(0, laundry_y - door_width))
		rotate([0, 0, 90]) doorway();
	translate(laundry(laundry_x - door_width, -one_wall))
		doorway();
}

module laundry_window()
{
	//translate(laundry((laundry_x-(room_size/2))/2, -one_wall))
	//	high_window();
}

module laundry_whitegoods()
{
	washing_machine_x = 600;
	washing_machine_y = 500;
	washing_machine_z = 700;

	dryer_machine_x = 600;
	dryer_machine_y = 500;
	dryer_machine_z = 700;

	translate(laundry(600, 0))
		cube([washing_machine_x, washing_machine_y, washing_machine_z]);

	translate(laundry(600, 0)) translate([0, 0, washing_machine_z+10])
		cube([dryer_machine_x, dryer_machine_y, dryer_machine_z]);

}

module laundry_sink()
{
	sink_x = 500;
	sink_y = 400;
	sink_z = 300;

	translate(laundry(0, 0))
		translate([0, 0, 600]) difference()
		{
			cube([sink_x, sink_y, sink_z]);
			translate([25, 25, 100]) cube([sink_x-50, sink_y-50, sink_z-50]);
		}
}

module laundry_joinery()
{
	sink_x = 500;
	sink_y = 400;
	sink_z = 300;

	translate(laundry(0, 0))
		cube([sink_x, sink_y, 600]);

	translate(laundry(1300, 0))
		cube([1800, bench_depth, 800]);

	translate(laundry(1300, 0)) translate([0, 0, 1200])
		cube([1800, 250, 25]);
	translate(laundry(1300, 0)) translate([0, 0, 1500])
		cube([1800, 250, 25]);
	translate(laundry(1300, 0)) translate([0, 0, 1800])
		cube([1800, 250, 25]);

	translate(laundry(500, -1500))
		translate([0, 0, 1800]) cube([2000, 20, 20]);
	translate(laundry(500, -1200))
		translate([0, 0, 1800]) cube([2000, 20, 20]);
	translate(laundry(500, -0900))
		translate([0, 0, 1800]) cube([2000, 20, 20]);
	translate(laundry(500, -0600))
		translate([0, 0, 1800]) cube([2000, 20, 20]);
	translate(laundry(500, -0300))
		translate([0, 0, 1800]) cube([2000, 20, 20]);

	translate(laundry(500, -1500))
		translate([0, 0, 1800]) cube([20, 1500, 20]);
	translate(laundry(500, -1500))
		translate([0, 0, 1800]) rotate([-10, 0, 0]) cube([20, 1500, 20]);
	translate(laundry(2500, -1500))
		translate([0, 0, 1800]) cube([20, 1500, 20]);
	translate(laundry(2500, -1500))
		translate([0, 0, 1800]) rotate([-10, 0, 0]) cube([20, 1500, 20]);
}

module laundry_benches()
{
	translate(laundry(1300, 0))
		bench(1800);
}

module back_door()
{
	translate(bedroom_3(bedroom_3_x + one_wall, bedroom_3_y))
		doorway();
}

module kitchen_windows()
{
	translate(kitchen(kitchen_x + one_wall, (kitchen_y-(room_size/2))/2))
		rotate([0, 0, 90]) high_window();
}

module storeroom_door()
{
	translate(storeroom(0, -one_wall))
		doorway();
}

module storeroom_joinery()
{
	translate(storeroom(door_width, 0))
		translate([0, 0,  300]) cube([storeroom_x - door_width, 250, 25]);
	translate(storeroom(door_width, 0))
		translate([0, 0,  600]) cube([storeroom_x - door_width, 250, 25]);
	translate(storeroom(door_width, 0))
		translate([0, 0,  900]) cube([storeroom_x - door_width, 250, 25]);
	translate(storeroom(door_width, 0))
		translate([0, 0, 1200]) cube([storeroom_x - door_width, 250, 25]);
	translate(storeroom(door_width, 0))
		translate([0, 0, 1500]) cube([storeroom_x - door_width, 250, 25]);
	translate(storeroom(door_width, 0))
		translate([0, 0, 1800]) cube([storeroom_x - door_width, 250, 25]);

	translate(storeroom(storeroom_x, 0)) rotate([0, 0, 90])
		translate([0, 0,  300]) cube([storeroom_y, 250, 25]);
	translate(storeroom(storeroom_x, 0)) rotate([0, 0, 90])
		translate([0, 0,  600]) cube([storeroom_y, 250, 25]);
	translate(storeroom(storeroom_x, 0)) rotate([0, 0, 90])
		translate([0, 0,  900]) cube([storeroom_y, 250, 25]);
	translate(storeroom(storeroom_x, 0)) rotate([0, 0, 90])
		translate([0, 0, 1200]) cube([storeroom_y, 250, 25]);
	translate(storeroom(storeroom_x, 0)) rotate([0, 0, 90])
		translate([0, 0, 1500]) cube([storeroom_y, 250, 25]);
	translate(storeroom(storeroom_x, 0)) rotate([0, 0, 90])
		translate([0, 0, 1800]) cube([storeroom_y, 250, 25]);

	translate(storeroom(250, 1000)) rotate([0, 0, 90])
		translate([0, 0,  300]) cube([storeroom_y-1000, 250, 25]);
	translate(storeroom(250, 1000)) rotate([0, 0, 90])
		translate([0, 0,  600]) cube([storeroom_y-1000, 250, 25]);
	translate(storeroom(250, 1000)) rotate([0, 0, 90])
		translate([0, 0,  900]) cube([storeroom_y-1000, 250, 25]);
	translate(storeroom(250, 1000)) rotate([0, 0, 90])
		translate([0, 0, 1200]) cube([storeroom_y-1000, 250, 25]);
	translate(storeroom(250, 1000)) rotate([0, 0, 90])
		translate([0, 0, 1500]) cube([storeroom_y-1000, 250, 25]);
	translate(storeroom(250, 1000)) rotate([0, 0, 90])
		translate([0, 0, 1800]) cube([storeroom_y-1000, 250, 25]);

	translate(storeroom((storeroom_x-250)/2+450, 1000)) rotate([0, 0, 90])
		translate([0, 0,  300]) cube([storeroom_y-1000, 600, 25]);
	translate(storeroom((storeroom_x-250)/2+450, 1000)) rotate([0, 0, 90])
		translate([0, 0,  600]) cube([storeroom_y-1000, 600, 25]);
	translate(storeroom((storeroom_x-250)/2+450, 1000)) rotate([0, 0, 90])
		translate([0, 0,  900]) cube([storeroom_y-1000, 600, 25]);
	translate(storeroom((storeroom_x-250)/2+450, 1000)) rotate([0, 0, 90])
		translate([0, 0, 1200]) cube([storeroom_y-1000, 600, 25]);
	translate(storeroom((storeroom_x-250)/2+450, 1000)) rotate([0, 0, 90])
		translate([0, 0, 1500]) cube([storeroom_y-1000, 600, 25]);
	translate(storeroom((storeroom_x-250)/2+450, 1000)) rotate([0, 0, 90])
		translate([0, 0, 1800]) cube([storeroom_y-1000, 600, 25]);

	translate(storeroom(0, storeroom_y-250))
		translate([0, 0,  300]) cube([storeroom_x, 250, 25]);
	translate(storeroom(0, storeroom_y-250))
		translate([0, 0,  600]) cube([storeroom_x, 250, 25]);
	translate(storeroom(0, storeroom_y-250))
		translate([0, 0,  900]) cube([storeroom_x, 250, 25]);
	translate(storeroom(0, storeroom_y-250))
		translate([0, 0, 1200]) cube([storeroom_x, 250, 25]);
	translate(storeroom(0, storeroom_y-250))
		translate([0, 0, 1500]) cube([storeroom_x, 250, 25]);
	translate(storeroom(0, storeroom_y-250))
		translate([0, 0, 1800]) cube([storeroom_x, 250, 25]);

}

module kitchen_benches()
{
	translate(kitchen(kitchen_x, 0))
		rotate([ 0, 0, 90]) bench(kitchen_y);

	// island
	translate(kitchen(0, (kitchen_y - 200)/2))
		rotate([ 0, 0, 0]) translate([0, 0, 800]) cube([1200, 900, 100]);
}

module kitchen_whitegoods()
{
	// fridge
	translate(kitchen(0, 100))
		cube([800, 700, 1800]);
}

module kitchen_joinery()
{
	// west
	translate(kitchen(kitchen_x, 0))
		rotate([ 0, 0, 90]) cube([kitchen_y, bench_depth, 800]);

	// island
	translate(kitchen(0, (kitchen_y - 200)/2))
		rotate([ 0, 0, 0]) cube([1200, 900, 800]);
}

module east_hall_doors()
{
	translate(east_hall(0, -one_wall))
		doorway();
	translate(east_hall(0, east_hall_y/2-one_wall/2))
		doorway();
}

module east_hall_courtyard_windows()
{
	translate(east_hall(0, 0))
		rotate([0, 0, 90]) full_window();
	translate(east_hall(0, room_size))
		rotate([0, 0, 90]) full_window();
}

module west_hall_courtyard_windows()
{
	translate(west_hall(west_hall_x + one_wall, 0))
		rotate([0, 0, 90]) full_window();
	translate(west_hall(west_hall_x + one_wall, room_size))
		rotate([0, 0, 90]) full_window();
}

module west_hall_door_south()
{
	translate(west_hall(0, -one_wall))
		doorway();
}

module west_hall_door_north()
{
	translate(west_hall(0, west_hall_y))
		doorway();
}

module bedroom_1_door()
{
	translate(bedroom_1(bedroom_1_x + one_wall, 0))
		rotate([0, 0, 90]) doorway();
}

module bedroom_1_benches()
{
	translate(bedroom_1(bench_depth, (bedroom_1_y-(room_size/2))/2))
		rotate([0, 0, 90]) bench(room_size/2);
}

module bedroom_1_joinery()
{
	translate(bedroom_1(bench_depth, (bedroom_1_y-(room_size/2))/2))
		rotate([0, 0, 90]) cube([50, 50, 800]);
	translate(bedroom_1(bench_depth, (bedroom_1_y-(room_size/2))/2 + room_size/2 - 50))
		rotate([0, 0, 90]) cube([50, 50, 800]);
}

module bedroom_1_window_west()
{
	translate(bedroom_1(0, (bedroom_1_y-(room_size/2))/2))
		rotate([0, 0, 90]) high_window();	
}

module bedroom_1_window_east()
{
	translate(bedroom_1(bedroom_1_x + one_wall, (room_size - door_width)/2))
		rotate([0, 0, 90]) window(bedroom_1_y/2);
}

module bedroom_2_door()
{
	translate(bedroom_2(bedroom_2_x + one_wall, 0))
		rotate([0, 0, 90]) doorway();
}

module bedroom_2_benches()
{
	translate(bedroom_2(bench_depth, (bedroom_1_y-(room_size/2))/2))
		rotate([0, 0, 90]) bench(room_size/2);
}

module bedroom_2_joinery()
{
	translate(bedroom_2(bench_depth, (bedroom_2_y-(room_size/2))/2))
		rotate([0, 0, 90]) cube([50, 50, 800]);
	translate(bedroom_2(bench_depth, (bedroom_2_y-(room_size/2))/2 + room_size/2 - 50))
		rotate([0, 0, 90]) cube([50, 50, 800]);
}

module bedroom_2_window_west()
{
	translate(bedroom_2(0, (bedroom_2_y-(room_size/2))/2))
		rotate([0, 0, 90]) high_window();	
}

module bedroom_2_window_east()
{
	translate(bedroom_2(bedroom_2_x + one_wall, (room_size - door_width)/2))
		rotate([0, 0, 90]) window(bedroom_2_y/2);
}

module bedroom_3_window_north()
{
	translate(bedroom_3((bedroom_3_x-(room_size/2))/2, bedroom_3_y))
		high_window();
}

module bedroom_3_window_west()
{
	translate(bedroom_3(0, (bedroom_3_y-(room_size/2))/2))
		rotate([0, 0, 90]) high_window();
}

module bedroom_3_door()
{
	translate(bedroom_3(bedroom_3_x + one_wall, 0))
		rotate([0, 0, 90]) doorway();
}

module front_door()
{
	translate(living(living_x/2 - door_width, -one_wall))
		double_doorway();
}

module living_courtyard_windows()
{
	translate(living(room_size - one_wall, room_size-two_wall))
		full_window();
	translate(living(room_size*2 - one_wall, room_size-two_wall))
		full_window();
}

module living_side_windows()
{
	translate(living(0, (living_y-(room_size/2))/2))
		rotate([0, 0, 90]) high_window();

	translate(living(living_x + one_wall, (living_y-(room_size/2))/2))
		rotate([0, 0, 90]) high_window();
}

module courtyard_paving()
{
	translate(courtyard(0, courtyard_y-(courtyard_y/3)))
		cube([courtyard_x/2, courtyard_y/3, 50]);

	translate(courtyard(courtyard_x/2, 0))
		cube([courtyard_x/2, courtyard_y/3, 50]);
}

module courtyard_lawn()
{
	translate(courtyard(0, 0))
		cube([courtyard_x, courtyard_y, 40]);
}

module structure()
{
	difference()
	{
		cube([house_width, house_width, one_story]);

		// living subtract
		translate(living(0, 0))
			cube([living_x, living_y, one_story+1]);

		living_courtyard_windows();
		living_side_windows();
		front_door();

		// master subtract
		translate(master(0, 0))
			cube([master_x, master_y, one_story+1]);

		master_window();
		master_door_west();
		master_door_south();
		master_courtyard_window();

		// wardrobe subtract
		translate(master_wardrobe(0, 0))
			cube([master_wardrobe_x, master_wardrobe_y, one_story+1]);

		master_wardrobe_door();

		// ensuite subtract
		translate(master_ensuite(0, 0))
			cube([master_ensuite_x, master_ensuite_y, one_story+1]);

		master_ensuite_door();
		master_ensuite_window_east();
		master_ensuite_window_north();
		master_ensuite_wardrobe_door();

		// laundry subtract
		translate(laundry(0, 0))
			cube([laundry_x, laundry_y, one_story+1]);

		laundry_doors();
		laundry_window();

		// bathroom subtract
		translate(bathroom(0, 0))
			cube([laundry_x, laundry_y, one_story+1]);

		bathroom_door();
		bathroom_window();

		// rear hall subtract
		translate(bedroom_3(bedroom_3_x + one_wall, 0))
			cube([hall_width, bedroom_3_y, one_story+1]);

		back_door();

		// bedroom 3 subtract
		translate(bedroom_3(0, 0))
			cube([bedroom_3_x, bedroom_3_y, one_story+1]);

		bedroom_3_window_north();
		bedroom_3_window_west();
		bedroom_3_door();

		// east hall subtract
		translate(east_hall(0, 0))
			cube([east_hall_x, east_hall_y/2-one_wall/2, one_story+1]);
		translate(east_hall(0, east_hall_y/2+one_wall/2))
			cube([east_hall_x, east_hall_y/2-one_wall/2, one_story+1]);

		east_hall_doors();
		east_hall_courtyard_windows();

		// kitchen subtract
		translate(kitchen(-1, 0))
			cube([kitchen_x+1, kitchen_y, one_story+1]);

		kitchen_windows();
		storeroom_door();

		// storeroom subtract
		translate(storeroom(0, 0))
			cube([storeroom_x, storeroom_y, one_story+1]);

		// west hall subtract
		translate(west_hall(0, 0))
			cube([west_hall_x, west_hall_y, one_story+1]);

		west_hall_courtyard_windows();
		west_hall_door_south();
		west_hall_door_north();

		// bedroom 1 subtract
		translate(bedroom_1(0, 0))
			cube([bedroom_1_x, bedroom_1_y, one_story+1]);

		bedroom_1_door();
		bedroom_1_window_west();
		bedroom_1_window_east();

		// bedroom 2 subtract
		translate(bedroom_2(0, 0))
			cube([bedroom_2_x, bedroom_2_y, one_story+1]);

		bedroom_2_door();
		bedroom_2_window_west();
		bedroom_2_window_east();

		// courtyard subtract
		translate(courtyard(0, 0))
			translate([0, 0, -1]) cube([courtyard_x, courtyard_y, one_story+2]);

	}

	difference()
	{
		translate(entry(-one_wall, -one_wall))
			translate([0, 0, -slab_thickness]) cube([entry_x + two_wall, entry_y + one_wall, one_story]);

		translate(entry(0, 0))
			cube([entry_x, entry_y+1, one_story+1]);

		#translate(entry((entry_x-(door_width*2))/2, -one_wall))
			double_doorway();

	}
}

module structure_windows()
{
	master_window();
	master_ensuite_window_east();
	master_ensuite_window_north();
	master_courtyard_window();
	bedroom_3_window_north();
	bedroom_3_window_west();
	bathroom_window();
	kitchen_windows();
	east_hall_courtyard_windows();
	west_hall_courtyard_windows();
	bedroom_1_window_west();
	bedroom_1_window_east();
	bedroom_2_window_west();
	bedroom_2_window_east();
	living_courtyard_windows();
	living_side_windows();
	laundry_window();
}

module structure_doors()
{
	master_door_west();
	master_door_south();
	master_wardrobe_door();
	master_ensuite_door();
	master_ensuite_wardrobe_door();
	laundry_doors();
	bathroom_door();
	back_door();
	bedroom_3_door();
	east_hall_doors();
	bedroom_1_door();
	bedroom_2_door();
	west_hall_door_south();
	west_hall_door_north();
	front_door();
	storeroom_door();
}

module structure_benches()
{
	kitchen_benches();
	laundry_benches();
	bedroom_1_benches();
	bedroom_2_benches();
}

module structure_whitegoods()
{
	kitchen_whitegoods();
	laundry_whitegoods();
}

module structure_joinery()
{
	kitchen_joinery();
	storeroom_joinery();
	laundry_joinery();
	bedroom_1_joinery();
	bedroom_2_joinery();
}

module structure_sinks()
{
	laundry_sink();
}

module roof()
{
	union()
	{
		rotate([0, 0, 45]) difference()
		{
			cylinder(one_story, roof_width/1.4, courtyard_width/1.4, $fn=4);
			translate([0, 0, -1]) cylinder(one_story+2, courtyard_width/1.6, roof_width/1.4, $fn=4);
		}
	}
}

module house()
{
	color("grey", 1) structure();

	translate(bedroom_1(0, bedroom_1_y - single_bed_width))
		translate([0, 0, 0])
			single_bed();

	translate(bedroom_2(0, bedroom_2_y - single_bed_width))
		translate([0, 0, 0])
			single_bed();

	translate(bedroom_3(0, bedroom_3_y - single_bed_width))
		translate([0, 0, 0])
			single_bed();

	translate(master(master_x/2+double_bed_width/2, master_y/2-one_wall))
		rotate([0, 0, 90])
			double_bed();

	color("slategrey", 1) structure_benches();
	color("tan", 1) structure_joinery();
	color("white", 1) structure_whitegoods();
	color("silver", 1) structure_sinks();
	color("tan", 0.5) structure_doors();

	difference()
	{
		color("darkgreen", 1) courtyard_lawn();
		translate([0, 0, -1]) courtyard_paving();
	}

	color("dimgray", 1) courtyard_paving();
	color("white", 0.5) structure_windows();

	translate([room_size*2, room_size*2, one_story]) color("firebrick", 0.5) roof();

	//translate(storeroom(0, 0)) cube([100, 100, one_story*2]);
}

house();