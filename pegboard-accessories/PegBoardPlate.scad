use <Triangle.scad>

$fn = $preview ? 8 : 64;

inch = 25.4;
plateSize = [24,7.5,42];
plateModelOffset = [12,3.75,0];

function getModelPlatePosition(boxSize) = [boxSize[0]/2 - plateSize[0]/2,boxSize[1]-plateSize[1],0];
function getBoxSize(unitSize) = [unitSize[0]*inch, unitSize[1]*inch, 42];

module Start(boxSize,plateModelPosition){
    difference(){
        cube(boxSize);
            
        translate(plateModelPosition)
        cube(plateSize);
    }
}

module End(plateModelPosition){
    translate(plateModelOffset+plateModelPosition)
    import("./models/peglock-plate-.stl", convexity=$fn);
}

// Standard box
module Default(unitSize=[3,2],wallThickness=2){
    boxSize = getBoxSize(unitSize);
    plateModelPosition = getModelPlatePosition(boxSize);
    
    union(){
        difference(){
            Start(boxSize,plateModelPosition);
            
            // default
            translate([wallThickness,wallThickness,wallThickness])
            cube(boxSize-[wallThickness*2,wallThickness*2,0]);     
        }
        End(plateModelPosition);
    }
}

// Box with cylinders cut out for holding my tubes
module TubeHolder(unitSize=[3,2], wallThickness=2,tubeRadius=6.25){
    boxSize = [unitSize[0]*inch, unitSize[1]*inch, 42];
    plateModelPosition = [boxSize[0]/2 - plateSize[0]/2,boxSize[1]-plateSize[1],0];
    union(){
        difference(){
            Start(boxSize,plateModelPosition);
            
            // tube holder
            for (x=[-28:14:28], y=[-17:14:11]){
                translate([boxSize[0]/2+x,boxSize[1]/2+y,wallThickness])
                cylinder(plateSize[2],tubeRadius,tubeRadius);
            }
        }
        End(plateModelPosition);
    }
}

// Box with a small slit for holding my scraper
module ScraperHolder(unitSize=[2,1]){
    boxSize = [unitSize[0]*inch, unitSize[1]*inch, 42];
    plateModelPosition = [boxSize[0]/2 - plateSize[0]/2,boxSize[1]-plateSize[1],0];
    

    union(){
        difference(){
            Start(boxSize,plateModelPosition);

            // scraper holder
            scraperHoleSize = [40,3,plateSize[2]];
            translate([boxSize[0]/2-scraperHoleSize[0]/2,boxSize[1]/2-scraperHoleSize[1]/2,0])
            cube(scraperHoleSize);
        }
        End(plateModelPosition);
    }
}

// Box with a prism cut out to hold my plier
module PlierHolder(unitSize=[2,1],plierSize = [55,15,115], heightOffset = -50, wallThickness = 2.5){
    boxSize = getBoxSize(unitSize);
    plateModelPosition = getModelPlatePosition(boxSize);
    
    union(){
        difference(){
            Start(boxSize,plateModelPosition);
            
        // plier holder
            translate([plierSize[0]/2+boxSize[0]/2,wallThickness,plierSize[2]+heightOffset])
            rotate([0,180,0])
            prism(plierSize);   
        }
        End(plateModelPosition);
    }
}

// Box with 1 cylinder cut out to hold my nozzle cleaner
module NozzleCleanerHolder(unitSize=[1,1.2], cleanerRadius = 10, bottomThickness = 2){
    boxSize = [unitSize[0]*inch, unitSize[1]*inch, 42];
    plateModelPosition = [boxSize[0]/2 - plateSize[0]/2,boxSize[1]-plateSize[1],0];
    

    union(){
        difference(){
            Start(boxSize,plateModelPosition);

            // nozzle cleaner
            translate([boxSize[0]/2,boxSize[0]/2,bottomThickness])
            cylinder(plateSize[2],cleanerRadius,cleanerRadius);
        }
        End(plateModelPosition);
    }
}

// Box with custom shape cut out to hold my vernier calipers 
module CaliperHolder(unitSize=[1,2],wallThickness=2){
    boxSize = getBoxSize(unitSize);
    plateModelPosition = getModelPlatePosition(boxSize);
    
    // calliperRulerSize = [4,17];
    // calliperSliderSize = [17,42-8];
    calliperSliderSize2 = [7,8];
    ballSize = [8,12];
    screwSize = [2,8];
    
    calliperRulerSize = [6,17];
    calliperSliderSize = [9,31];
    bottomThickness = 3;
    
    
    union(){
        difference(){
            Start(boxSize,plateModelPosition);
            
            //translate([boxSize[0]/2-calliperSliderSize[0]/2+4,12,0])
            translate([boxSize[0]/2+calliperSliderSize[0]/2-calliperRulerSize[0]-2.5,11,0])
            cube([calliperRulerSize[0],calliperRulerSize[1],plateSize[2]]);
            
            //translate([boxSize[0]/2-calliperSliderSize[0]/2+2,13-ballSize[1],0])
            //cube([ballSize[0],ballSize[1],bottomThickness]);
            
            //translate([boxSize[0]/2-calliperRulerSize[0]-2.5,13,0])
            //cube([screwSize[0],screwSize[1],bottomThickness]);
           
            translate([boxSize[0]/2-calliperSliderSize[0]/2,1,bottomThickness])
            cube([calliperSliderSize[0],calliperSliderSize[1],plateSize[2]]);
            
            //translate([boxSize[0]/2-calliperSliderSize[0]/2+2.5,1+calliperSliderSize[1],42-10])
            //cube([calliperSliderSize2[0],calliperSliderSize2[1],plateSize[2]]);
        }
        End(plateModelPosition);
    }
}

// box with walls cut out to display objects
module Display(unitSize=[7,1.2],wallThickness=2, wallHeight=3){
    boxSize = getBoxSize(unitSize);
    plateModelPosition = getModelPlatePosition(boxSize);
    
    union(){
        difference(){
            Start(boxSize,plateModelPosition);
            
            translate([wallThickness,wallThickness,wallThickness])
            cube(boxSize-[wallThickness*2,wallThickness+plateSize[1],0]);
            
            translate([0,0,wallThickness+wallHeight])
            cube([boxSize[0],boxSize[1]-plateSize[1], boxSize[2]-wallThickness-wallHeight]);
        }
        End(plateModelPosition);
    }
}

// Box to hold my 3d printed filament samples
module Sample(unitSize=[6,1.2],wallThickness=1, bottomThickness=2){
    boxSize = getBoxSize(unitSize);

    plateModelPosition1 = [inch*1.5 - plateSize[0]/2,boxSize[1]-plateSize[1],0];
    plateModelPosition2 = [inch*(unitSize[0]-2) + inch/2 - plateSize[0]/2,boxSize[1]-plateSize[1],0];
    sampleSize = [3,21];
    
    offset = ((boxSize[0] - wallThickness) % (sampleSize[0]+wallThickness)) / 2;
    numberOfSample = floor((boxSize[0]-wallThickness) / (sampleSize[0]+wallThickness));
    
    echo(numberOfSample);

    union(){
        difference(){
            intersection(){
                Start(boxSize,plateModelPosition1);
                Start(boxSize,plateModelPosition2);
            }
            
            //translate([wallThickness,wallThickness,wallThickness])
            //cube(boxSize-[wallThickness*2,wallThickness+plateSize[1],0]);
            
            //translate([0,0,wallThickness+wallHeight])
            //cube([boxSize[0],boxSize[1]-plateSize[1], boxSize[2]-wallThickness-wallHeight]);
            
            for (i=[wallThickness+offset:wallThickness+sampleSize[0]:numberOfSample*(wallThickness+sampleSize[0])]){
                translate([i,wallThickness,bottomThickness])
                cube([sampleSize[0],sampleSize[1],100]);
            }
        }
        End(plateModelPosition1);
        End(plateModelPosition2);
    }
}

// Box to hold my handheld paper shredder
module Shredder(unitSize=[3,2],bottomThickness=2,holeSize=[51,31], bottomHoleSize=1.5, bottomHoleCount=2){
    boxSize = getBoxSize(unitSize);
    plateModelPosition = getModelPlatePosition(boxSize);
    
    circleRadius = holeSize[1]/2;
    circleOffset = holeSize[0]/2 - circleRadius;
    recSize = [holeSize[0]-holeSize[1], holeSize[1]];
    holeSpacing = holeSize[0] / (bottomHoleCount+1);
    xWallThickness = (boxSize[0]-holeSize[0])/2;
    
    union(){
        difference(){
            Start(boxSize,plateModelPosition);
            
            // default
            translate([(boxSize[0]-recSize[0])/2,(boxSize[1]-recSize[1])/2,bottomThickness])
            cube([recSize[0],recSize[1],plateSize[2]]);  
            translate([boxSize[0]/2-circleOffset,boxSize[1]/2,bottomThickness])
            cylinder(plateSize[2],circleRadius,circleRadius);
            translate([boxSize[0]/2+circleOffset,boxSize[1]/2,bottomThickness])
            cylinder(plateSize[2],circleRadius,circleRadius);
            
            for (i=[xWallThickness + holeSpacing: holeSpacing: boxSize[0] - xWallThickness - holeSpacing]){
                translate([i,boxSize[1]/2,0])
                cylinder(bottomThickness, bottomHoleSize, bottomHoleSize);
            }
        }
        End(plateModelPosition);
    }
}

// Box to hold my usbs (from top) and microsd/sd cards (from front)
module USB(unitSize=[3,2],wallThickness=2,usbSpacing=[10,25],sdSpacing=5,sdAngle=5,msdSpacing=3,msdAngle=15){
    usbSize=[5,13,13];
    msdSize = [1.5,15.5,11.5];
    sdSize = [3,33.5,24.5];
    
    boxSize = getBoxSize(unitSize);
    plateModelPosition = getModelPlatePosition(boxSize);
    
    xOffset = ((boxSize[0] - wallThickness*2) % (usbSpacing[0])) / 2;
    
    union(){
        difference(){
            Start(boxSize,plateModelPosition);
            
            // default
            //translate([boxSize[0]/2-usbSize[0]/2,boxSize[1]/2-usbSize[1]/2+10,bottomThickness])
            //cube([usbSize[0],usbSize[1],boxSize[2]]);  

            for (i=[wallThickness+xOffset+usbSize[0]/2:usbSpacing[0]:boxSize[0]-usbSpacing[0]/2-wallThickness]){
                translate([i,boxSize[1]-plateSize[1]-usbSize[1],boxSize[2]-usbSize[2]])
                cube(usbSize);
                translate([i,boxSize[1]-plateSize[1]-usbSize[1]-usbSpacing[1],boxSize[2]-usbSize[2]])
                cube(usbSize);
            }
            
            for (i=[wallThickness+sdSize[0]/2:sdSpacing:boxSize[0]/2]){
                translate([i,-6,wallThickness+3])
                rotate([-sdAngle,0,0])
                cube(sdSize);
            }
            
            for (i=[boxSize[0]/2+msdSize[0]/2:msdSpacing:boxSize[0]-wallThickness]){
                translate([i,-4,wallThickness+3])
                rotate([-msdAngle,0,0])
                cube(msdSize);
                
                translate([i,-4,wallThickness+16.5])
                rotate([-msdAngle,0,0])
                cube(msdSize);
            }

   
        }
        End(plateModelPosition);


    }
}

// Default(unitSize=[2,2]);
// TubeHolder();
// ScraperHolder();
// PlierHolder();
// CaliperHolder();
// Display();
// Sample();
Shredder();
// USB();


