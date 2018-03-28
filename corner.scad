width = 35;
materialWidth = 3;
windowMaterialWidth = 5;
windowSupport = materialWidth - windowMaterialWidth;

triangleWidth = width - 5;

module triangle(edge = 1) {
  polygon(points=[
    [0, 0], [0, edge], [edge, 0]
  ]);
};

// Upright triangle
module triangularPrism(length = 4, width = 0.3) {
    linear_extrude(height = width)
    triangle(length);
};

module screwHole(screwDiameter, headDiameter, headHeight, shaftLength=4) {
    union() {
      translate([0, 0, -0.01]) cylinder(r2 = screwDiameter/2, r1 = headDiameter/2, h = headHeight+0.02, $fn=24);
      translate([0, 0, headHeight]) cylinder(r1 = screwDiameter/2, r2 = screwDiameter/2, h = shaftLength, $fn=24);
    }
}

module screwHoles() {
  translate([17, 6, 3]) rotate([180, 0, 0]) screwHole(screwDiameter = 3, headDiameter = 5, headHeight = 1.5, shaftLength = 5);
  translate([6, 17, 3]) rotate([180, 0, 0]) screwHole(screwDiameter = 3, headDiameter = 5, headHeight = 1.5, shaftLength = 5);
}

module corner() {
  // Sides
  translate([materialWidth, windowMaterialWidth + materialWidth, 0]) difference() {
    triangularPrism(length = triangleWidth, width = materialWidth);
    screwHoles();
  }


  translate([0, windowMaterialWidth + materialWidth, materialWidth]) rotate([0, 90, 0]) rotate([0, 0, 90]) difference() {
    triangularPrism(length = triangleWidth, width = materialWidth);
    screwHoles();
  }
  // Window side
  translate([materialWidth, windowMaterialWidth + materialWidth, materialWidth]) rotate([90, 0, 0]) triangularPrism(length = triangleWidth, width = materialWidth);

  // Fill edges
  translate([0, windowMaterialWidth+ materialWidth, 0]) cube([materialWidth, triangleWidth, materialWidth]);
  translate([0, windowMaterialWidth, materialWidth]) cube([materialWidth, materialWidth, triangleWidth]);
  translate([materialWidth, windowMaterialWidth, 0]) cube([triangleWidth, materialWidth, materialWidth]);

  // corner
  translate([0, windowMaterialWidth, 0]) cube([materialWidth, materialWidth, materialWidth]);

  cornerBackplate();
}

module cornerPlateScrews(screwTerminalWidth) {
  translate([screwTerminalWidth/2, 0, 8]) rotate([-90, 0, 0]) screwHole(screwDiameter = 3, headDiameter = 5, headHeight = 1.5, shaftLength = 5);
  translate([screwTerminalWidth/2, 0, 25]) rotate([-90, 0, 0]) screwHole(screwDiameter = 3, headDiameter = 5, headHeight = 1.5, shaftLength = 5);
}

module cornerBackplate() {
  screwTerminalWidth = 12;

  translate([materialWidth, 0, materialWidth]) rotate([90, 0, 0]) triangularPrism(length = triangleWidth, width = materialWidth);

  // Edges
  translate([0, -materialWidth, materialWidth]) cube([materialWidth, materialWidth, triangleWidth]);
  translate([materialWidth, -materialWidth, 0]) cube([triangleWidth, materialWidth, materialWidth]);
  // corner
  translate([0, -materialWidth, 0]) cube([materialWidth, materialWidth, materialWidth]);

  // Screw terminals
  translate([-screwTerminalWidth, -materialWidth, 0]) difference() {
    cube([screwTerminalWidth, materialWidth, triangleWidth + materialWidth]);
    cornerPlateScrews(screwTerminalWidth);
  }
  translate([0, -materialWidth, -screwTerminalWidth]) difference() {
    cube([triangleWidth + materialWidth, materialWidth, screwTerminalWidth]);
    translate([0, 0, screwTerminalWidth]) rotate([0, 90, 0]) cornerPlateScrews(screwTerminalWidth);
  }

  // Fill corner
  rotate([90, 180, 0]) triangularPrism(length = screwTerminalWidth, width = materialWidth);
}

// Preview
color("red") corner();
