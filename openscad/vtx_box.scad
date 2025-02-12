$fn=60;




foam_height = 3;

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
    strut(sx1,sy1,-sx1,sy1,unit/2, unit);
    mirror([0,1,0])  strut(sx1,sy1,-sx1,sy1,unit/2, unit);
}

module vtx_case()
{
    inside=34;
    t=1.25;
//    z_i=5+5-5;
    z_i=t*2;

    cx=inside+t*2;
    cy=inside+t*2;
    cz=z_i;
    vtx_height = 40;

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




vtx_case();
