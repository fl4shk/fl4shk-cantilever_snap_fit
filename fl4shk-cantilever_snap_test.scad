//--------
$fa = 1;
$fs = 0.4;

// units are mm

// NOTE: a suffix of `x` indicates that the variable has a subscript in
// `geometry.png`
//L0_temp = 15;
//L1_temp = 8;
b = 4;
//b0_temp = 15 / 2.0;
//b1_temp = 15;
bx = [15.0 / 2.0, 3, 6, 4];
hx = [2, 4, 2, 4, 4];
h = hx[2];
Lx = [2.0 * bx[0], bx[3] + 4];
tol_temp = /*1.0;*/ /*0.8;*/ 0.4;
alpha = tol_temp;
beta = tol_temp / 2.0;
offs = /*0.20*/ 0.1;

module snap_fit_half(){
    linear_extrude(b){
        offset(r=-offs) offset(delta=offs)
        union(){
            //translate([0.5, 0, 0]) // apply slight pressure to the snap
            square([bx[2], hx[1] + hx[2] + hx[3]]);
            translate([bx[2], hx[1], 0])
                square([Lx[0], hx[2]]);
            translate([bx[2] + bx[0] - bx[1], hx[1] + hx[2]])
                polygon(points=[
                    [0, 0],
                    [bx[1], 0],
                    [bx[1], hx[0]],
                ]);
            translate([bx[0] + bx[2], hx[1] + hx[2]])
                polygon(points=[
                    [0, 0],
                    [0, hx[0]],
                    [bx[0], 0],
                ]);
        }
    }
}


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


spread_sz_x_half = hx[1] + hx[2] + beta /*+ tol / 2.0*/;
temp_sz_x = hx[0] + hx[4];
my_h = [
    temp_sz_x,
    temp_sz_x + spread_sz_x_half,
    temp_sz_x - hx[0],
];

my_b = [
    bx[0] - bx[1] /*-*/ + beta,
    bx[0] + bx[1] + alpha,
    bx[3],
    Lx[1] - beta,
];

module sf_hole_part_half_noext(){
    difference(){
        //square([
        //    hx[0] + hx[4] + spread_sz_x_half,
        //    //Lx[0] + bx[2],
        //    bx[0] - beta + bx[0] + alpha + Lx[1] - beta
        //]);
        //union(){
        //    translate([hx[4], bx[0] - beta, 0])
        //        square([hx[0], bx[0] + alpha]);
        //    translate([hx[0] + hx[4], 0, 0])
        //        square([spread_sz_x_half, bx[0] * 2 + bx[3] + beta]);
        //}
        //square([
        //    hx[0] + hx[4] + spread_sz_x_half,
        //    bx[0] - bx[1] - beta + bx[0] + bx[1] + alpha + Lx[1] - beta,
        //]);
        //union(){
        //    translate([hx[4], bx[0] - bx[1] - beta, 0])
        //        square([hx[0], bx[0] + bx[1] + alpha]);
        //    translate([hx[0] + hx[4], 0, 0])
        //        square([spread_sz_x_half, bx[0] * 2 + bx[3]]);
        //}
        square([
            my_h[1],
            my_b[0] + my_b[1] + my_b[3],
        ]);
        union(){
            translate([my_h[2], my_b[0], 0])
                square([hx[0], my_b[1]]);
            translate([my_h[0], 0, 0])
                square([spread_sz_x_half, my_b[0] + my_b[1] + my_b[2]]);
        }
    }
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

sf_hole_part();
