 
//$vpr = [45,0,30];
//$vpt = [0,-150,0];
//$vpd = 1200;

// http://fwcg.3dzone.dk/
// https://www.flitetest.com/articles/kfm-6-flying-wing


// Printed parts 71.75 g single shell, 5% infill
// Foam 123g = 41g per sheet assume 3 sheets (maybe less than 2)
// ESC 40g  https://www.unmannedtechshop.co.uk/product/dys-20a-2-4s-brushless-esc-with-5v-2a-bec-for-rc-fixed-wing-aircraft/
// Motor 32g https://www.unmannedtechshop.co.uk/product/emax-eco-ii-series-2207-motor/
// Battery 70g
// Props https://www.unmannedtechshop.co.uk/product/hqprop-t5-1x2-5x3-grey-propeller-2cw2ccw/
// 312g 
// Add for camera
//  camera VTX  https://www.aliexpress.com/item/1005008234258917.html?spm=a2g0o.cart.0.0.5ac538dalBiVNT&mp=1 and generic Camera 
// Add for flight controller (5.6g) https://www.hobbyrc.co.uk/speedybee-f405-wing-mini-flight-controller
// GPS https://www.unmannedtechshop.co.uk/product/tbs-m10-gps-glonass-module/
// Add for servos


// Used 350g for calcs


// Costs 
// Printed parts: £1.72
// Foam sheets:  £6.99 for 10 sheets
// ESC: £8.49
// Motor: £12.99
// Battery: £14.50
// Props: £2.37
// Camera: 
// Flight Controller: £29.80
// Postage £5.00
// Micro Servo: £1.00
// GPS £14.90
// Wiring and other consumables
// £121.63 1.72+6.99+8.49+12.99+14.50+2.35+13.99+2.80+6.10+29.80+6.00+1.0+14.90


display = 5;
display_page = 1;
expand=false;
accessories = true;
vtx=true;
fc=true;
elrs=true;
elrs_ff=true;
gps=true;
foam=true;
printed=true;
display_part = "side_panel"; //"cockpit" "cockpit_front"  "leading_edge_half" "leading_edge_half_mirror" "side_panel" "side_panel_mirror" "fc_lid")


module display(display=display)
{
    if(display==1)
    {
        display_model(foam=foam, printed_part=printed);
        if(accessories==true)
        {
            motor_and_prop();
            servo();
            mirror([1,0,0]) servo();
            servo_horn();
            mirror([1,0,0]) servo_horn();
            vtx_case(case=false, vtx_unit=true);
            just_fc();
        }
    }
    if(display==2)
    {
        print_all_new();
    }
    if(display==3)
    {
        print_foam_all(outline=true);
    }
    if(display==4)
    {
        projection() print_foam_all(outline=false);
    }
    if(display==5)
    {
        projection() print_foam(page=display_page, outline=false);
    }
    if (display==6)
    {
        echo(display_part);
        if(display_part=="cockpit_front")
        {
            print_part_cut(cut=1);
        }
        if(display_part=="side_panel")
        {
            print_part_cut(cut=2);
        }
        if(display_part=="side_panel_mirror")
        {
            print_part_cut(cut=5);
        }
        if(display_part=="leading_edge_half")
        {
            print_part_cut(cut=3);
        }
        if(display_part=="leading_edge_half_mirror")
        {
            print_part_cut(cut=6);
        }
        if(display_part=="cockpit")
        {
            print_part_cut(cut=4);
        }
        if(display_part=="fc_lid")
        {
            print_part_cut(cut=7);
        }
    }
    if(display==7)
    {
        expand_prints();
    }
}

display();



// The OpenSCAD Variables

$fn=120;


a4_h = 297;
a4_w = 210;
foam_height = 3;

wing_span = a4_h*2;
root_cord = 150;
tip_cord = 50;

aileron_offset = 50;
aileron_offset_w = 37.5;

// Make the top of bottom of cockpit eqaul 1/2 width of a4 - easier to square-up
cockpit_x = a4_w/2+foam_height*2;
cockpit_y = root_cord;
cockpit_z = 40;
cockpit_thickness = foam_height;
camera = 19.5;
cockpit_window_diameter = camera+cockpit_thickness;
cw_b=cockpit_window_diameter*3;

cockpit_motor_spacing = 11.5;
cockpit_motor_spacing_hole = 3;
cockpit_motor_spacing_hole_wire_x = 3;
cockpit_motor_spacing_hole_wire_y = 10;
cockpit_motor_spacing_hole_wire_offset = 30;
cockpit_motor_stuct_y = 22;
cockpit_motor_stuct_y_gap=17+7/2;

sweep_d = atan((a4_w-tip_cord)/(a4_h));
sweep_d_l1 = atan((a4_w-tip_cord+tip_cord*0.25-root_cord*0.25)/(a4_h));
sweep_d_l2 = atan((a4_w-tip_cord+tip_cord*0.5-root_cord*0.5)/(a4_h));
sweep_d_l3 = atan((a4_w-tip_cord+tip_cord-root_cord)/(a4_h));

size_of_printer=200; // Diagonal 
height_hypo_size_of_printer = size_of_printer * cos(sweep_d);
height_adj_size_of_printer = size_of_printer * sin(90-sweep_d);
height_of_leading_edge_first_section=wing_span/2-height_adj_size_of_printer  ;
// height_of_leading_edge_first_section=(root_cord*0.25)/tan(sweep_d) ;


aileron_d = atan ( (a4_w - root_cord) /  a4_h); 

hinge = 2.5;
aileron_y = tan(aileron_d) * aileron_offset + hinge; 

servo_y = 10;
servo_z = 4;
servo_body_x = 23;
servo_body_y = 34 - 2.5;
servo_body_z = 12.; // actuall 12.4 but we want two foam protected

servo_horn_x =  2.5;
servo_horn_y =  10;
servo_horn_z =  20;
servo_horn_hole_x = 1;
servo_horn_hole_y = servo_horn_y;

servo_hole_x = servo_body_x + 1;
servo_hole_y = servo_body_y + servo_horn_x + 1;
servo_hole_x_offset = foam_height;
servo_hole_y_offset = foam_height;


servo_position_x= (size_of_printer-servo_body_y/2-(foam_height*9)) * cos(sweep_d)+cockpit_x/2; // Not calculated - too hard
servo_position_y= -(size_of_printer+servo_body_x/2-(foam_height*9)) * sin(sweep_d); // Not calculated - too hard
servo_position_rotate =  sweep_d+90;

fc_y_offset=-30;

elrs_x=10;
elrs_x_offset = 4;
elrs_y_offset = 5;

gps_x=18;
gps_x_offset = 3;
gps_y_offset = 29;

elrs_ff_x=elrs_x;
elrs_ff_x_offset = elrs_x_offset;
elrs_ff_y_offset = 45;

// Spin prop during animation
prop_a = 30;


echo("wing_span: ", wing_span);
echo("wing_span inc body: ", wing_span+cockpit_x);
echo("Sweep degrees: ", sweep_d);
echo(height_hypo_size_of_printer, $vpr, $vpd  );

// The OpenSCAD modules 

module A4()
{
    square(size = [a4_w, a4_h], center = false);
}

module profile_leading_edge()
{
    difference()
    {
        rotate([0,90,0]) cylinder(h=0.1, r = foam_height*2.5, center = true);
       translate([0,-foam_height*5/2,0]) cube(foam_height*5, center=true);
    }
}

module leading_edge_chamfer()
{
        difference()
    {
        hull()
        {
            translate([-foam_height/2,0,foam_height*6/2]) side_slot(0.5, start_angle=sweep_d, end_angle=sweep_d);    
        profile_leading_edge();
        }
        translate([-foam_height/2,0,foam_height*6/2])  difference()
        {
            translate([foam_height,0,0]) cube([foam_height,10,foam_height], center=true);
            side_slot(10+foam_height, start_angle=sweep_d, end_angle=sweep_d);
        }
    }
}

module leading_edge()
{
    color("green") hull()
    {
        translate([0.1,0,0])  profile_leading_edge();
        translate([wing_span/2-0.1,-(a4_w-tip_cord),0]) profile_leading_edge();
    }
    scale([1,1,1.002])   translate([0,foam_height,0])
    translate([0,-tan(sweep_d)*height_of_leading_edge_first_section,0])
*    translate([height_of_leading_edge_first_section/2,0,0]) cube([height_of_leading_edge_first_section, foam_height*2, foam_height*3+0.01], center=true);

//    translate([0,foam_height,0])
//    translate([0,-tan(sweep_d)*height_of_leading_edge_first_section,0])
//    translate([height_of_leading_edge_first_section/2,0,0]) 
    scale([1,1,1.002])  intersection()
    {
        translate([0,0,-foam_height*2.5]) linear_extrude(height=foam_height*5) polygon(points=[[0,0],[0,-(a4_w-tip_cord)],[wing_span/2,-(a4_w-tip_cord)]]);
        translate([0,-root_cord*0.25,-foam_height*2.5]) rotate([0,0,sweep_d]) cube([height_of_leading_edge_first_section, wing_span, foam_height*5+0.01], center=false);
    }

    scale([1,1,1.002])  intersection()
    {
        translate([0,0,-foam_height*2.5]) linear_extrude(height=foam_height*5) polygon(points=[[0,0],[0,-(a4_w-tip_cord)],[wing_span/2,-(a4_w-tip_cord)]]);
        translate([0,-root_cord*0.25,-foam_height*0.5]) rotate([0,0,0]) cube([root_cord*0.25/tan(sweep_d), wing_span, foam_height*1+0.01], center=false);
    }

    
*    leading_edge_chamfer();
*    mirror([0,0,1]) leading_edge_chamfer();

}


module wing_part_not_cut(cord_percentage = 1)
{
    point_1_y = tan(sweep_d) * wing_span/2;
    linear_extrude(foam_height, center = true) polygon(points=[[0,0],[wing_span/2,-point_1_y], [wing_span/2,-point_1_y], [wing_span/2,-point_1_y-tip_cord*cord_percentage], [0,-root_cord*cord_percentage]]);
}


module wing_part_cut_by_support(cord_percentage = 1)
{
    if(cord_percentage == 1)
    {
        scale([1,1,2]) translate([-foam_height,-root_cord/2,0])  rotate([0,90,0]) print_part_cut(cut=2);
    }
    if(cord_percentage != 1)
    {
        translate([0,0,foam_height*2]) scale([1,1,2]) translate([-foam_height,-root_cord/2,0])  rotate([0,90,0]) print_part_cut(cut=2);
    }
}

module wing_part(cord_percentage = 1, servo_hole=true)
{
    if(servo_hole==false)
    {
        difference()
        {
        wing_part_not_cut(cord_percentage = cord_percentage);
        wing_part_cut_by_support(cord_percentage = cord_percentage);
        }
    }
    if(servo_hole==true)
    {
        difference()
        {
            wing_part_not_cut(cord_percentage = cord_percentage);
            translate([foam_height-cockpit_x/2,0,0]) servo_hole();
            wing_part_cut_by_support(cord_percentage = cord_percentage);
        }
    }
}

module aileron_part()
{
    difference()
    {
        translate([0,0,0 ]) linear_extrude(foam_height, center = true) polygon(points=[
            [aileron_offset,0],
            [a4_h, -tan(aileron_d) * (a4_h-aileron_offset)],
            [a4_h, -tan(aileron_d) * (a4_h-aileron_offset) -aileron_offset_w],
            [aileron_offset, -aileron_offset_w],
    ]);
    
        translate_servo_x() translate_servo_horn_y() cube([servo_horn_hole_x,servo_horn_hole_y,foam_height*3], center=true);
    }
}

module wing_tip()
{
    // https://www.rcgroups.com/forums/showpost.php?p=17964790&postcount=8
    tip_length = tip_cord *.5;
    tip_height = tip_cord *.5;
    translate([0,0,0 ]) linear_extrude(foam_height, center = true) polygon(points=[
            [0,0],
            [tip_height,-tip_height],
            [tip_height,-tip_height-tip_cord-aileron_offset-hinge],
            // center
            [0,-0-tip_cord-aileron_offset-hinge],
            // Mirror
            [-tip_height,-tip_height-tip_cord-aileron_offset-hinge],
            [-tip_height,-tip_height],
    ]);
}

module half_KMF6_foam()
{
    {
        translate([0,0,foam_height* 0])   wing_part(cord_percentage = 1);
        translate([0,0,foam_height* 1])   wing_part(cord_percentage = 0.5);
        translate([0,0,foam_height* 2])   wing_part(cord_percentage = 0.25);
        translate([0,0,foam_height*-1])   wing_part(cord_percentage = 0.5);
        translate([0,0,foam_height*-2])   wing_part(cord_percentage = 0.25,servo_hole=false);
    }
}

module cockpit_front(offset_t=0)
{
    front_r = foam_height*2.5;
    extent_y = (sin(sweep_d) * cockpit_x/2) + foam_height*5 - front_r;
    hull()
    {
        translate([cockpit_x/2-offset_t,0,0]) profile_leading_edge();
        translate([-cockpit_x/2+offset_t,0,0]) profile_leading_edge();
        translate([0,extent_y-offset_t,0]) rotate([0,0,0]) rotate([90,0,0]) cylinder(h=0.1,r=front_r, center=true);
        translate([0,-offset_t,0]) cube([cockpit_x-offset_t, 0.1, cockpit_z-offset_t], center = true);
    }
}

module cockpit_front_shell()
{
    difference()
    {
        cockpit_front();
        cockpit_front(offset_t=cockpit_thickness*2);
        rotate([90,0,0]) cylinder(h=cockpit_y*2, r=cockpit_window_diameter/2, center=true);
        cockpit_front_cone();
        cockpit_front_cone(offset_t=cockpit_thickness*2);
    } 
     intersection()
    {
        cockpit_front_cone(offset_t=cockpit_thickness*2);
        cockpit_front();
    }
}

module cockpit_front_cone_plain(offset_t=0)
{

    front_r = foam_height*2.5;
    extent_y = (sin(sweep_d) * cockpit_x/2) + foam_height*5 - front_r;
    translate([0,extent_y-cw_b/8+0.1,0]) rotate([90,0,0]) 
    {
        if(offset_t==0)
        {
            scale([1,1,0.5]) cylinder(h=cw_b/2,r1=cw_b/2, r2=cockpit_window_diameter/2, center=true);
            translate([0,0,cockpit_window_diameter/2]) cube([cockpit_window_diameter,cockpit_window_diameter,cockpit_z*2],center=true);
        }
        if(offset_t>0)
        {
            scale([1,1,0.5]) cylinder(h=cw_b/2+0.2,r1=cw_b/2-offset_t/2, r2=cockpit_window_diameter/2-offset_t/2, center=true);
            translate([0,0,cockpit_window_diameter/2+offset_t/4]) cube([cockpit_window_diameter-offset_t/2,cockpit_window_diameter-offset_t/2,cockpit_z*2],center=true);
        }
    }
}

module cockpit_front_cone(offset_t=0)
{

    if(offset_t==0)
    {
        cockpit_front_cone_plain();
    }
    if(offset_t>0)
    {
        difference()
        {
                    cockpit_front_cone_plain();
                    cockpit_front_cone_plain(offset_t=offset_t);
        }
    }
    
}


module cockpit_foam_top()
{
    translate([0,0,0 ]) 
        linear_extrude(foam_height, center = true) polygon(points=[
            [-cockpit_x/2+foam_height,0],
            [cockpit_x/2-foam_height,0],
            [cockpit_x/2-foam_height,-cockpit_y],
            [-cockpit_x/2+foam_height,-cockpit_y],
    ]);
    
}

module cockpit_foam_top_full()
{
    cockpit_foam_top();
    translate([0,0,0 ]) cockpit_foam_top();
}



module cockpit_foam_side()
{
    translate([0,0,0 ]) 
        linear_extrude(foam_height, center = true) polygon(points=[
            [-cockpit_z/2,0],
            [cockpit_z/2,0],
            [cockpit_z/2,-cockpit_y],
            [-cockpit_z/2,-cockpit_y],
    ]);
    
}

module cockpit_foam()
{
!    translate([0,0,cockpit_z/2-foam_height/2]) cockpit_foam_top();
    translate([0,0,-cockpit_z/2+foam_height/2]) cockpit_foam_top();
    /// No longer needed with printed side panels
    /// ** stared out  ***
    * translate([-cockpit_x/2+foam_height/2,0,0]) rotate([ 0,90, 0]) cockpit_foam_side();
    * translate([cockpit_x/2-foam_height/2,0,0]) rotate([ 0,90, 0]) cockpit_foam_side();    
}

module motor_and_prop()
{
    translate([0,-cockpit_y,0]) 
    {
        color("silver") 
        {
            cube([cockpit_motor_spacing+foam_height, foam_height, cockpit_motor_spacing+foam_height], center = true);
            translate([0,-33.2/2,0]) rotate([90,0,0]) cylinder(h=33.2,r=5/2, center=true);
            translate([0,-8/2,0]) rotate([90,0,0]) cylinder(h=13,r=27.5/2, center=false);
        }
        color("red") translate([0,-33.2+6,0]) rotate([0,prop_a,0]) cube([129.5,10,15], center=true);
        echo(prop_a);
    }
}


/*
    translate([0,0,0 ]) linear_extrude(foam_height, center = true) polygon(points=[
            [aileron_offset,0],
            [a4_h, -tan(aileron_d) * (a4_h-aileron_offset)],
            [a4_h, -tan(aileron_d) * (a4_h-aileron_offset) -aileron_offset_w],
            [aileron_offset, -aileron_offset_w],
    ]);
*/


module translate_servo_x()
{
    // Average of aileron
    a_x1=aileron_offset;
    a_x2=a4_h;
    translate([a_x1+(a_x2-a_x1)/2,0,0]) children();
    
}

module translate_servo_horn_y()
{
    // Average of aileron
    a_y1=0;
    a_y2=-tan(aileron_d) * (a4_h-aileron_offset) -aileron_offset_w;
            translate([0,a_y1+(a_y2-a_y1)/2,0]) 
                    children();
    
}

module translate_servo_y()
{
    // Average of aileron
    a_x1=aileron_offset;
    a_x2=a4_h;
    s_t_x=a_x1+(a_x2-a_x1)/2;
    s_t_y=-tan(sweep_d) * s_t_x;
    translate([0,s_t_y,0]) children();
    
}


module translate_servo_horn()
{
    translate([0,0,servo_horn_z/2])
        translate_servo_x()
            translate_servo_horn_y()
                translate_away_from_cockpit(mirror=false)
                    translate_aileron_away()
                        children();

}

module servo_horn()
{
    translate_servo_horn()   
        color("white") cube([servo_horn_x,servo_horn_y,servo_horn_z],center=true);
}


module translate_all_servo()
{
    translate([servo_hole_x_offset,servo_hole_y_offset,0])
    translate_servo_x() translate_servo_y() translate_away_from_cockpit(mirror=false)
    rotate([0,0,-sweep_d]) translate([-servo_body_y/2,-servo_body_x/2,foam_height/2+0.1]) rotate([0,0,-90]) children();

}


module servo()
{
    translate_all_servo()    {
        translate([0,-servo_horn_x/2,0]) color("blue") 
        {
            cube([servo_body_x,servo_body_y,servo_body_z],center=true);
        }
        translate([0,-servo_horn_x/2,0]) color("white") 
        {
            translate([0,+servo_body_y/2+servo_horn_x/2,15/2-0.2]) cube([servo_horn_x,servo_horn_x,15], center=true);
        }
        
    }
}


module servo_hole()
{
    translate_all_servo()
    translate([0,0,0]) 
    {
        cube([servo_hole_x,servo_hole_y,servo_body_z],center=true);

    }
}



module chamfer()
{
    difference()
    {
        cube(foam_height, center=true);
        translate([0,foam_height/2,foam_height/2]) rotate([0,90,0]) cylinder(h=foam_height*4,r=foam_height, center=true);
    }
}


module print_foam_all(pages=8, outline=true)
{
    for (i = [1 : pages])
    {
        translate([ 0, (a4_w+10)*i, 0 ]) print_foam(page=i, outline=outline);
    }
}

module a4_mirror_and_reposition()
{
    translate([a4_h,0,0]) mirror([1,0,0])  children();
}

module print_foam(page=2, outline=true)
{
    if(outline)
    {
        color("black") rotate([0,0,-90]) linear_extrude(1, center = true) A4();
    }
    if(page==1)
    {
        wing_part(cord_percentage = 1);
        translate([a4_h-cockpit_y,(-cockpit_x/2+foam_height)/2,0]) rotate([0,0,90]) scale([0.5,1,1])  cockpit_foam_top();
    }
    if(page==2)
    {
        translate([0,0,0])    wing_part(cord_percentage = 0.5);
        translate([a4_h-tip_cord*.5,0,0]) wing_tip();
       translate([0,-a4_w,0]) mirror([0,1,0]) rotate([0,0,aileron_d]) translate([-aileron_offset,0,0]) aileron_part();
    }
    if(page==3)
    {
        translate([0,0,0])    wing_part(cord_percentage = 0.25);
        translate([0,-root_cord*0.25,0])    wing_part(cord_percentage = 0.25, servo_hole=false);
        /// No longer needed with side panel
        /// *** stared out ***
*        translate([a4_w-cockpit_y/2+foam_height*4,-cockpit_z/2,0]) rotate([0,0,90]) cockpit_foam_side();
        translate([0,-a4_w-(-cockpit_x/2+foam_height)/2,0]) rotate([0,0,90]) scale([0.5,1,1])  cockpit_foam_top();

    }
    if(page==4)
    {
        wing_part(cord_percentage = 0.5);
    }
    
    if(page==5)
    {
        a4_mirror_and_reposition() print_foam(page=1, outline=outline);
    }
    if(page==6)
    {
        a4_mirror_and_reposition() print_foam(page=2, outline=outline);
    }
    if(page==7)
    {
        a4_mirror_and_reposition() print_foam(page=3, outline=outline);
    }
    if(page==8)
    {
        a4_mirror_and_reposition()  print_foam(page=4, outline=outline);
    }
       
}


module translate_away_from_cockpit(mirror=false)
{
    if(mirror)
    {
        mirror([1,0,0]) translate([cockpit_x/2,0,0]) children();
    }
    else
    {
        translate([cockpit_x/2,0,0])  children();
    }
    
}


module translate_aileron_away()
{
    translate([-foam_height,-root_cord-aileron_y,0]) children();
}

module side_slot(ss_len=cockpit_y/2, start_angle=20, end_angle=0)
{
    difference()
    {
        translate([0,-foam_height/2,0]) resize([0,ss_len+foam_height,0]) translate([foam_height,0,0])  rotate([0,90,0]) rotate([0,0,90]) chamfer();
        mirror([0,1,0]) translate([foam_height/2,ss_len/2,-foam_height]) rotate([0,0,end_angle]) cube([foam_height*4, foam_height, foam_height*2]);
        mirror([0,0,0]) translate([foam_height/2,ss_len/2,-foam_height]) rotate([0,0,-start_angle]) cube([foam_height*4, foam_height, foam_height*2]);

    }
}

module cockpit_side_panel()
{
    translate([(cockpit_x-foam_height*1)/2,0,0])  
    {   
        difference()
        {
            union()
            {
                cube([foam_height,cockpit_y, cockpit_z], center=true);    
*                translate([0,cockpit_y/2-cockpit_y/8,foam_height*6/2]) side_slot(cockpit_y/4, start_angle=sweep_d, end_angle=sweep_d_l1);
            // mirror above
*                mirror([0,0,1]) translate([0,cockpit_y/2-cockpit_y/8,foam_height*6/2]) side_slot(cockpit_y/4, start_angle=sweep_d, end_angle=sweep_d_l1);
                translate([0,cockpit_y/8,foam_height*4/2]) side_slot(cockpit_y/4, start_angle=sweep_d_l1, end_angle=sweep_d_l2);
            // mirror above
                mirror([0,0,1]) translate([0,cockpit_y/8,foam_height*4/2]) side_slot(cockpit_y/4, start_angle=sweep_d_l1, end_angle=sweep_d_l2);
                translate([0,-cockpit_y/4,foam_height*2/2]) side_slot(cockpit_y/2, start_angle=sweep_d_l2, end_angle=sweep_d_l3);
                // mirror above
                mirror([0,0,1]) translate([0,-cockpit_y/4,foam_height*2/2]) side_slot(cockpit_y/2, start_angle=sweep_d_l2, end_angle=sweep_d_l3);
    
            }
            translate([0,cockpit_y/4-servo_y/2,foam_height*2.5+servo_z/2]) cube([foam_height+0.2,servo_y,servo_z], center=true);
            
        }
    }
}


module cockpit_motor_hole()
{
    translate([cockpit_motor_spacing/2, 0, cockpit_motor_spacing/2] )
                rotate([90,0,0])
                    cylinder(h=cockpit_y*4,r=cockpit_motor_spacing_hole/2, center=true);
}


module cockpit_motor_supports_template()
{
    h = cockpit_motor_spacing/2 + (cockpit_z-foam_height*2)/2 + cockpit_motor_spacing_hole;
    translate([foam_height/2,0,0]) rotate([0,-90,0])  linear_extrude(foam_height) polygon([[0,0],[h,0],[0,cockpit_motor_stuct_y]]);
}

module cockpit_motor_supports_chamfer()
{
    intersection()
    {
        resize([0,0,cockpit_z-foam_height*2], auto=[false,false,true]) translate([0,foam_height/2,foam_height/2]) rotate([0,90,0]) chamfer();
        cockpit_motor_supports_template();
    }
}

module cockpit_motor_supports_chamfer_end()
{
    intersection()
    {
        translate([0,cockpit_motor_stuct_y-foam_height*1.5,foam_height*2]) difference() 
        {
            translate([0,foam_height/2,-foam_height/2]) cube([foam_height,foam_height,foam_height],center=true);
            rotate([0,90,0]) cylinder(h=foam_height*2,d=foam_height, center=true);
        }
    }
}

module cockpit_motor_supports()
{
    translate([foam_height/2,-cockpit_y/2+foam_height,-(cockpit_z-foam_height*2)/2]) {
        translate([cockpit_motor_stuct_y_gap/2,0,0])
       {
           cockpit_motor_supports_template();
           translate([foam_height,0,0]) cockpit_motor_supports_chamfer();
           translate([0,cockpit_motor_stuct_y,0]) scale([1,0.5,1/2]) mirror([0,1,0]) cockpit_motor_supports_template();

 //          cockpit_motor_supports_chamfer_end();
       }
    }
}

module corner_cockpit()
{
    translate([cockpit_x/2-foam_height*1.5,cockpit_y/2-foam_height*0.5,0])
    {
        translate([-foam_height*1.5,0,0]) cube([foam_height*4, foam_height, cockpit_z-foam_height*2], center=true);
        translate([0,-foam_height*1.5,0]) cube([foam_height, foam_height*4, cockpit_z-foam_height*2], center=true);
        translate([-foam_height*4.,0,-(cockpit_z-foam_height*5)/2]) rotate([0,0,90]) chamfer();
        rotate([0,0,90]) translate([-foam_height*4.,0,-(cockpit_z-foam_height*5)/2]) rotate([0,0,90]) chamfer();
    }
}

module strut(sx1,sy1,sx2,sy2,sz, unit)
{
    hull()
    {
        translate([sx1,sy1,unit/2]) cube(unit,center=true);
        translate([sx2,sy2,sz]) cube(unit,center=true);
    }
    
}

module struts(sx1,sy1,sx2,sy2,sz, unit)
{
    strut(sx1,sy1,sx2,sy2,sz, unit);
    mirror([1,0,0]) strut(sx1,sy1,sx2,sy2,sz, unit);
    mirror([0,1,0]) strut(sx1,sy1,sx2,sy2,sz, unit);
    mirror([1,0,0]) mirror([0,1,0]) strut(sx1,sy1,sx2,sy2,sz, unit);
*    strut(sx1,sy1,-sx1,sy1,unit/2, unit);
*    mirror([0,1,0])  strut(sx1,sy1,-sx1,sy1,unit/2, unit);
}

module vtx_case(case=true, vtx_unit=false)
{
    inside=34;
    t=1.25;
    z_i=t*2;

    cx=inside+t*2;
    cy=inside+t*2;
    cz=z_i;
    vtx_z_offset = 8.5-t/2;
    vtx_z = 10.5;
    
    vtx_height = cockpit_z-foam_height-vtx_z_offset+t;
//    translate([0,cockpit_y/2-(cy/2/sin(45)),0]) rotate([0,0,45])
    
    if(case==true)
    {
        translate([0,cockpit_y/2-(cy/2)-foam_height,0]) rotate([0,0,0])
        { 
            translate([0,0,vtx_height-cz/2]) difference()
            {
                cube([cx,cy,cz],center=true);   
                translate([0,0,t]) rotate([0,0,0]) union()
                {
                    cube([inside,inside,z_i],center=true);
                    // usb 
                    translate([0,inside/2,0]) cube([10,inside,z_i], center=true);
                    // cam
                    translate([inside/2,inside/2-10/2-8,0]) cube([inside,10,z_i], center=true);
                    // cables FC 
                    translate([0,-inside/2,0]) cube([10,inside,z_i], center=true);
                    // Antenna
                    translate([-inside/2,inside/2-10/2,0]) cube([inside,10,z_i], center=true);
                }
            }
            struts(-cx/2+foam_height/2,-cy/2+foam_height/2,-cx/2+foam_height/2,-(-cy/2+foam_height/2),vtx_height-cz-foam_height/2+t/2, foam_height);
        }
    }
    if(vtx_unit==true)
    {
        translate([0,cockpit_y/2-(cy/2)-foam_height,0]) rotate([0,0,0])
        { 
            translate([0,0,vtx_height+t+vtx_z/2])
            {
                translate([0,-cockpit_y/2,-cockpit_z/2]) color("black")cube([cx-1,cy-1,vtx_z],center=true);
            }      
        }
    }
}


module pillar(od=7,id=3,ox, oy, oz)
{
    translate([ox/2,oy+od/2,0]) difference()
    {
        cylinder(h=oz,d=od,center=true);
        translate([0,0,oz]) cylinder(h=oz*2,d=id,center=true);
    }
}

module pillars(od=7, id=3, ox, oy, oz)
{
    pillar(od=od,id=id,ox=ox+od, oy=oy, oz=oz);
    mirror([0,1,0]) pillar(od=od,id=id,ox=ox+od, oy=oy, oz=oz);
    mirror([1,0,0]) pillar(od=od,id=id,ox=ox+od, oy=oy, oz=oz);
    mirror([1,0,0]) mirror([0,1,0])  pillar(od=od,id=id,ox=ox+od, oy=oy, oz=oz);
}

module fc_case_top(od, id,t,ox,oy,oz)
{
    difference()
    {
        union()
        {
            hull()
            {
                translate([ox/2+od/2,oy+od/2,0]) cylinder(h=t,d=od,center=true);
                translate([-(ox/2+od/2),oy+od/2,0]) cylinder(h=t,d=od,center=true);
            }
            hull()
            {
                translate([ox/2+od/2,-(oy+od/2),0]) cylinder(h=t,d=od,center=true);
                translate([-(ox/2+od/2),-(oy+od/2),0]) cylinder(h=t,d=od,center=true);
            }
            hull()
            {
                translate([0,(oy+od/2),0]) cylinder(h=t,d=od,center=true);
                translate([0,-(oy+od/2),0]) cylinder(h=t,d=od,center=true);
            }
        }
        translate([ox/2+od/2,oy+od/2,0])  cylinder(h=oz*2,d=id,center=true);
        mirror([0,1,0]) translate([ox/2+od/2,oy+od/2,0])  cylinder(h=oz*2,d=id,center=true);
        mirror([1,0,0]) translate([ox/2+od/2,oy+od/2,0])  cylinder(h=oz*2,d=id,center=true);
        mirror([1,0,0]) mirror([0,1,0]) translate([ox/2+od/2,oy+od/2,0])  cylinder(h=oz*2,d=id,center=true);

    }
}


module fc_case(case=true, fc=true, lid=true)
{
    t=1.25;
    tolerance=0.5;
    fc_x = 37+tolerance;
    fc_y = 26+tolerance;
    fc_z = 14+tolerance;
    gap=17;
    od=7;
    id=3;
    if(case==true)
    {
        translate([0,0,0])
        {
            translate([0,0,0]) difference()
            {
                union()
                {
                    cube([fc_x+foam_height,fc_y+foam_height,t*2], center=true);
                    translate([0,0,-foam_height/2]) cube([fc_x+foam_height*2,fc_y+foam_height*2,foam_height], center=true);
                }
                cube([fc_x-foam_height,fc_y-foam_height,foam_height*4], center=true);        
                translate([0,0,t]) cube([fc_x,fc_y,t*2], center=true);
            }
            translate([0,0,(fc_z+foam_height)/2-foam_height]) pillars(od=od,id=id,ox=gap,oy=fc_y/2, oz=fc_z+foam_height);
            if(lid==true && case==true)
            {
                translate([0,0,(fc_z+t/2)]) fc_case_top(od=od, id=id, t=t, ox=gap,oy=fc_y/2, oz=fc_z+t);
            }    
        }
    }
    
    if(fc==true)
    {
        translate([0,0,(fc_z)/2]) color("Red") cube([fc_x,fc_y,fc_z], center=true);
    }

    if(lid==true && case==false)
    {
        fc_case_top(od=od, id=id, t=t, ox=gap,oy=fc_y/2, oz=fc_z+t);
     }
}

module just_fc()
{
    if(fc==true)
    {
        translate([0,fc_y_offset-cockpit_y/2,-cockpit_z/2+foam_height*2]) fc_case(case=false, fc=true);
    }
}

module diagonals()
{
    // Diagonals. 
    translate([0,0,-cockpit_z/2+foam_height*3/2]) intersection()
    {
        cube([cockpit_x-foam_height*2,cockpit_y, foam_height], center=true);
        union()
        {
            number_extra = 3;
            space = cockpit_x/number_extra;
            for(i = [0:5])
            {
                rotate([0,0,45]) translate([-cockpit_x/2+space*i,0]) cube([foam_height,cockpit_y*2,foam_height], center=true);
                rotate([0,0,-45]) translate([-cockpit_x/2+space*i,0]) cube([foam_height,cockpit_y*2,foam_height], center=true);
            }
        }
    }
}

module mount(mx=18,my=18,t=1.5, gap=0.25)
{
    difference()
    {
        union()
        {
            translate([0,0,foam_height/2]) cube([mx+t*4,my+t*4,foam_height], center=true);
            translate([0,0,(foam_height+t)/2]) cube([mx+t*2,my+t*2,foam_height+t], center=true);
        }
        translate([0,(my+t)/2++gap*2,foam_height*3/2]) cube([mx+gap*2,(my+t)*2+gap*2,foam_height], center=true);
    }
}



module cockpit_shell(vtx=vtx, lid=true)
{
    translate([0,-cockpit_y/2,0]) 
    { 
        translate([0,0,-(cockpit_z-foam_height)/2--foam_height])  
        difference()
        {
            cube([cockpit_x-foam_height*2,cockpit_y, foam_height], center=true);    
            cube([cockpit_x-foam_height*4,cockpit_y-foam_height*2, foam_height*4], center=true);    
        }

        cockpit_side_panel();
        mirror([1,0,0]) cockpit_side_panel();

    // Diagonals
        diagonals();
     

        // Back motor
        translate([0,-(cockpit_y-foam_height)/2,0]) difference()
        {
            cube([cockpit_x, foam_height, cockpit_z-foam_height*2], center=true);
            mirror([0,0,0]) cockpit_motor_hole();
            mirror([1,0,0]) cockpit_motor_hole();
            mirror([1,0,1]) cockpit_motor_hole();
            mirror([0,0,1]) cockpit_motor_hole();
            translate([cockpit_motor_spacing_hole_wire_offset,0,(cockpit_z-foam_height*2)/2]) cube([cockpit_motor_spacing_hole_wire_x, foam_height*4, cockpit_motor_spacing_hole_wire_y], center=true);
        }
        
        // Daniel's supporting
        cockpit_motor_supports();
        mirror([1,0,0]) cockpit_motor_supports();
        
        // corner
        translate([0,0,0])
        {
            mirror([0,0,0]) corner_cockpit();
            mirror([1,0,0]) corner_cockpit();
            mirror([0,1,0]) corner_cockpit();
            mirror([0,1,0]) mirror([1,0,0]) corner_cockpit();
        }
        if(vtx==true)
        {
            translate([0,0,-cockpit_z/2+foam_height]) vtx_case();
        }
        if(fc==true)
        {
            translate([0,fc_y_offset,-cockpit_z/2+foam_height*2]) fc_case(case=true, fc=false, lid=lid);
        }
        if(elrs==true)
        {
            translate([-cockpit_x/2+elrs_x_offset+(elrs_x+1.5*4)/2,-cockpit_x/2+elrs_y_offset-(elrs_x+1.5*4)/2,-cockpit_z/2+foam_height]) rotate([0,0,270]) mount(elrs_x,elrs_x);
        }
        if(gps==true)
        {
            translate([-cockpit_x/2+gps_x_offset+(gps_x+1.5*4)/2,-cockpit_x/2+gps_y_offset-(gps_x+1.5*4)/2,-cockpit_z/2+foam_height]) rotate([0,0,270]) mount(gps_x,gps_x);
        }
        if(elrs_ff==true)
        {
            translate([-cockpit_x/2+elrs_ff_x_offset+(elrs_ff_x+1.5*4)/2,-cockpit_x/2+elrs_ff_y_offset-(elrs_ff_x+1.5*4)/2,-cockpit_z/2+foam_height]) rotate([0,0,270]) mount(elrs_ff_x,elrs_ff_x);
        }
    }
    
}


module print_all_new()  
{
    translate([0,cockpit_y/2+cockpit_z/2+foam_height/2,0]) print_part_cut(cut=1);
    translate([cockpit_x/2+cockpit_z/2+foam_height,0,0]) print_part_cut(cut=2);
    translate([-(cockpit_x/2+cockpit_z/2+foam_height),0,0]) print_part_cut(cut=5);
    translate([0,-cockpit_y/2-foam_height*3,0]) print_part_cut(cut=3);
    translate([0,-cockpit_y/2-foam_height*8.5,0]) print_part_cut(cut=6);
    print_part_cut(cut=4);
}



module print_part_cut_position(cut=4, expand=false)
{
    if(expand==false)
    {
    if(cut==1)
        {
            rotate([90,0,0]) children();
        }
    if(cut==2)
        {
            translate([0,cockpit_y/2,-cockpit_x/2+foam_height]) rotate([0,-90,0]) children();
        }
    if(cut==3)
        {
            rotate([90,0,0]) rotate([0,0,sweep_d]) translate([height_hypo_size_of_printer/2,-height_adj_size_of_printer/2,0]) translate([-wing_span/2-cockpit_x/2,(a4_w-tip_cord),0])  children();
        }
    if(cut==4)
        {
            translate([0,cockpit_y/2,cockpit_z/2-foam_height]) rotate([0,0,0]) children();
        }
    if(cut==5)
        {
             mirror([1,0,0]) print_part_cut_position(cut=2, expand=expand) children();
        }
    if(cut==6)
        {
             mirror([1,0,0]) print_part_cut_position(cut=3, expand=expand) children();
        }
    if(cut==7)
        {
             children();
        }
    }
    if(expand==true)
    {
    space=25;
    if(cut==1)
        {
            translate([0,space,0]) children();
        }
    if(cut==2)
        {
            translate([space,0,0]) children();
        }
    if(cut==3)
        {
            translate([space*2,0,0]) children();
        }
    if(cut==4)
        {
            children();
        }
    if(cut==5)
        {
            translate([space,0,0]) children();
        }
    if(cut==6)
        {
            translate([space,0,0]) children();
        }
    if(cut==7)
        {
            translate([0,-cockpit_y/2+fc_y_offset-foam_height,space*1]) children();
        }
    }
}


module expand_prints()
{
    print_part_cut(cut=1, expand=true);
    print_part_cut(cut=2, expand=true);
    print_part_cut(cut=3, expand=true);
    print_part_cut(cut=4, expand=true);
    print_part_cut(cut=5, expand=true);
    print_part_cut(cut=6, expand=true);
    print_part_cut(cut=7, expand=true);    
}    


module print_part_cut(cut=4, expand=false)
{
    color("orange") 
    {
        if(cut==1)
        {
            print_part_cut_position(cut=cut, expand=expand) difference()
            {
                printed_part();
                translate([0,-wing_span,0]) cube([wing_span*2,wing_span*2,wing_span*2], center=true);
                translate([-wing_span-cockpit_x/2+foam_height,0,0]) cube([wing_span*2,wing_span*2,wing_span*2], center=true);
                translate([+wing_span+cockpit_x/2-+foam_height,0,0]) cube([wing_span*2,wing_span*2,wing_span*2], center=true);
            }
        }
        if(cut==2)
        {
            print_part_cut_position(cut=cut, expand=expand)  difference()
            {
                printed_part();
                translate([-wing_span+cockpit_x/2-foam_height,0,0]) cube([wing_span*2,wing_span*2,wing_span*2], center=true);
*                translate([+wing_span+wing_span/2+cockpit_x/2-height_hypo_size_of_printer,0,0]) cube([wing_span*2,wing_span*2,wing_span*2], center=true);
                translate([+wing_span+cockpit_x/2+height_of_leading_edge_first_section,0,0]) cube([wing_span*2,wing_span*2,wing_span*2], center=true);
                
*                translate([+wing_span-cockpit_x/2+wing_span/2-height_hypo_size_of_printer,0,0]) cube([wing_span*2,wing_span*2,wing_span*2], center=true);
            }
        }
        if(cut==3)
        {
        print_part_cut_position(cut=cut, expand=expand) difference()
            {
                printed_part();
                translate([-wing_span/2+cockpit_x/2-(wing_span/2-height_of_leading_edge_first_section)
                ,0,0]) cube([wing_span*2,wing_span*2,wing_span*2], center=true);
*                translate([-wing_span/2+cockpit_x/2-height_hypo_size_of_printer,0,0]) cube([wing_span*2,wing_span*2,wing_span*2], center=true);
            }
        }
        
        if(cut==4)
        {
            print_part_cut_position(cut=cut, expand=expand)  difference()
            {
                printed_part();
                translate([0,wing_span-0.075,0]) cube([wing_span*2,wing_span*2,wing_span*2], center=true);
                translate([-wing_span-cockpit_x/2+foam_height+0.075,0,0]) cube([wing_span*2,wing_span*2,wing_span*2], center=true);
                translate([+wing_span+cockpit_x/2-foam_height-0.075,0,0]) cube([wing_span*2,wing_span*2,wing_span*2], center=true);
            }
        }
        if(cut==5)
        {
            mirror([1,0,0]) print_part_cut(cut=2,expand=expand);
        }
        if(cut==6)
        {
            mirror([1,0,0]) print_part_cut(cut=3,expand=expand);
        }
        if(cut==7)
        {
            print_part_cut_position(cut=cut, expand=expand) fc_case(case=false, fc=false, lid=true);
        }
    }
}



module printed_part(lid=false)
{
    color("Coral")
    {
        translate_away_from_cockpit(mirror=false) 
        {
            difference()
            {
               leading_edge();
                translate([-cockpit_x/2,0,0]) servo_hole();
            }
            
        }
        translate_away_from_cockpit(mirror=true) 
        {
            difference()
            {
               leading_edge();
                translate([-cockpit_x/2,0,0]) servo_hole();
            }
        }   
        cockpit_front_shell();
        cockpit_shell(lid=lid);
    }
}





module display_foam()
{
    translate_away_from_cockpit(mirror=false) 
    {
        half_KMF6_foam();
        translate_aileron_away() aileron_part();
        translate([wing_span/2+foam_height/2,-root_cord,0]) rotate([0,90,0]) wing_tip();
    }
    translate_away_from_cockpit(mirror=true)
    {
        half_KMF6_foam();
        translate_aileron_away() aileron_part();
        translate([wing_span/2+foam_height/2,-root_cord,0]) rotate([0,90,0]) wing_tip();
    }
    cockpit_foam();
        
}

module display_model(printed_part=true, foam=true)
{
    if(printed_part)
    {
        printed_part(lid=true);
    }
    if(foam)
    {
        display_foam();
    }
}



