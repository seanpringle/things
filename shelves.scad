
mdf = "tan";
pine = "lemonchiffon";

function x(v) = v[0];
function y(v) = v[1];
function z(v) = v[2];

function length(v) = x(v);
function width(v)  = y(v);
function height(v) = z(v);

function mdf1() = [ 1200, 600, 12 ];
function mdf2() = [  900, 450,  9 ];

function pine1() = [ 1200, 75, 30 ];
function pine2() = [ 1200, 75, 45 ];
function pine3() = [ 1200, 90, 19 ];
function pine4() = [ 1200, 42, 19 ];
function pine5() = [ 1200, 42, 42 ];
function pine6() = [ 1200, 42, 30 ];

function cut(v,l) = [         l,  width(v), height(v) ];
function stand(v) = [ height(v),  width(v), length(v) ];
function spin(v)  = [  width(v), length(v), height(v) ];
function roll(v)  = [ length(v), height(v),  width(v) ];

clearance_z = 150;
work_z = 950;

bbox_x = 900;
bbox_y = 450;
bbox_z = 640;

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

function leg() = stand(cut(pine6(), bbox_z - z(surface())));
function xbeam() = roll(cut(pine3(), bbox_x));
function ybeam() = spin(roll(cut(pine3(), bbox_y - y(xbeam())*2)));
function surface() = cut(mdf2(), bbox_x);
function crate() = [ 385, 450, 270 ];


color(pine)
{
  translate(bbox000(leg()))
    translate([ x(ybeam()), y(xbeam()), 0 ])
      component(leg(), "leg front left");

  translate(bbox100(leg()))
    translate([ -x(ybeam()), y(xbeam()), 0 ])
      component(leg(), "leg front right");

  translate(bbox010(leg()))
    translate([ x(ybeam()), -y(xbeam()), 0 ])
      component(leg(), "leg back left");

  translate(bbox110(leg()))
    translate([ -x(ybeam()), -y(xbeam()), 0 ])
      component(leg(), "leg back left");

  translate(bbox000(xbeam()))
    translate([ 0, 0, clearance_z ])
      component(xbeam(), "xbeam front low");

  translate(bbox010(xbeam()))
    translate([ 0, 0, clearance_z ])
      component(xbeam(), "xbeam back low");

  translate(bbox000(ybeam()))
    translate([ 0, y(xbeam()), clearance_z ])
      component(ybeam(), "ybeam left low");

  translate(bbox100(ybeam()))
    translate([ 0, y(xbeam()), clearance_z ])
      component(ybeam(), "ybeam right low");

  translate(bbox001(xbeam()))
    translate([ 0, 0, -z(surface()) ])
      component(xbeam(), "xbeam front high");

  translate(bbox011(xbeam()))
    translate([ 0, 0, -z(surface()) ])
      component(xbeam(), "xbeam back high");

  translate(bbox001(ybeam()))
    translate([ 0, y(xbeam()), -z(surface()) ])
      component(ybeam(), "ybeam left high");

  translate(bbox101(ybeam()))
    translate([ 0, y(xbeam()), -z(surface()) ])
      component(ybeam(), "ybeam right high");


  translate(bbox001(ybeam()))
    translate([ bbox_x/2 - x(ybeam())/2, y(xbeam()), -z(surface()) ])
      component(ybeam(), "ybeam middle high");

  translate(bbox000(ybeam()))
    translate([ bbox_x/2 - x(ybeam())/2, y(xbeam()), clearance_z ])
      component(ybeam(), "ybeam middle low");

}

color(mdf)
{
  translate(bbox000(surface()))
    translate([ 0, 0, clearance_z + z(xbeam()) ])
      component(surface(), "surface low");

  translate(bbox001(surface()))
    component(surface(), "surface high");
}

color("cyan")
{
  translate(bbox000(crate()))
    translate([ 60, 0, clearance_z + z(xbeam()) + z(surface()) ])
      component(crate(), "crate1");

  translate(bbox000(crate()))
    translate([ 460, 0, clearance_z + z(xbeam()) + z(surface()) ])
      component(crate(), "crate1");
}
