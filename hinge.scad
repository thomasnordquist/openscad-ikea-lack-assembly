$fn=32;

outerDiameter=5;
wallThickness=2;
innerDiameter = outerDiameter - wallThickness;
mountLength=25;
height=35;

zFightFix=0.01;

module screwHole(screwDiameter, headDiameter, headHeight, shaftLength=4) {
    union() {
      translate([0, 0, -0.01]) cylinder(r2 = screwDiameter/2, r1 = headDiameter/2, h = headHeight+0.02, $fn=24);
      translate([0, 0, headHeight]) cylinder(r1 = screwDiameter/2, r2 = screwDiameter/2, h = shaftLength, $fn=24);
    }
}

module mount() {
  mountHeight = height / 2;
    translate([0, outerDiameter-wallThickness, 0])
      difference() {
        cube([mountLength, wallThickness, mountHeight]);
        translate([10, -zFightFix, mountHeight/3]) rotate([-90, 0, 0]) screwHole(4, 6, 1);
        translate([18, -zFightFix, mountHeight/3*2]) rotate([-90, 0, 0]) screwHole(4, 6, 1);

      }
}

module male() {
  union() {
    cylinder(r1 = outerDiameter, r2 = outerDiameter, h = height/2);
    translate([0, 0, height/2]) cylinder(r1 = innerDiameter, r2 = innerDiameter, h = height/2);
  };
  mount();
}

module female() {
  difference() {
    cylinder(r1 = outerDiameter, r2 = outerDiameter, h = height/2);
    translate([0, 0, -zFightFix]) cylinder(r1 = innerDiameter, r2 = innerDiameter, h = height/2 - wallThickness);
  }
  mirror([1, 0, 0]) mount();
}

male();
translate([0, 0, 0.5 * height + 0.5]) female();
