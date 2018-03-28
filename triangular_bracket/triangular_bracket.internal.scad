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

module support(width, size) {
  rotate([90+45, 0, 0]) rotate([0, 90, 0]) rotate(45) triangularPrism(length = size, width = width);
}

module equidistantSupports(count = 3, inLength = 4) {
  width = 2;
  distance = (inLength) / (count+1);
  translate([-0.5 * inLength, 0, 0])
  translate([-0.5 * width, 0, 0])

  for (i = [1:count]) {
      translate([i*distance, 0, 0]) support(width, size);
  }
}

module screwHole(screwDiameter, headDiameter, headHeight, shaftLength=4) {
    union() {
      translate([0, 0, -0.01]) cylinder(r2 = screwDiameter/2, r1 = headDiameter/2, h = headHeight+0.02, $fn=24);
      translate([0, 0, headHeight]) cylinder(r1 = screwDiameter/2, r2 = screwDiameter/2, h = shaftLength, $fn=24);
    }
}

module side(length, materialWidth) {
  difference() {
    intersection() {
      triangularPrism(length = length, width = materialWidth);
      translate([length/1.25, length/1.25, -materialWidth+1]) cylinder(r1=length, r2=length, h=materialWidth*2, $fn=24);
    }
    //translate([1.3, 1.3]) screwHole(screwDiameter = 0.4, headDiameter = 0.8, headHeight = 0.1);
    translate([17, 8]) screwHole(screwDiameter = 4, headDiameter = 8, headHeight = 1);
    translate([8, 17]) screwHole(screwDiameter = 4, headDiameter = 8, headHeight = 1);
  }
}
