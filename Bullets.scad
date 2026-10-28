// ============================================================
// Playing-card suits — rotate_extrude FROM THE CENTER
// Hearts · Spades · Diamonds · Clubs
// ============================================================

$fn = 72;

// ---------- 2-D profiles (left-right symmetric) ----------

module heart_2d(s = 10) {
    scale(s/20)
    union() {
        translate([-6, 6])  circle(r = 6.5);
        translate([ 6, 6])  circle(r = 6.5);
        polygon([[-12.5,6],[0,-14],[12.5,6]]);
    }
}

module spade_2d(s = 10) {
    scale(s/20)
    union() {
        translate([-6,-2]) circle(r = 6.5);
        translate([ 6,-2]) circle(r = 6.5);
        polygon([[-12.5,-2],[0,14],[12.5,-2]]);
        translate([0,-12]) square([3.5,10], center=true);
        translate([0,-17]) square([9,3], center=true);
    }
}

module diamond_2d(s = 10) {
    scale(s/20)
    polygon([[0,16],[11,0],[0,-16],[-11,0]]);
}

module club_2d(s = 10) {
    scale(s/20)
    union() {
        translate([ 0, 7]) circle(r = 6.2);
        translate([-7,-2]) circle(r = 6.2);
        translate([ 7,-2]) circle(r = 6.2);
        translate([0,-11]) square([3.2,12], center=true);
        translate([0,-17]) square([9,3], center=true);
    }
}

// ---------- revolve FROM THE CENTER ----------
// leftmost point of each profile sits exactly on the Y-axis

module heart_revolve(s = 10) {
    rotate_extrude(convexity = 8)
        translate([12.5 * s/20, 0])   // exact left edge → axis
            heart_2d(s);
}

module spade_revolve(s = 10) {
    rotate_extrude(convexity = 8)
        translate([12.5 * s/20, 0])
            spade_2d(s);
}

module diamond_revolve(s = 10) {
    rotate_extrude(convexity = 6)
        translate([11 * s/20, 0])
            diamond_2d(s);
}

module club_revolve(s = 10) {
    rotate_extrude(convexity = 10)
        translate([13.2 * s/20, 0])   // farthest left lobe
            club_2d(s);
}

// ---------- layout ----------

size    = 12;
spacing = 30;

translate([-1.5*spacing, 0, 0]) color("crimson") heart_revolve(size);
translate([-0.5*spacing, 0, 0]) color("black")   spade_revolve(size);
translate([ 0.5*spacing, 0, 0]) color("crimson") diamond_revolve(size);
translate([ 1.5*spacing, 0, 0]) color("black")   club_revolve(size);
