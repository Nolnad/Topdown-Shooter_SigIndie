function drunken_walker(grid,steps,odds,start_x,start_y) {
	// Init Drunkard
	var xx = start_x
	var yy = start_y
	var dir_walk = 0
	// Generate the level
	repeat(steps) {
		grid[xx][yy] = EMPTY
		// Rnadomize the direction
		if (irandom(odds) == odds) {
			dir_walk = irandom(3);	
		}
		// Move the Drunkard
		var dir_x = lengthdir_x(1, dir_walk * 90);
		var dir_y = lengthdir_y(1, dir_walk * 90);
		xx += dir_x;
		yy += dir_y;
		
		// Make sure we don't move outside the room
		if (xx < 2 || xx >= global.GRID_W - 2) {
			xx += -dir_x * 2;
		}
		if (yy < 2 || yy >= global.GRID_H - 2) {
			yy += -dir_y * 2;
		}
	}
	return grid
}