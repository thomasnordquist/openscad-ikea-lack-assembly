use <triangular_bracket/triangular_bracket.internal.scad>;

// Configurations
materialWidth = 5;
length = sqrt(pow(50, 2) / 2);

supports = 3;
supportSize = 9;

// Computed properties
hyp = sqrt(pow(length, 2) + pow(length, 2));
triangleHeight = sqrt(pow(length, 2) - pow(hyp/2, 2));

module triangular_bracket() {
  translate([0, -materialWidth, 0]) union() {
    // Fill with cube between both sides
    translate([-0.5 * hyp, 0, 0])
      cube([hyp, materialWidth, materialWidth]);

    // Upright side
    translate([0, 0, triangleHeight+materialWidth])
      rotate([-90, 0, 0])
      rotate(45)
      side(length = length, materialWidth = materialWidth);

    // Floor side
    translate([0, -triangleHeight, materialWidth])
      rotate([0, 180, 0])
      rotate(45)
      side(length = length, materialWidth = materialWidth);

    translate([0, 0, materialWidth]) equidistantSupports(count = supports, size = supportSize,inLength = hyp);
  }
}

color("red") triangular_bracket();
