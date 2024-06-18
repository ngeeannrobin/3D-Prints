charHeight = 2.5;
backThickness = 0;
plateSize = [24,7.5,42];
fontSize = plateSize[0];

charList = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789!@#$%^&*()";
font = "Courier New:Bold";

blockOffset = [1,1];
blockPerRow = 10;

for (i=[0:len(charList)-1]){
    translate([(i%blockPerRow)*(plateSize[0] + blockOffset[0]), floor(i/blockPerRow) * (plateSize[2] + blockOffset[1]),0])
    union(){
        // adapter
        rotate([-90,0,0])
        import("./models/peglock-plate-.stl", convexity=$fn);

        // backing
        translate([-plateSize[0]/2,0,plateSize[1]/2])
        cube([plateSize[0],plateSize[2],backThickness]);

        // character
        translate([0,plateSize[0]/2,plateSize[1]/2+backThickness])
        linear_extrude(height = charHeight)
        text(charList[i], fontSize, font, halign="center");
    }
}
