$fn = $preview ? 8 : 64;

spacing = 25.4;
holeSize = 6.6/2;
grid = 9;
boardSize = spacing * grid;
boardHeight = 3;
holeOffset = spacing/2;

spaceHoleHolder = 1;
holderOffset = holeOffset+holeSize+spaceHoleHolder;
holderWidth = spacing-holeSize*2-spaceHoleHolder*2;
holderLength = spacing*(grid-1)-holeSize*2-spaceHoleHolder*2;
holderHeight = 15;

echo(str("Board Size:", boardSize, "mm x ", boardSize, "mm x ", boardHeight, "mm"));
echo(str("Holder Size:", holderWidth, "mm x ", holderLength, "mm x ", holderHeight, "mm"));

//difference() {
union(){
    // Drill peg holes
    difference(){
        cube([boardSize,boardSize,boardHeight]);
        for (i=[0:1:grid-1],j=[0:1:grid-1]){
            translate([i*spacing+holeOffset,j*spacing+holeOffset,-5])
            cylinder(15,holeSize,holeSize);
        }   
    }
    

    translate([holderOffset,holderOffset,0])
    cube([holderWidth,holderLength,holderHeight+boardHeight]);
    translate([boardSize-holderOffset-holderWidth,holderOffset,0])
    cube([holderWidth,holderLength,holderHeight+boardHeight]);
}
//cutSize = [6.6,20,50];
//translate([holeOffset-cutSize[0]/2 + spacing,holeOffset-cutSize[1]/2 + spacing,-cutSize[2]/2])
//cube(cutSize);

//translate([0,spacing*3,-25])
//cube(boardSize,boardSize,50);
//translate([spacing*3,0,-25])
//cube(boardSize,boardSize,50);

//translate([holderOffset,holderOffset,boardHeight])
//cube([holderWidth,cutSize[1]+(spacing/2-holeSize/2),holderHeight]);
//}








// translate([boardSize,0,0])
// cube([boardSize,boardSize,5]);

// for (i=[0:1:9])
// for (j=[0:1:9])
//     translate([i*spacing+offset+boardSize,j*spacing+offset,-5])
//     cylinder(15,holeSize,holeSize);