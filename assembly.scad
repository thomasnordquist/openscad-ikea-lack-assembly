use <corner.scad>;
use <ikea_lack_table.scad>;
use <door_handle.scad>;

// Table tower
color("black") ikea_lack_table();
translate([0, 0, 450]) color("grey") ikea_lack_table();

module footMount() {
  //translate([0, 50, 0]) mirror([1, 1, 0]) rotate([0, 0, -90]) color("red") corner();
  translate([50, 0, 0]) rotate([0, 0, 0]) color("red") corner();
  translate([0, 50, 0]) mirror([1, 1, 0]) rotate([0, 0, -180]) color("red") corner();
}

module window() {
  cube([450, 5, 400]);
}

module windowMounts() {
  translate([0, 0, 0]) footMount();
  translate([550, 0, 0]) rotate([0, 0, 90]) footMount();
  translate([0, 550, 0]) rotate([0, 0, 270]) footMount();
  translate([550, 550, 0]) rotate([0, 0, 180]) footMount();
}

module windows() {
  translate([50, 0, 450]) window();
  rotate([0, 0, 90]) translate([50, -5, 450]) window();
  rotate([0, 0, 90]) translate([50, -550, 450]) window();
  translate([50, 545, 450]) window();
}

translate([0, 0, 450]) windowMounts();
translate([0, 0, 850]) mirror([0, 0, 1]) windowMounts();
color("grey", 0.3) windows();

color("orange") translate([450, 00.1, 640]) rotate([0, -90, 90]) door_handle();
