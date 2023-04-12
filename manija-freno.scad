$fa = 1;
$fs = 0.4;

diametro = 12.5;
radio1 = 3;
radio2 = 2.5;
largo = 29.3;
alto = 16.5;
ancho = 7;

d_vastago = 6.35 + .9;
a_vastago = 13.2;

d_tornillo = 3.8;
a_tornillo = 9;
l_tuerca = 7;
a_tuerca = 2.8;

alfa = 55;

//off = (diametro+d_vastago)/4;
off = d_vastago/2+a_tuerca/2;

module base () {
  circle(d=diametro);
  translate([-ancho/2,0,0]){  
    hull() {      
      square(ancho);
      translate([ancho-radio1,largo-radio1-diametro/2,0])
        circle(radio1);
      translate([0,largo-ancho/2-diametro/2,0])
        square(ancho/2);
    }
    translate([0,largo-radio2-diametro/2,0])
      circle(radio2);    
  }
  hull(){
    rotate([0,0,-alfa])
      translate([-l_tuerca*1.4,diametro/2-a_tuerca,0])
        square([2*l_tuerca,2.6*a_tuerca],center=false);
    translate([0,-diametro/2,0])
      square([diametro/2,diametro/2]);
  }
}

module tuerca(){
  difference(){
    cube([l_tuerca,l_tuerca,a_tuerca], center=true);
    translate([0,0,-a_tuerca])
      cylinder(h=3*a_tuerca,d=d_tornillo);
  }
}

module tornillo(){
  cylinder(h=a_tornillo,d=d_tornillo);
  translate([0,0,a_tornillo])
    difference(){
      sphere(r=d_tornillo);
      translate([0,0,-d_tornillo])
        cube(d_tornillo*2,center=true);
  }
}

module manija(){
  difference() {
    linear_extrude(alto) base();
    translate([0,0,-.01])
      cylinder(h=a_vastago, d=d_vastago);    
    for (s=[-1])
      rotate([0,0,s*alfa]) {
        // tuercas
        rotate([0,0,90])
          translate([off, 0, l_tuerca])
            rotate([0,90,0])
              cube([alto,l_tuerca,a_tuerca],center=true);
        // tornillos
        translate([0,0,alto/2])
          rotate([90,0,180])
            cylinder(h=diametro,d=d_tornillo);
      }
  }
}

//base();
rotate([0,180,0]) manija();
//rotate(180) completo();

//tornillo();

module completo () {
manija();
color("silver")
translate([0,0,-alto/3])
  for (s=[-1])
    rotate([0,0,s*alfa]) {
      // tuercas
//      rotate([0,0,90])
//        translate([off, 0, 0])
//          rotate([0,90,0])
//            tuerca();
      // tornillos
      translate([0,0,-10])
      #  rotate([90,0,180])
          translate([0,0,a_tornillo/2-a_tuerca/2])
          tornillo();
  }
}