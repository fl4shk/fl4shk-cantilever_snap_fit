//--------
$fa = 1;
$fs = 0.4;

// NOTE: a suffix of `x` indicates that the variable has a subscript in
// `geometry.png`
L0_temp = 15;
L2_temp = 8;
b = 4;
bx = [2, 4, 6, L2_temp - 4];
hx = [2, 4, 2, 4, 4];
h = hx[2];
Lx = [L0_temp, L0_temp - (bx[0] + bx[1]), L2_temp];
tol = /*1.0;*/ /*0.8;*/ 0.4;
offs = 0.20;

module snap_fit_half(){
    linear_extrude(b){
        offset(r=-offs) offset(delta=offs)
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

module snap_fit(){
    union(){
        snap_fit_half();
        translate([0, 0, b])
            rotate([180])
                snap_fit_half();
    }
}
translate([40, 0, 0]){
    rotate([0, 0, -90])
    snap_fit();
}


//spread_sz_x = 2.0 * (hx[1] + hx[2]) + (tol /* / 2.0*/);
//module sf_hole_part(){
//    linear_extrude(b){
//        difference(){
//            square([
//                2.0 * (hx[0] + hx[4]) + spread_sz_x,
//                Lx[1] + bx[0] + bx[1] + Lx[2], 
//            ]);
//            union(){
//                translate([hx[4], Lx[1] - (tol / 2.0), 0])
//                    square([
//                        2.0 * hx[0] + spread_sz_x,
//                        bx[0] + bx[1] + tol
//                    ]);
//                translate([hx[0] + hx[4], 0, 0])
//                    square([
//                        spread_sz_x,
//                        Lx[1] + bx[0] + bx[1] + bx[3],
//                    ]);
//            }
//        }
//    }
//}

spread_sz_x_half = hx[1] + hx[2] + tol /*/ 2.0*/;

module sf_hole_part_half_noext(){
    //linear_extrude(b){
        difference(){
            square([
                hx[0] + hx[4] + spread_sz_x_half,
                Lx[1] + bx[0] + bx[2] + Lx[2],
            ]);
            union(){
                translate([hx[0] + hx[4], 0, 0])
                    square([
                        spread_sz_x_half,
                        Lx[1] + bx[0] + bx[1] + bx[3] + tol / 2.0
                    ]);
                translate([
                    hx[4],
                    Lx[1] - tol / 2.0,
                    0
                ])
                    square([
                        hx[0],
                        bx[0] + bx[1] + tol,
                    ]);
            }
        }
    //}
}
module sf_hole_part(){
    //offset(r=offs) offset(delta=-offs)
    linear_extrude(b){
        offset(r=-offs) offset(delta=offs)
        union(){
            sf_hole_part_half_noext();
            translate([2 * (hx[0] + hx[4] + spread_sz_x_half), 0, 0])
                mirror([180, 0, 0])
                    sf_hole_part_half_noext();
        }
    }
}

//translate([20, 0, 0])
    //rotate([0, 0, -180])
        sf_hole_part();
