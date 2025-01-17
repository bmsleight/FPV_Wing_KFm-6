
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


display = 2;
display_page = 7;
expand=false;
display_part = "side_panel"; //"cockpit" "cockpit_front"  "leading_edge_half" "side_panel")

module display(display=display)
{
    if(display==1)
    {
        display_model(foam=true, printed_part=true);
        motor_and_prop();
    }
    if(display==2)
    {
        if(expand==false)
        {
            print_all_new();
        }
        if(expand==true)
        { 
            expand_prints();
        }
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
        if(display_part=="cockpit_front")
        {
            print_part_cut(cut=1);
        }
        if(display_part=="side_panel")
        {
            print_part_cut(cut=2);
        }
        if(display_part=="leading_edge_half")
        {
            print_part_cut(cut=3);
        }
        if(display_part=="cockpit")
        {
            print_part_cut(cut=4);
        }
    }
    if(display==7)
    {
        expand_prints();
    }
}

display();



// The OpenSCAD Variables

$fn=60;


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
cockpit_window_diameter = 15;

cockpit_motor_spacing = 12;
cockpit_motor_spacing_hole = 3;


sweep_d = atan((a4_w-tip_cord)/(a4_h));
sweep_d_l1 = atan((a4_w-tip_cord+tip_cord*0.25-root_cord*0.25)/(a4_h));
sweep_d_l2 = atan((a4_w-tip_cord+tip_cord*0.5-root_cord*0.5)/(a4_h));
sweep_d_l3 = atan((a4_w-tip_cord+tip_cord-root_cord)/(a4_h));

size_of_printer=190;
height_hypo_size_of_printer = size_of_printer * cos(sweep_d);
height_adj_size_of_printer = size_of_printer * sin(sweep_d);

aileron_d = atan ( (a4_w - root_cord) /  a4_h); 

hinge = 2.5;
aileron_y = tan(aileron_d) * aileron_offset + hinge; 


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

module leading_edge()
{
    color("green") hull()
    {
        translate([0.1,0,0])  profile_leading_edge();
        translate([wing_span/2-0.1,-(a4_w-tip_cord),0]) profile_leading_edge();
    }
}



module wing_part(cord_percentage = 1)
{
    point_1_y = tan(sweep_d) * wing_span/2;
    linear_extrude(foam_height, center = true) polygon(points=[[0,0],[wing_span/2,-point_1_y], [wing_span/2,-point_1_y], [wing_span/2,-point_1_y-tip_cord*cord_percentage], [0,-root_cord*cord_percentage]]);
}

module aileron_part()
{
    translate([0,0,0 ]) linear_extrude(foam_height, center = true) polygon(points=[
            [aileron_offset,0],
            [a4_h, -tan(aileron_d) * (a4_h-aileron_offset)],
            [a4_h, -tan(aileron_d) * (a4_h-aileron_offset) -aileron_offset_w],
            [aileron_offset, -aileron_offset_w],
    ]);
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
        translate([0,0,foam_height*-2])   wing_part(cord_percentage = 0.25);
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
*        cube([cockpit_x/2-offset_t, 0.1, cockpit_z-offset_t], center = true);
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
    translate([0,0,cockpit_z/2-foam_height/2]) cockpit_foam_top();
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
        color("red") translate([0,-33.2+6,0]) rotate([0,30,0]) cube([129.5,10,15], center=true);
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
        translate([0,0,0])   wing_part(cord_percentage = 1);
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
        translate([0,-root_cord*0.25-foam_height*2,0])    wing_part(cord_percentage = 0.25);
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
    
    /*
    translate_away_from_cockpit(mirror=true)
    {
        half_KMF6_foam();
        translate([0,-root_cord-aileron_y,0]) aileron_part();
        translate([wing_span/2+foam_height/2,-root_cord,0]) rotate([0,90,0]) wing_tip();
    }
    cockpit_foam();
    */    
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
        cube([foam_height,cockpit_y, cockpit_z], center=true);    
        translate([0,cockpit_y/2-cockpit_y/8,foam_height*6/2]) side_slot(cockpit_y/4, start_angle=sweep_d, end_angle=sweep_d_l1);
        // mirror above
        mirror([0,0,1]) translate([0,cockpit_y/2-cockpit_y/8,foam_height*6/2]) side_slot(cockpit_y/4, start_angle=sweep_d, end_angle=sweep_d_l1);
        translate([0,cockpit_y/8,foam_height*4/2]) side_slot(cockpit_y/4, start_angle=sweep_d_l1, end_angle=sweep_d_l2);
        // mirror above
        mirror([0,0,1]) translate([0,cockpit_y/8,foam_height*4/2]) side_slot(cockpit_y/4, start_angle=sweep_d_l1, end_angle=sweep_d_l2);
        translate([0,-cockpit_y/4,foam_height*2/2]) side_slot(cockpit_y/2, start_angle=sweep_d_l2, end_angle=sweep_d_l3);
        // mirror above
        mirror([0,0,1]) translate([0,-cockpit_y/4,foam_height*2/2]) side_slot(cockpit_y/2, start_angle=sweep_d_l2, end_angle=sweep_d_l3);

    }
}


module cockpit_motor_hole()
{
    translate([cockpit_motor_spacing/2, 0, cockpit_motor_spacing/2] )
                rotate([90,0,0])
                    cylinder(h=cockpit_y*4,r=cockpit_motor_spacing_hole/2, center=true);
}

module cockpit_shell()
{
    translate([0,-cockpit_y/2,0]) 
    {
    //    cube([cockpit_x-foam_height*2,cockpit_y, cockpit_z-foam_height*2], center=true);    
        translate([0,0,-(cockpit_z-foam_height)/2--foam_height])  
        difference()
        {
            cube([cockpit_x-foam_height*2,cockpit_y, foam_height], center=true);    
            cube([cockpit_x-foam_height*4,cockpit_y-foam_height*2, foam_height*4], center=true);    
        }

        cockpit_side_panel();
        mirror([1,0,0]) cockpit_side_panel();

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


    // Back motor
    translate([0,-(cockpit_y-foam_height)/2,0]) difference()
        {
            cube([cockpit_x, foam_height, cockpit_z-foam_height*2], center=true);
            mirror([0,0,0]) cockpit_motor_hole();
            mirror([1,0,0]) cockpit_motor_hole();
            mirror([1,0,1]) cockpit_motor_hole();
            mirror([0,0,1]) cockpit_motor_hole();
        }
    }
}


module print_all_new()  
{
    translate([0,cockpit_y/2+cockpit_z/2+foam_height/2,0]) print_part_cut(cut=1);
    translate([cockpit_x/2+cockpit_z/2+foam_height,0,0]) print_part_cut(cut=2);
    mirror([1,0,0]) translate([cockpit_x/2+cockpit_z/2+foam_height,0,0]) print_part_cut(cut=2);
    translate([0,-cockpit_y/2-foam_height*3,0]) print_part_cut(cut=3);
    translate([0,-cockpit_y/2-foam_height*8.5,0]) print_part_cut(cut=3);
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
            mirror([1,0,0]) translate([space,0,0]) children();
        }
    if(cut==6)
        {
            mirror([1,0,0]) translate([space,0,0]) children();
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
                translate([+wing_span+wing_span/2+cockpit_x/2-height_hypo_size_of_printer,0,0]) cube([wing_span*2,wing_span*2,wing_span*2], center=true);
*                translate([+wing_span-cockpit_x/2+wing_span/2-height_hypo_size_of_printer,0,0]) cube([wing_span*2,wing_span*2,wing_span*2], center=true);
            }
        }
        if(cut==3)
        {
        print_part_cut_position(cut=cut, expand=expand) difference()
            {
                printed_part();
                translate([-wing_span/2+cockpit_x/2-height_hypo_size_of_printer,0,0]) cube([wing_span*2,wing_span*2,wing_span*2], center=true);
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
            print_part_cut_position(cut=cut, expand=expand) 
            {
                print_part_cut(cut=2,expand=expand);
            }
        }
        if(cut==6)
        {
            print_part_cut_position(cut=cut, expand=expand) 
            {
                print_part_cut(cut=3,expand=expand);
            }
        }
    }
}



module printed_part()
{
    color("Coral")
    {
        translate_away_from_cockpit(mirror=false) 
        {
            leading_edge();
        }
        translate_away_from_cockpit(mirror=true) 
        {
            leading_edge();
        }   
        cockpit_front_shell();
        cockpit_shell();
    }
}





module display_foam()
{
    translate_away_from_cockpit(mirror=false) 
    {
        half_KMF6_foam();
        translate([-foam_height,-root_cord-aileron_y,0]) aileron_part();
        translate([wing_span/2+foam_height/2,-root_cord,0]) rotate([0,90,0]) wing_tip();
    }
    translate_away_from_cockpit(mirror=true)
    {
        half_KMF6_foam();
        translate([0,-root_cord-aileron_y,0]) aileron_part();
        translate([wing_span/2+foam_height/2,-root_cord,0]) rotate([0,90,0]) wing_tip();
    }
    cockpit_foam();
        
}

module display_model(printed_part=true, foam=true)
{
    if(printed_part)
    {
        printed_part();
    }
    if(foam)
    {
        display_foam();
    }
}



