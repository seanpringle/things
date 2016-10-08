
mdf = "tan";
pine = "lemonchiffon";

function x(v) = v[0];
function y(v) = v[1];
function z(v) = v[2];

function length(v) = x(v);
function width(v)  = y(v);
function height(v) = z(v);

function mdf1() = [ 1200, 600, 12 ];

function pine1() = [ 1200, 75, 30 ];
function pine2() = [ 1200, 75, 45 ];
function pine3() = [ 1200, 90, 19 ];
function pine4() = [ 1200, 42, 19 ];

function cut(v,l) = [         l,  width(v), height(v) ];
function stand(v) = [ height(v),  width(v), length(v) ];
function spin(v)  = [  width(v), length(v), height(v) ];
function roll(v)  = [ length(v), height(v),  width(v) ];

surface_z = height(mdf1());
shelf_z = height(pine3());
clearance_z = 100;
work_z = 950;

bbox_x = length(mdf1());
bbox_y = width(mdf1());
bbox_z = length(pine1());

function bbox000(v) = [                  0,                 0,                  0 ];
function bbox001(v) = [                  0,                 0, bbox_z - height(v) ];
function bbox010(v) = [                  0, bbox_y - width(v),                  0 ];
function bbox011(v) = [                  0, bbox_y - width(v), bbox_z - height(v) ];
function bbox100(v) = [ bbox_x - length(v),                 0,                  0 ];
function bbox101(v) = [ bbox_x - length(v),                 0, bbox_z - height(v) ];
function bbox110(v) = [ bbox_x - length(v), bbox_y - width(v),                  0 ];
function bbox111(v) = [ bbox_x - length(v), bbox_y - width(v), bbox_z - height(v) ];

module component(v, name)
{
  cube(v);
  echo(name, v);
}

function leg()   = spin(stand(cut(pine1(), work_z - surface_z)));
function bleg()  = spin(stand(cut(pine1(), bbox_z - shelf_z )));
function xbeam() = roll(cut(pine3(), bbox_x));
function ybeam() = spin(roll(cut(pine3(), bbox_y - y(xbeam())*2)));
function top()   = mdf1();
function shelf() = cut(pine3(), bbox_x);
function lip()   = roll(cut(pine4(), bbox_x));

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
    translate([ x(ybeam()), x(ybeam()), 0 ])
      component(leg(), "leg (front left)");

  translate(fbox010(bleg()))
    translate([ x(ybeam()), -x(ybeam()), 0 ])
      component(bleg(), "leg (back left)");

  translate(fbox100(leg()))
    translate([ -x(ybeam()), x(ybeam()), 0 ])
      component(leg(), "leg (front right)");

  translate(fbox110(bleg()))
    translate([ -x(ybeam()), -x(ybeam()), 0 ])
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

  translate(fbox000(ybeam()))
    translate([ 0, x(ybeam()), clearance_z ])
      component(ybeam(), "ybeam");

  translate(fbox100(ybeam()))
    translate([ 0, x(ybeam()), clearance_z ])
      component(ybeam(), "ybeam");

  translate(fbox001(ybeam()))
    translate([ 0, x(ybeam()), 0 ])
      component(ybeam(), "ybeam");

  translate(fbox101(ybeam()))
    translate([ 0, x(ybeam()), 0 ])
      component(ybeam(), "ybeam");

  translate(fbox001(ybeam()))
    translate([ bbox_x/3, x(ybeam()), 0 ])
      component(ybeam(), "ybeam");

  translate(fbox001(ybeam()))
    translate([ bbox_x - bbox_x/3, x(ybeam()), 0 ])
      component(ybeam(), "ybeam");

  translate(fbox000(ybeam()))
    translate([ bbox_x/3, y(xbeam()), clearance_z ])
      component(ybeam(), "ybeam");

  translate(fbox000(ybeam()))
    translate([ bbox_x - bbox_x/3, y(xbeam()), clearance_z ])
      component(ybeam(), "ybeam");

  translate(bbox011(shelf()))
    translate([ 0, -y(xbeam()), 0 ])
      component(shelf(), "shelf");

  translate(bbox011(xbeam()))
    translate([ 0, 0, z(lip()) - z(shelf()) ])
      component(xbeam(), "shelf back");

  translate(bbox011(lip()))
    translate([ 0, -(y(pine3()) + z(pine3())), z(lip()) - z(shelf()) ])
      component(lip(), "shelf lip");
}

color(mdf)
{
  translate(bbox001(top()))
    translate([ 0, 0, -(bbox_z - work_z) ] )
      component(top(), "surface (upper)");

  translate(bbox000(top()))
    translate([ 0, 0, clearance_z + z(xbeam()) ])
      component(top(), "surface (lower)");
}

//%cube([bbox_x, bbox_y, bbox_z]);
