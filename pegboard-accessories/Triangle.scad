module prism(size) {
    points = [
        [size[0]/2,size[1],size[2]],
        [size[0],size[1],0],
        [size[0],0,0],
        [size[0]/2,0,size[2]],
        [0,0,0],
        [0,size[1],0]
    ];

    faces = [
        [1,0,5],
        [2,4,3],
        [0,1,2,3],
        [0,3,4,5],
        [5,4,2,1]
    ];

    polyhedron(points, faces);
}