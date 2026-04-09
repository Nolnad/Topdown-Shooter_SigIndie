global.GRID_W = room_width/CELLSIZE
global.GRID_H = room_height/CELLSIZE

x_center = floor(global.GRID_W/2) // Or round()
y_center = floor(global.GRID_H/2) 

cell_map = RunCellularAutomata(global.GRID_W,global.GRID_H,60,4,5,9)

repeat(1) {
	cell_map = drunken_walker(cell_map,300,2,x_center,y_center)
}

CreateWalls(cell_map,0,0);