#macro EMPTY 0
#macro SOLID 1
#macro CELLSIZE 24

function CountNeighbours(X,Y,_map) { // We input the x (or column) and y (or row) of the cell we want to access, as well as the map we are using
    ///@func    CountNeighbours(x,y,_map);
    ///@param   x               The current cell's x position
    ///@param   y               The current cell's y position
    ///@param   _map            The current map
         
    var _count = 0; // This will keep track of how many neighbours are solid
    for (var dx=-1;dx<2;dx++) { 
        for (var dy=-1;dy<2;dy++) { // Double for loop again, but this time a variant explained below
            var xx = X+dx; // Get the x position of the neighbour cell
            var yy = Y+dy; // Get the y position of the neighbour cell
            if (xx < 0 || yy < 0 || xx >= map_width || yy >= map_height) { // If the neighbour cell we are trying to check is out of bounds
                     
                /* We have two choices here: either act as though any neighbours outside of the
                grid are SOLID or act as though they are EMPTY. The cellular automata will behave
                differently depending on which we choose. I've chosen to act as though they are
                SOLID */
                     
                _count++; // Add to count because we decided to act as though out of bounds cells are SOLID
            }
            else if (dx == 0 && dy == 0) {
                continue; // If dx and dy equal 0, then we are checking the supplied cell, not it's neighbours, so skip it with a continue
            }
            else {
                var _neighbour = _map[xx][yy]; // Get the value of the neighbour cell
                if (_neighbour == SOLID) { // If the value of the neighbour is SOLID
						_count++; // Add to the solid count
                }
            }
        }
    }
    return _count; // Finally, return the SOLID count
}
	
function RunCellularAutomata(_map_width,_map_height,_spawn_chance,_create_limit,_destroy_limit,_iterations) {
    ///@func    RunCellularAutomata(_map_width,_map_height,_spawn_chance,_create_limit,_destroy_limit,_iterations);
    ///@param   _map_width      The width of the map
    ///@param   _map_height     The height of the map
    ///@param   _spawn_chance   The chance a cell is turned SOLID
    ///@param   _create_limit   The neighbour count that will turn an EMPTY cell SOLID
    ///@param   _destroy_limit  The neighbour count that will turn a SOLID cell EMPTY
    ///@param   _iterations     The number of iterations we want to perform on the map
     
    map_width = _map_width;
    map_height = _map_height;
     
    static CreateMap = function() { // When we call CreateMap we will supply the w (or width) and h (or height) that we want
        ///@func    CreateMap(w,h);
        ///@param   w   Map width
        ///@param   h   Map height
         
        var _map; // Create a temporary variable to hold our 2D array
        for (var xx=0;xx<map_width;xx++) { // Loop through the width/columns we want
            for (var yy=0;yy<map_height;yy++) { // Loop through the height/rows we want
                _map[xx][yy] = EMPTY; // Set the 2D array to EMPTY at cell xx,yy
            }
        }
         
        return _map; // Return the 2D array
    }
     
    static RandomiseMap = function(_map,_spawn_chance) { // We supply the map we want to randomise, along with the chance each cell has of being turned SOLID (between 0 and 100, think of it as a percentage)
        ///@func    RandomiseMap(_map,_spawn_chance);
        ///@param   _map            The current map
        ///@param   _spawn_chance   The chance that each cell is turned SOLID
         
        for (var xx=0;xx<map_width;xx++) {
            for (var yy=0;yy<map_height;yy++) {
                var _roll = random(100); // Choose a random number between 0 and 100
                if (_roll <= _spawn_chance) { // If the roll is less than or equal to the spawn chance we supplied
                    _map[xx][yy] = SOLID; // We set the current cell to SOLID
                }
            }
        }
        return _map; // Return the map when we are done
    }
     
    static Iterations = function(_old_map,_create_limit,_destroy_limit) { // Pass in the currently existing map
        ///@func Iterations(_old_map,_create_limit,_destroy_limit);
        ///@param   _old_map        The map as it currently stands
        ///@param   _create_limit   The neighbour count that will turn an EMPTY cell SOLID
        ///@param   _destroy_limit  The neighbour count that will turn a SOLID cell EMPTY
         
        var _new_map = []; // Create a new map to modify
        for (var xx=0;xx<map_width;xx++) {
            for (var yy=0;yy<map_height;yy++) {
                var _count = CountNeighbours(xx,yy,_old_map); // Check how many SOLID neighbours the current cell has on the old map
                if (_old_map[xx][yy]) { // If the old map cell is SOLID
                    if (_count < _destroy_limit) { // If the SOLID neighbour count is less that the "underpopulation" limit
                        _new_map[xx][yy] = EMPTY; // Set the corresponding cell on the new map to EMPTY
                    }
                    else { // Otherwiise if the SOLID neighbour count is greater than the "underpopulation" limit
                        _new_map[xx][yy] = SOLID; // Set the corresponding cell on the new map to SOLID
                    }
                }
                else { // If the old map cell is EMPTY
                    if (_count > _create_limit) { // If the neighbour count is greater that the "birth" limit
                        _new_map[xx][yy] = SOLID; // Mark the corresponding cell on the new map to SOLID
                    }
                    else { // Otherwise
                        _new_map[xx][yy] = EMPTY;
                    }
                }
            }
        }
        return _new_map;
    }
     
    var _ca_map = CreateMap(map_width,map_height);
    _ca_map = RandomiseMap(_ca_map,_spawn_chance);
     
    repeat(_iterations) {
        _ca_map = Iterations(_ca_map,_create_limit,_destroy_limit);
    }
     
    return _ca_map;
     
}

function CreateWalls(_map,x,y) {
    ///@func    CreateWalls(_map,x,y);
    ///@param   _map    The map we want to read
    ///@param   x   The x position to start creating instances at
    ///@param   y   The y position to start creating instances at
     
    for (var xx=0;xx<map_width;xx++) {
        for (var yy=0;yy<map_height;yy++) {
            var x1 = x+xx*CELLSIZE;
            var y1 = y+yy*CELLSIZE;
            if (_map[xx][yy] == SOLID) {
                instance_create_layer(x1,y1,layer,oSolid);
            }
        }
    }
}

