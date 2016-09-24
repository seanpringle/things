
mdf = "tan";
pine = "lemonchiffon";

surface_z = 12;
shelf_z = 19;
clearance_z = 100;
work_z = 900;
side_x = 7;

bbox_x = 1200;
bbox_y = 600;
bbox_z = 1200;

function bbox000(v) = [             0,             0,             0 ];
function bbox001(v) = [             0,             0, bbox_z - v[2] ];
function bbox010(v) = [             0, bbox_y - v[1],             0 ];
function bbox011(v) = [             0, bbox_y - v[1], bbox_z - v[2] ];
function bbox100(v) = [ bbox_x - v[0],             0,             0 ];
function bbox101(v) = [ bbox_x - v[0],             0, bbox_z - v[2] ];
function bbox110(v) = [ bbox_x - v[0], bbox_y - v[1],             0 ];
function bbox111(v) = [ bbox_x - v[0], bbox_y - v[1], bbox_z - v[2] ];

module component(v, name)
{
  cube(v);
  echo(name, v);
}

function leg()   = [ 75, 45, work_z - surface_z ];
function bleg()  = [ 75, 45, bbox_z - shelf_z ];
function xbeam() = [ bbox_x, 30, 90 ];
function ybeam() = [ 30, bbox_y - 60, 90 ];
function top()   = [ bbox_x, bbox_y, surface_z ];
function side()  = [ side_x, bbox_y - 60, work_z - 180 - clearance_z - surface_z - surface_z ];
function back()  = [ bbox_x - 60, side_x, work_z - 180 - clearance_z - surface_z - surface_z ];
function shelf() = [ bbox_x, 150, shelf_z ];

function fbox000(v) = bbox000(v) + [ 0, 0, 0 ];
function fbox001(v) = bbox001(v) + [ 0, 0, -(bbox_z-work_z)-surface_z ];
function fbox010(v) = bbox010(v) + [ 0, 0, 0 ];
function fbox011(v) = bbox011(v) + [ 0, 0, -(bbox_z-work_z)-surface_z ];
function fbox100(v) = bbox100(v) + [ 0, 0, 0 ];
function fbox101(v) = bbox101(v) + [ 0, 0, -(bbox_z-work_z)-surface_z ];
function fbox110(v) = bbox110(v) + [ 0, 0, 0 ];
function fbox111(v) = bbox111(v) + [ 0, 0, -(bbox_z-work_z)-surface_z ];

color(pine)
{
  translate(fbox000(leg()))   
    translate([ 30, 30, 0 ])
      component(leg(), "leg (front left)");

  translate(fbox010(bleg()))  
    translate([ 30, -30, 0 ])
      component(bleg(), "leg (back left)");

  translate(fbox100(leg()))   
    translate([ -30, 30, 0 ])
      component(leg(), "leg (front right)");

  translate(fbox110(bleg()))  
    translate([ -30, -30, 0 ])
      component(bleg(), "leg (back right)");

  translate(fbox000(xbeam())) 
    translate([ 0, 0, clearance_z ])
      component(xbeam(), "xbeam (front lower)");

  translate(fbox010(xbeam())) 
    translate([ 0, 0, clearance_z ])
      component(xbeam(), "xbeam (back lower)");

  translate(fbox001(xbeam())) 
    translate([ 0, 0, 0 ])
      component(xbeam(), "xbeam (front upper)");

  translate(fbox011(xbeam())) 
    translate([ 0, 0, 0 ])
      component(xbeam(), "xbeam (back upper)");

  translate(bbox011(xbeam())) 
    translate([ 0, -75, -shelf_z ])
      component(xbeam(), "xbeam shelf");

  translate(fbox000(ybeam())) 
    translate([ 0, 30, clearance_z ])
      component(ybeam(), "ybeam");

  translate(fbox100(ybeam())) 
    translate([ 0, 30, clearance_z ])
      component(ybeam(), "ybeam");

  translate(fbox001(ybeam())) 
    translate([ 0, 30, 0 ])
      component(ybeam(), "ybeam");

  translate(fbox101(ybeam())) 
    translate([ 0, 30, 0 ])
      component(ybeam(), "ybeam");

  translate(fbox001(ybeam())) 
    translate([ bbox_x/3, 30, 0 ])
      component(ybeam(), "ybeam");

  translate(fbox001(ybeam())) 
    translate([ bbox_x - bbox_x/3, 30, 0 ])
      component(ybeam(), "ybeam");

  translate(fbox000(ybeam())) 
    translate([ bbox_x/3, 30, clearance_z ])
      component(ybeam(), "ybeam");

  translate(fbox000(ybeam())) 
    translate([ bbox_x - bbox_x/3, 30, clearance_z ])
      component(ybeam(), "ybeam");

  translate(bbox011(shelf())) 
    component(shelf(), "shelf");
}

color(mdf)
{
  translate(bbox001(top()))
    translate([ 0, 0, -300 ] )
      component(top(), "surface (upper)");

  translate(bbox000(top()))
    translate([ 0, 0, clearance_z + 90 ])
      component(top(), "surface (lower)");

  translate(bbox000(side()))
    translate([ 30 - side_x, 30, clearance_z + 90 + surface_z ])
      component(side(), "side (left)");

  translate(bbox100(side()))
    translate([ - 30 + side_x, 30, clearance_z + 90 + surface_z ])
      component(side(), "side (left)");

  translate(bbox010(back()))
    translate([ 30, -30 + side_x, clearance_z + 90 + surface_z ])
      component(back(), "back");
}

//%cube([bbox_x, bbox_y, bbox_z]);