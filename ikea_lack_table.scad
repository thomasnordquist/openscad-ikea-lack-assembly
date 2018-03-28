tabletopWidth = 50;
tableTopEdgeLength = 550;
tableHeight = 450;

tableBaseEdgeLength=50;
tableBaseHeight = tableHeight - tabletopWidth;

// Distance from origin to a table base
tableBaseDistance = tableTopEdgeLength-tableBaseEdgeLength;

module ikea_lack_table() {
  // Table top
  translate([0, 0, tableBaseHeight]) cube([tableTopEdgeLength, tableTopEdgeLength, tabletopWidth]);

  // Table base
  cube([tableBaseEdgeLength, tableBaseEdgeLength, tableBaseHeight]);
  translate([tableBaseDistance, 0]) cube([tableBaseEdgeLength, tableBaseEdgeLength, tableBaseHeight]);
  translate([0, tableBaseDistance]) cube([tableBaseEdgeLength, tableBaseEdgeLength, tableBaseHeight]);
  translate([tableBaseDistance, tableBaseDistance]) cube([tableBaseEdgeLength, tableBaseEdgeLength, tableBaseHeight]);
}

color("grey") ikea_lack_table();
