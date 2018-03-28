length = 150;
height = 30;
materialWidth = 10;

mountPointLength = 20;

// Edges represent the upper and lower edge of the extruded polygon
function topEdge() = [[0, materialWidth], [mountPointLength, height], [length - mountPointLength, height], [length, materialWidth]];
function bottomEdge() = [[length, 0], [length - mountPointLength, 0], [length - 2*mountPointLength, height - materialWidth], [2 * mountPointLength, height - materialWidth], [mountPointLength, 0], [0, 0]];

module shape() {
  translate([-0.5 * length, 0, 0]) polygon(points =
    concat(topEdge(), bottomEdge())
  );
}

module innerShape() {
  translate([-0.5 * length, 0, 0]) polygon(bottomEdge());
}

module edgeShape() {
  difference() {
    linear_extrude(height = 5, scale = 0.9) shape();
    translate([0, -0.01, 0]) // Z-Fight fix
      linear_extrude(height = 6, scale = 1.1)
      innerShape();
  }
}

module screw(radius = 4, headRadius = 6, headHeight = 2, screwDepth = 20, headDepth = 40) {
  union() {
    translate([0, 0, -screwDepth - headHeight]) cylinder(r1 = radius, r2 = radius, h = screwDepth, $fn = 24);
    translate([0, 0, -headHeight]) cylinder(r1 = radius, r2 = headRadius, h = headHeight, $fn = 24);
    cylinder(r1 = headRadius, r2 = headRadius, h = headDepth, $fn = 24);
  }
}

module handleShape() {
  translate([0, 6, 0]) rotate([90, 0, 0]) union() {
    translate([0, 0, 12]) edgeShape();
    linear_extrude(height = 12) shape();
    translate([0, 0, 0]) mirror([0, 0, 1]) edgeShape();
  }
}

module door_handle() {
  screwCenterOffset = (length/2 - mountPointLength/2);
  screwHeightOffset = materialWidth;
  difference() {
    handleShape();
    translate([-screwCenterOffset, 0, screwHeightOffset]) screw();
    translate([screwCenterOffset, 0, screwHeightOffset]) screw();
  }
}

color("grey") door_handle();
