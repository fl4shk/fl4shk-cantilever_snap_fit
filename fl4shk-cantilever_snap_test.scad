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

//hole_part_diff_sz = [hx[0], bx[0] + bx[1] + (tol / 2.0)];
//hole_part_main_sz = [
//    hx[0] + hx[4],
//    Lx[1] + Lx[2] + hole_part_diff_sz.y - (tol / 2.0), //bx[0] + bx[1],
//];
//spread_sz_x = 2 * (hx[1] + hx[2]) + tol;
//
//module sf_hole_part(){
//    linear_extrude(b){
//        difference(){
//            square(hole_part_main_sz);
//            translate([0, Lx[1], 0])
//                square(hole_part_diff_sz);
//        }
//    }
//}
//
//union(){
//    translate([hx[0] + hx[4] + spread_sz_x, 0, 0])
//        sf_hole_part();
//    translate([hx[0] + hx[4], Lx[1] + hole_part_diff_sz.y + bx[3], 0])
//        linear_extrude(b){
//            square([spread_sz_x, Lx[2] - bx[3]]);
//        }
//    translate([hole_part_main_sz.x, 0, 0])
//        mirror([180, 0, 0])
//            sf_hole_part();
//    //translate([0, 0, b])
//    //    //rotate([180, 0, 180])
//    //        sf_hole_part();
//}



//thk = [5, 4];
//
//snap_base_sz = [10, 10];
//
//snap_ext_sz = [5, 1];
//snap_ext_pos = [snap_base_sz.x, 0.5 * (snap_base_sz.y - snap_ext_sz.y)];
//
//snap_tri_sz = [2, 2];
//snap_tri_pos = [
//    [
//        snap_ext_pos.x + snap_ext_sz.x - snap_tri_sz.x,
//        snap_ext_pos.y + snap_ext_sz.y
//    ],
//    [
//        snap_ext_pos.x + snap_ext_sz.x - snap_tri_sz.x,
//        snap_ext_pos.y
//    ],
//];
//snap_tri_pts = [
//    [
//        [0, 0],
//        [snap_tri_sz.x, 0],
//        [0, snap_tri_sz.y],
//    ],
//    //[
//    //    [0, 0],
//    //    [snap_tri_sz.x, 0],
//    //    [0, -snap_tri_sz.y],
//    //],
//];
//
////hole_sz = [
////];
//
//linear_extrude(thk[0]){
//    union(){
//        square(snap_base_sz);
//        translate(snap_ext_pos)
//            square(snap_ext_sz);
//        translate(snap_tri_pos[0])
//            polygon(snap_tri_pts[0]);
//        //translate(snap_tri_pos[1])
//        //    polygon(snap_tri_pts[1]);
//    }
//}
//
//hidx_cube = 0;
//hidx_hole = 1;
//hole_sz = [
//];


//linear_extrude(thk[0]){
//    difference(){
//        //square(base_sz);
//    }
//}




//linear_extrude(linext)
//difference(){
//    f2d_tzoid(a, b, h, 0.25);
//    translate([thk[0], 0, 0])
//        tzoid(a - thk[0] * 2, b - thk[0] * 2, h - thk[0]);
//}
//
////translate([0, 50, 0])
////linear_extrude(linext)
////tzoid(a - thk[1] * 2, b - thk[1] * 2, h - thk[1]);





//linear_extrude(4)
//rounding2d(0.25)
//fillet2d(0.25)
//tzoid(2, 8, 4);

//linear_extrude(10) square([8, 8], 0);
// dimensions are in millimeters
//polygon(
//    points = [ [x, y], ... ], paths = [ [p1, p2, p3..], ...] convesity = N);
//)
// for(i=[0:36])
//    translate([i*10,0,0])
//       cylinder(r=5,h=sin(i*10)*50+60);
//linear_extrude(10) {
//    
//}
//linear_extrude(10) {
//    circle(
//        r = 3
//    );
//}
//translate([0,-20,10]) {
//    rotate([90,180,90]) {
//        linear_extrude(50) {
//            polygon(
//                points = [
//                    //x,y
//                    /*
//                                O  .
//                    */
//                    [-2.8,0],
//                    /*
//                            O__X  .
//                    */
//                    [-7.8,0],
//                    /*
//                            O
//                            \
//                            X__X  .
//                    */
//                    [-15.3633,10.30],
//                    /*
//                            X_______._____O
//                            \         
//                            X__X  .
//                    */
//                    [15.3633,10.30],
//                    /*
//                            X_______._______X
//                            \             /
//                            X__X  .     O
//                    */
//                    [7.8,0],
//                    /*
//                            X_______._______X
//                            \             /
//                            X__X  .  O__X
//                    */
//                    [2.8,0],
//                    /*
//                        X__________.__________X
//                        \                   /
//                            \              O  /
//                            \            /  /
//                            \          /  /
//                            X__X  .  X__X
//                    */
//                    [5.48858,5.3],
//                    /*
//                        X__________.__________X
//                        \                   /
//                            \   O__________X  /
//                            \            /  /
//                            \          /  /
//                            X__X  .  X__X
//                    */
//                    [-5.48858,5.3],
//                                ]
//                            );
//                        }
//    }
//}
