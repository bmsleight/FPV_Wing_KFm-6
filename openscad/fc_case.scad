$fn=60;

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


module fc_case(case=true, fc=true)
{
    t=1.25;
    tolerance=0.5;
    fc_x = 37+tolerance;
    fc_y = 26+tolerance;
    fc_z = 14+tolerance;
    foam_height=3;
    gap=17;
    od=7;
    id=3;
    if(case==true)
    {
        translate([0,0,(fc_z+t*2)/2])
        {
            translate([0,0,-fc_z/2]) difference()
            {
                union()
                {
                    cube([fc_x+foam_height,fc_y+foam_height,t*2], center=true);
                    translate([0,0,-t/2]) cube([fc_x+foam_height*2,fc_y+foam_height*2,t*1], center=true);
                }
                cube([fc_x-foam_height,fc_y-foam_height,t*4], center=true);        
                translate([0,0,t]) cube([fc_x,fc_y,t*2], center=true);
            }
            translate([0,0,-t/2]) pillars(od=od,id=id,ox=gap,oy=fc_y/2, oz=fc_z+t);
            translate([0,0,(fc_z+t)/2]) fc_case_top(od=od, id=id, t=t, ox=gap,oy=fc_y/2, oz=fc_z+t);
    
        }
    }
    if(fc==true)
    {
        translate([0,0,(fc_z+t*2)/2]) color("Red") cube([fc_x,fc_y,fc_z], center=true);
    }
}


fc_case();

