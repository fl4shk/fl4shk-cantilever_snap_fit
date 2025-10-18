//--------
$fa = 1;
$fs = 0.4;

//cdiff = 0.001;
//dim_diff
//    = 0.5;
//tol = 0.51;

//thk = 5;
L0_temp = 15;
L2_temp = 8;
b = 4;
bx = [2, 4, 6, L2_temp - 4];
hx = [2, 4, 2, 4, 4];
h = hx[2];
Lx = [L0_temp, L0_temp - (bx[0] + bx[1]), L2_temp];
tol = 0.8; //0.4;

module snap_fit(){
    linear_extrude(b){
        union(){
            square([bx[2], hx[1] + hx[2] + hx[3]]);
            translate([bx[2], hx[1], 0])
                square([Lx[0], hx[2]]);
            translate([Lx[1] + bx[0] + bx[2], hx[1] + hx[2], 0])
                polygon([
                    [0, 0],
                    [bx[1], 0],
                    [0, hx[0]],
                ]);
            translate([Lx[1] + bx[2], hx[1] + hx[2], 0])
                square([bx[0], hx[0]]);
        }
    }
}

//translate([0, -(hx[1] + hx[2] + hx[3]), 0])

translate([30, 0, 0]){
    snap_fit();
    translate([0, 0, b])
        rotate([180])
            snap_fit();
}

spread_sz_x = 2.0 * (hx[1] + hx[2]) + (tol / 2.0);

module sf_hole_part(){
    linear_extrude(b){
        difference(){
            square([
                2.0 * (hx[0] + hx[4]) + spread_sz_x,
                Lx[1] + bx[0] + bx[1] + Lx[2], 
            ]);
            union(){
                translate([hx[4], Lx[1] - (tol / 2.0), 0])
                    square([
                        2.0 * hx[0] + spread_sz_x,
                        bx[0] + bx[1] + tol
                    ]);
                translate([hx[0] + hx[4], 0, 0])
                    square([
                        spread_sz_x,
                        Lx[1] + bx[0] + bx[1] + bx[3],
                    ]);
            }
        }
    }
}
sf_hole_part();
