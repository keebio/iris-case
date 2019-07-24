////////////////////////////
// User configurable options
////////////////////////////

two_unit_thumb = false;
stabilizers = true;
usb_c_pro_micro = true;
trrs_diameter = 6.55;
selector = 1;

///////////////////////////////
// Source code below this point
///////////////////////////////

$fs = .3;
$fa = 6;

mx_switch_height = 5;
pcb_height = 1.6;
trrs_jack_size = 5;
plate_thickness = 1.5;
height = mx_switch_height + pcb_height + trrs_jack_size + plate_thickness;
wall_thickness = 1.8;

_1_4th = 1/4 * 25.4;
key_distance = 3*_1_4th;
thumb_angle = -29.36;
thumb_offset = 5 * key_distance + 26.19;

_3_32nds = 3/32 * 25.4;
col3and5Shift = 2*_3_32nds;
col4Shift = 3*_3_32nds;
col6Shift = _3_32nds;

screw_head_diameter = 6.75;

mini_usb_port_width = 7.5;
usb_c_port_width = 9;

usb_port_height = usb_c_pro_micro == true ? 3.2 : 2.5;
left_usb_z_position = height - mx_switch_height - pcb_height - usb_port_height/2;
right_usb_z_position = plate_thickness + usb_port_height/2;

trrs_right_offset = 11.14 + trrs_jack_size/2;
trrs_left_offset = 13.32 + trrs_jack_size/2;

left = 1;
right = 2;

TOP_LEFT = 1;
BOTTOM_LEFT = 2;
TOP_RIGHT = 3;
BOTTOM_RIGHT = 4;
LEFT = 5;
RIGHT = 6;

module drawCase() {
    if(selector == TOP_LEFT || selector == LEFT) top(left);
    if(selector == BOTTOM_LEFT || selector == LEFT) bottom(left);
    if(selector == TOP_RIGHT || selector == RIGHT) top(right);
    if(selector == BOTTOM_RIGHT || selector == RIGHT) bottom(right);
}

module pcb_fit_test() {
    pro_micro_width = 17.5;
    case_skirt(wall_thickness, 0, wall_thickness/2);
    translate([47.5, 69, 0]){
        linear_extrude(pcb_height) {
            rotate(90) {
                import (file = "iris-pcb.dxf");
            }
        }
    }
    translate([-col4Shift - _3_32nds - 2.2, -pro_micro_width/2 + 3.5 * key_distance, pcb_height]) {
        cube([10, pro_micro_width, pcb_height]);
    }
    translate([-col4Shift - _3_32nds - 3.2, -mini_usb_port_width/2 + 3.5 * key_distance, pcb_height]) {
        cube([10, mini_usb_port_width, usb_port_height]);
    }
}

module usb_cutout(selector) {
    cutout_adjust = 0.1;
    width_top = mini_usb_port_width + cutout_adjust;
    width_bottom = 4.85 + cutout_adjust;
    port_height = usb_port_height + cutout_adjust;
    angle = selector == left ? 90 : 270;
    promicro_extension = 2;
    z_position = selector == left ? left_usb_z_position : right_usb_z_position;
  
    translate([-col4Shift - _3_32nds - promicro_extension, 3.5 * key_distance, z_position]) {
        rotate([0, angle, 0]) {
            hull () {
                if (usb_c_pro_micro) {
                    radius = 1;
                    usb_cutout_cylinders(-port_height/2 + radius, usb_c_port_width + cutout_adjust, radius);
                    usb_cutout_cylinders(port_height/2 - radius, usb_c_port_width + cutout_adjust, radius);
                } else {
                    radius = 0.5;
                    usb_cutout_cylinders(-port_height/2 + radius, width_top, radius);
                    usb_cutout_cylinders(0, width_top, radius);
                    usb_cutout_cylinders(port_height/2 - radius, width_bottom, radius);
                }
            }
        }
    }
}

module usb_cutout_cylinders(x, y, radius) {
    translate([x, y/2 - radius]) {
        cylinder(r=radius, h=10, center=true);
    }
    translate([x, -y/2 + radius]) {
        cylinder(r=radius, h=10, center=true);
    }
}

module usb_spacer(selector) {
    spacer_height = 5;
    spacer_margin = 5;
    spacer_width = usb_c_pro_micro == 1 ? usb_c_port_width + spacer_margin : mini_usb_port_width + spacer_margin;
    z_position = selector == left ? -spacer_height + left_usb_z_position : right_usb_z_position;

    translate([-key_distance, 3.5 * key_distance - spacer_width/2, z_position]) {
        cube([key_distance, spacer_width, spacer_height]);
    }
}

module reset_hole() {
    reset_hole_diameter = 2;
    reset_offset_pcb = 2.5;
    reset_offset_usb = 16;
    translate([0, 3.5 * key_distance + reset_offset_usb, height - mx_switch_height - pcb_height - reset_offset_pcb]) {
        rotate([0, 270]) {
            cylinder(d = reset_hole_diameter, h = 15);
        }
    }
}

module top(selector) {
    mirror([0, selector == right ? 1 : 0, 0]) {
        rotate ([180, 0, 0]) {
            translate([0, -145, -height]) {
                difference() {
                    union() {
                        difference() {
                            case_base(wall_thickness);
                            difference() {
                                union () {
                                    translate([-150, -150, -height + trrs_jack_size/2 + plate_thickness]) {
                                        cube([300, 300, height]);
                                    }
                                    translate([0, 0, trrs_jack_size/2 + plate_thickness -0.001]) {         
                                        case_skirt(wall_thickness/2, -0.001, wall_thickness/2 + 0.1);
                                    }
                                }
                                if (selector == right) {
                                    usb_spacer(right);
                                }
                            }
                            translate([0, 0, -plate_thickness]) {
                                case_base();
                            }
                            // Cut interior corner to fit PCB
                            translate([4 * key_distance - 1, 3.5 * key_distance, 0]){
                                rotate(-45) {
                                    cube([4, 4, 2 * (height - mx_switch_height)], center = true);
                                }
                            }
                        }                      
                        top_screw_posts();
                    }
                    reset_hole();
                    key_cutouts();
                    if (selector == left) {
                        trrs_cutout(-trrs_left_offset);
                        trrs_indent(-trrs_left_offset);
                        usb_cutout(left);
                        usb_spacer(left);
                    } else if (selector == right) {
                        trrs_cutout(-trrs_right_offset);
                        usb_cutout(right);
                    }    
                }
            }
        }
    }
}

module bottom(selector) {
    mirror([0, selector == right ? 1 : 0, 0]) {
        translate([110, 50, 0]) {
            difference() {
                union() {
                    difference() {
                        case_base(wall_thickness);
                        difference() {
                            union () {
                                translate([-150, -150, trrs_jack_size/2 + plate_thickness + wall_thickness/2]) {
                                    cube([300, 300, height]);
                                }
                                translate([0, 0, trrs_jack_size/2 + plate_thickness + 0.001]) {     
                                    case_skirt(wall_thickness + 0.001, wall_thickness/2 -0.05, wall_thickness/2);
                                }
                            }
                            if (selector == left) { 
                                usb_spacer(left);
                            }
                        }
                        translate([0, 0, plate_thickness]) {
                            case_base();
                        }
                    }
                    screw_posts(plate_thickness + trrs_jack_size - 0.15, screw_head_diameter + 2, screw_head_diameter + 2);
                }
                hull () {
                    reset_hole();
                    translate([0, 0, 10]) {
                        reset_hole();
                    }
                }
                bottom_screw_holes();
                trrs_position = selector == left ? -trrs_left_offset : -trrs_right_offset;
                hull () {
                    trrs_cutout(trrs_position);
                    translate([0, 0, 10]) {
                        trrs_cutout(trrs_position);
                    }
                }        
                if (selector == left) { 
                    trrs_indent(-trrs_left_offset);
                    usb_cutout(left);
                } else if (selector == right) {             
                    usb_spacer(right);
                    usb_cutout(right);
                }
                // Add a small indent in bottom place for the TRRS jack
                trrs_space_width = 6.5;
                translate([0, 0, -trrs_jack_size/2 + 2.00]){
                    position_trrs(trrs_position - trrs_space_width/2, -19.8){
                        cube([plate_thickness + 1, trrs_space_width, 13]);
                    }  
                }
            }
        }
    }
}

module trrs_cutout(dist_from_thumb) {
    trrs_cutout_radius = 2.6;
    position_trrs(dist_from_thumb, -23) {
        cylinder(r=trrs_cutout_radius, h=10, center=true);
    }
}

module trrs_indent(dist_from_thumb) {
    position_trrs(dist_from_thumb, -32.3) {
        rounded_cylinder(10, trrs_diameter, 2);
    }
}

module position_trrs(dist_from_thumb, y_offset) {
    translate([4.5 * key_distance, thumb_offset, height - mx_switch_height - pcb_height - mx_switch_height/2]) {
        rotate([0, 90, thumb_angle]){
            translate([0, dist_from_thumb, y_offset]) {
                children();
            }
        }
    }
}

module top_screw_posts() {
    screw_bind_diameter = 2.8;
    pcb_standoff_diameter = _1_4th + 2;
    difference () {
        union () {
            translate([0, 0, height - mx_switch_height]) {
                screw_posts(mx_switch_height, pcb_standoff_diameter, pcb_standoff_diameter);
            }
            translate([0, 0, height - mx_switch_height - pcb_height]) {
                screw_posts(plate_thickness + trrs_jack_size, _1_4th, _1_4th);
            }
        } 
        screw_posts(height + 0.001, screw_bind_diameter, screw_bind_diameter);
    }
}

module screw_posts(height, diameter_1, diameter_2) {
    arc_segments = 50;
    angled_thumb_offset = -10.96;
    translate([key_distance, key_distance]) {
        cylinder(h=height, d1=diameter_1, d2=diameter_2, $fn=arc_segments); 
    }
    translate([3 * key_distance, key_distance]) {
        cylinder(h=height, d1=diameter_1, d2=diameter_2, $fn=arc_segments); 
    }
    translate([key_distance - col3and5Shift + (col6Shift/2), 5 * key_distance]) {
        cylinder(h=height, d1=diameter_1, d2=diameter_2, $fn=arc_segments); 
    }
    translate([3 * key_distance - col3and5Shift + (col6Shift/2), 5 * key_distance]) {
        cylinder(h=height, d1=diameter_1, d2=diameter_2, $fn=arc_segments); 
    }
    translate([4.5 * key_distance, thumb_offset]) {
        rotate(thumb_angle) {
            translate([0, angled_thumb_offset]) {
                cylinder(h=height, d1=diameter_1, d2=diameter_2, $fn=arc_segments); 
            }
        }
    }
}

module bottom_screw_holes() {
    screw_hole_radius = 1.6;
    screw_head_height = 1.5;
    cone_height = screw_head_diameter/2 - screw_hole_radius;
    cone_distance_from_top = 2;
    
    translate([0, 0, -0.001]) {
        screw_posts(plate_thickness + trrs_jack_size - cone_height - cone_distance_from_top + 0.002, screw_head_diameter, screw_head_diameter);
    }
    translate([0, 0, plate_thickness + trrs_jack_size - cone_height - cone_distance_from_top]) {
        screw_posts(cone_height, screw_head_diameter, 2 * screw_hole_radius);
    }
    screw_posts(plate_thickness + trrs_jack_size, 2 * screw_hole_radius, 2 * screw_hole_radius);
}

module key_cutouts() {
    for (i = [0 : 3]) {
        key_cutout(i * key_distance, 0);
        key_cutout(i * key_distance, key_distance);
        key_cutout(i * key_distance - col3and5Shift, 2 * key_distance);
        key_cutout(i * key_distance - col4Shift, 3 * key_distance);
        key_cutout(i * key_distance - col3and5Shift, 4 * key_distance);
        key_cutout(i * key_distance - col6Shift, 5 * key_distance);          
    }
    key_cutout(4 * key_distance - col6Shift, 3.5 * key_distance);
    key_cutout(4 * key_distance, 4.5 * key_distance);          
    
    translate([4.5 * key_distance, thumb_offset]) {
        rotate(thumb_angle) {
            union() {
                if (two_unit_thumb) {
                    key_cutout(-key_distance/2, -key_distance/2);
                    // Cut a notch out of the thumb screw post so the switch can clip in
                    translate ([-4, -8, 0]) {
                        cube([8, 8, height - plate_thickness]);
                    }   
                    if (stabilizers) {
                        switch_stabilizer_distance = 12;
                        stabilizer_cutout(switch_stabilizer_distance);
                        stabilizer_cutout(-switch_stabilizer_distance);

                        // Cut notch for stablizer bar
                        translate ([-4, -9, 0]) {
                            cube([8, 8, height - 5 + 2.5]);
                        }                       
                    }
                } else {
                    key_cutout(0, -key_distance/2);
                    key_cutout(-key_distance, -key_distance/2);
                }            
            }
        }
    }
}

module key_cutout(x, y) {
    switch_cutout_dimension = 14.1;
    switch_gap = key_distance - switch_cutout_dimension;
    translate ([x + switch_gap/2, y + switch_gap/2, 0]) {
        cube([switch_cutout_dimension, switch_cutout_dimension, height + 0.01]);
    }
}

module stabilizer_cutout(x) {
    cutout_x = 7.25;
    cutout_y = 11.5;
    notch_x = 2.5;
    notch_y = cutout_y + notch_x/2;
    
    translate ([x, 0, height/2]) {
        cube([cutout_x, cutout_y, height + 0.01], center = true);
        translate([0, -notch_x/4]) {
            cube([notch_x, notch_y, height + 0.01], center = true);
        }
    }
}

module case_skirt(outer_offset, inner_offset, height) {
    difference() {
        linear_extrude(height) {
            projection() {
                case_base(outer_offset);
            }
        }
        translate([0, 0, -0.001]) {
            linear_extrude(height + 0.002) {
                projection() {
                    case_base(inner_offset);
                }
            }
        }
    }
}

module case_base(edgeAdjust = 0) {
    edge_diameter = 6;
    surface_diameter = 3;
    
    // main body
    hull() {
        left_y_main = edge_diameter/2 - edgeAdjust + 0.85;
        right_y_main = -edge_diameter/2 + 6 * key_distance + edgeAdjust - 0.25;
        bottom_x_main = -edge_diameter/2 + 4 * key_distance + edgeAdjust - 0.5;      
        back_bump_x = edge_diameter/2 - col4Shift - edgeAdjust - _3_32nds - 2.3;
              
        // upper left corner
        translate([edge_diameter/2 - edgeAdjust + 1.4, left_y_main]) {
            rounded_cylinder(height, edge_diameter, surface_diameter);
        }            
        // upper right corner
        translate([edge_diameter/2 - col6Shift - edgeAdjust + 0.5, right_y_main]) {
            rounded_cylinder(height, edge_diameter, surface_diameter);
        }                
        translate([bottom_x_main, left_y_main]) {
            rounded_cylinder(height, edge_diameter, surface_diameter);
        }
        translate([bottom_x_main, right_y_main]) {
            rounded_cylinder(height, edge_diameter, surface_diameter);
        }             
        // left back bump
        translate([back_bump_x, 3 * key_distance]) {
            rounded_cylinder(height, edge_diameter, surface_diameter);
        }
        // right back bump
        translate([back_bump_x, 3 * key_distance + 30]) {
            rounded_cylinder(height, edge_diameter, surface_diameter);
        }
    }
    // lower body thumb
    hull() {
        top_x_thumb = -edge_diameter/2 + 3 * key_distance;
        bottom_x_thumb = -edge_diameter/2 + 5 * key_distance - col6Shift + edgeAdjust - 0.5;
        right_y_thumb = -edge_diameter/2 + 5.5 * key_distance + edgeAdjust;
        left_y_thumb = edge_diameter/2 + 3.5 * key_distance - edgeAdjust - 0.5;
                    
        translate([top_x_thumb, left_y_thumb]) {
            rounded_cylinder(height, edge_diameter, surface_diameter);
        }
        translate([bottom_x_thumb, left_y_thumb]) {
            rounded_cylinder(height, edge_diameter, surface_diameter);
        }
        translate([top_x_thumb, right_y_thumb]) {
            rounded_cylinder(height, edge_diameter, surface_diameter);
        }
        z_rotate_relative(-7.27, bottom_x_thumb, left_y_thumb) {
            translate([bottom_x_thumb, right_y_thumb]) {
                rounded_cylinder(height, edge_diameter, surface_diameter);
            }
        }
    }
    // angled thumb
    hull() {
        top_x_angled_thumb = edge_diameter/2 - key_distance - edgeAdjust - 0.75;
        bottom_x_angled_thumb = -edge_diameter/2 + key_distance + edgeAdjust + 0.1;
        right_y_angled_thumb = -edge_diameter/2 + key_distance/2 + edgeAdjust - 0.25;
        left_y_angled_thumb = -edge_diameter/2 - 1.5 * key_distance - 1;

        translate([4.5 * key_distance, thumb_offset, 0]) {
            rotate(thumb_angle) {
                translate([top_x_angled_thumb, right_y_angled_thumb]) {
                    rounded_cylinder(height, edge_diameter, surface_diameter);
                }
                translate([top_x_angled_thumb, left_y_angled_thumb]) {
                    rounded_cylinder(height, edge_diameter, surface_diameter);
                }    
                translate([bottom_x_angled_thumb, right_y_angled_thumb]) {
                    rounded_cylinder(height, edge_diameter, surface_diameter);
                }         
                z_rotate_relative(4.45, bottom_x_angled_thumb, right_y_angled_thumb) {
                    translate([bottom_x_angled_thumb, left_y_angled_thumb]) {
                        rounded_cylinder(height, edge_diameter, surface_diameter);
                    }
                }
            }
        }
    }
}

module z_rotate_relative(angle, point_x, point_y) {
    translate([point_x, point_y]) {
        rotate(angle) {
            translate([-point_x, -point_y]) {
                children();
            }
        }
    }
}

module rounded_cylinder(height, diameter, surface_diameter, fa = $fa) {
    translate([0, 0, surface_diameter/2]) {
        hull () {
            rotate_extrude($fa = fa) {
                translate([diameter/2 - surface_diameter/2, 0, 0]) {
                    circle(d=surface_diameter);
                }
            }
            translate([0, 0, height - surface_diameter]) {
                rotate_extrude($fa = fa) {
                    translate([diameter/2 - surface_diameter/2, 0, 0]) {
                        circle(d=surface_diameter);
                    }
                }
            }
        }
    }
}
drawCase();
