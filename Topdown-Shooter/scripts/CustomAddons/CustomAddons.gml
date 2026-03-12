function approach(value, goal, spd, spd_down = spd)
{
	/// Approach(a, b, amount)
	// Moves "a" towards "b" by "amount" and returns the result
	/// @param value
	/// @param goal
	/// @param spd
	
	if (value < goal)
	{
	    value += spd;
	    if (value > goal)
	        return goal;
	}
	else
	{
	    value -= spd_down;
	    if (value < goal)
	        return goal;
	}
	return value;
}


function draw_shadow()
{
	half_w = sprite_width/2
	half_h = half_w/2
	draw_ellipse(x-half_w,y-half_h,x+half_w,y+half_h,false)
}

function move_in_dir(argument0,argument1)
{
	/// Approach(speed, direction)
	// Moves object in direction using length_dir
	/// @param speed
	/// @param direction
	
	sped = argument0
	dir  = argument1

	x += lengthdir_x(sped,dir)
	y += lengthdir_y(sped,dir)
}


///@desc angle_lerp
///@param in
///@param target
///@param percent
function angle_lerp(argument0, argument1, argument2) {
    var angle = (argument0 - angle_difference(argument0, argument1) * argument2)
	
    if(angle < 0) angle+=360;
    if(angle >= 360) angle -= 360;

    return angle;
}

//Wave(from, to, duration, offset)
 
// Returns a value that will wave back and forth between [from-to] over [duration] seconds
// Examples
//      image_angle = Wave(-45,45,1,0)  -> rock back and forth 90 degrees in a second
//      x = Wave(-10,10,0.25,0)         -> move left and right quickly
 
// Or here is a fun one! Make an object be all squishy!! ^u^
//      image_xscale = Wave(0.5, 2.0, 1.0, 0.0)
//      image_yscale = Wave(2.0, 0.5, 1.0, 0.0)

///@param from
///@param to
///@param duration
///@param offset

function wave(argument0, argument1, argument2, argument3) {
a4 = (argument1 - argument0) * 0.5;
return argument0 + a4 + sin((((current_time * global.timeperc * 0.001) + argument2 * argument3) / argument2) * (pi*2)) * a4;
}

/// @desc sleep(time)
function sleep_call(argument0,argument1) {

	/// @arg Time
	var freezet = argument0
	var delay = argument1

	oPause.sleeping = true
	oPause.sleep_time = argument0
	oPause.sleepdel = argument1



}

function sleep(argument0) {
	
	var freezet = (argument0)
	var t = current_time + freezet
	while(current_time < t){ //audio_pause_all();
		}
	audio_resume_all();
}

/// @desc ScreenShake(magnitude,frames)
/// @arg Magnitude sets the strength of the shake (radius in pixels)
/// @arg Framses sets the length of the shake in frames (60 - 1 second at 60fps)
function screen_shake(_magnitude, _time) {

	with (oCamera)
	{
		if (_magnitude > shakeA)
		{
			shakeM = _magnitude;
			shakeA = _magnitude;
			shakeL = _time;		
		}
	}
}

/// @desc ScreenShake(magnitude,frames)
/// @arg Magnitude sets the strength of the shake (radius in pixels)
/// @arg Framses sets the length of the shake in frames (60 - 1 second at 60fps)
function spring_func(argument0, argument1, argument2, argument3, argument4) {
var velo = argument0
var current_velo = argument1
var drag = argument2
var spring = argument3
var target_velo = argument4

velo += (target_velo - current_velo) * spring;
velo -= drag * velo;
current_velo += velo
return velo

}


function reach_tween(argument0, argument1, argument2){
	return(lerp(argument0,argument1,1/argument2));
}

///@desc play_audio_rand_pitch(sfx,loop,gain,priority,pitch_lower_bound,pitch_upper_bound)
///@param sfx
///@param loop
///@param gain
///@param priority
///@param pitch_lower_bound
///@param pitch_upper_bound

function play_audio_rand_pitch(_sfx, _loop, _gain=1, _priority, _pitch_lower_bound, _pitch_upper_bound)
{
	audio_play_sound(_sfx,_priority,_loop,_gain)
	audio_sound_pitch(_sfx,random_range(_pitch_lower_bound,_pitch_upper_bound))
}
function play_audio_rand_pitch_at(_sfx,_x,_y, _loop, _gain=1, _priority, _pitch_lower_bound, _pitch_upper_bound)
{
	audio_play_sound_at(_sfx,_x,_y,0,575,1000,.03,_loop,_priority,_gain)
	audio_sound_pitch(_sfx,random_range(_pitch_lower_bound,_pitch_upper_bound)*global.timeperc)
}

// EX: multi_chance([sprEnemy1, sprEnemy2, sprEnemy3], [5, 2, 1]);
function multi_chance(options, weights, use_indices) {
    if (argument_count < 3) use_indices = false;
    var array_size = array_length(weights);
    
    var sum_weights = 0;
    for (var i = 0; i < array_size; i++) { sum_weights += weights[i]; }
    
    var rand = random(sum_weights);
    for (var i = 0; i < array_size; i++) {
        if (rand > weights[i]) {
            rand -= weights[i];
        } else {
            if (use_indices) {
                return i;
            } else {
                return options[i];    
            }
        }
    }
}

function perc_chance(perc)
{
	chance = irandom_range(1,100);
	if chance <= perc{
		return true;	
	} else return false;	
}

function random_360()
{
	var result = irandom_range(1,360)
	return result;
}

function x_to_gui_x(x) {
    var normal_x = (x - camera_get_view_x(view_camera[0])) / camera_get_view_width(view_camera[0]);

    return normal_x * display_get_gui_width();
}

function y_to_gui_y(y) {
    var normal_y = (y - camera_get_view_y(view_camera[0])) / camera_get_view_height(view_camera[0]);

    return normal_y * display_get_gui_height();
}

function random_frame(sprite)
{
	return irandom(sprite_get_number(sprite));
	
}

function modDistance(a, b, d) {
    // Wrapping a and b in posmod before subtraction so that 0 < a,b < 360
    a = posmod(a, d);
    b = posmod(b, d);
    if (a == b) 
	{ 
		return 0 
	}
    // Need to use programmer's modulo to obtain the magnitude the negative difference without it just wrapping around to 335
    var diff1 = ((a + d) - b) % d; // (355 + 360) - 20 = 695; 695 % 360 = 335
    var diff2 = (a - (b + d)) % d; // 355 - (20 + 360) = -25; -25 % 360 = -25
    // Return the smaller of the two distances as a positive integer
    return min(abs(diff1), abs(diff2))
}


function posmod(n, d) { return ((n % d) + d) % d }

function lexp(a, b, t)
{
    return a + (b - a) * (1.0 - exp(-t))
}

function lexp_t(a, b, t)
{
    return a + (b - a) * (1.0 - exp(-t * global.timeperc));
}


function dec(val,goal = 0,spd = 1)
{
	spd *= global.timeperc;
	
	if (val < goal)
	{
	    val += spd;
	    if (val > goal)
	        return goal;
	}
	else
	{
	    val -= spd;
	    if (val < goal)
	        return goal;
	}
	return val;
}

function reachtween(argument0, argument1, argument2) {

	return(lerp(argument0,argument1,1/argument2));
}

function vec2(xx,yy) constructor
{
	X = xx;
	Y = yy;
}

function modDistanceNeg(a, b, d) {
    // Wrap a and b into the range [0, d) using posmod
    a = posmod(a, d);
    b = posmod(b, d);
    
    // Calculate clockwise and counterclockwise distances
    var clockwiseDist = (b - a + d) % d;
    var counterclockwiseDist = (a - b + d) % d * -1;
    
    // Return the signed shortest distance
    return abs(clockwiseDist) < abs(counterclockwiseDist) ? clockwiseDist : counterclockwiseDist;
}

function bezier_points(t, points) {
    /*
    t: The interpolation factor (0 ≤ t ≤ 1)
    points: An array of points in the form [x1, y1, x2, y2, ..., xn, yn]
    
    Returns an array [px, py] representing the calculated point.
    */
    
    var n = array_length(points) div 2 - 1; // Degree of the curve
    var px = 0, py = 0; // Final calculated point
    
    // Loop through each control point
    for (var i = 0; i <= n; i++) {
        // Calculate the Bernstein coefficient
        var binomial = factorial(n) / (factorial(i) * factorial(n - i)); // Binomial coefficient
        var bernstein = binomial * power(t, i) * power(1 - t, n - i);
        
        // Accumulate the x and y contributions
        px += bernstein * points[i * 2];     // x-coordinate
        py += bernstein * points[i * 2 + 1]; // y-coordinate
		
		var next = min(i+1,n)
    }
    
    // Return the calculated point as an array
    return [px, py];
}
	
function bezier_points_leg(t, ds_list) {
    /*
    t: The interpolation factor (0 ≤ t ≤ 1)
    ds_list: A ds_list where ds_list[0] is the array of x-coordinates 
             and ds_list[1] is the array of y-coordinates.
    
    Returns an array [px, py] representing the calculated point.
    */

    var x_points = ds_list.seg_X; // x-coordinates array
    var y_points = ds_list.seg_Y; // y-coordinates array
    var n = array_length(x_points) - 1; // Degree of the curve
    var px = 0, py = 0; // Final calculated point

    // Loop through each control point
    for (var i = 0; i <= n; i++) {
        // Calculate the Bernstein coefficient
        var binomial = factorial(n) / (factorial(i) * factorial(n - i)); // Binomial coefficient
        var bernstein = binomial * power(t, i) * power(1 - t, n - i);

        // Accumulate the x and y contributions
        px += bernstein * x_points[i]; // x-coordinate
        py += bernstein * y_points[i]; // y-coordinate
    }

    // Return the calculated point as an array
    return [px, py];
}

// Helper function for factorial calculation
function factorial(n) {
    if (n == 0 || n == 1) return 1;
    return n * factorial(n - 1);
}
function irandom_range_weighted(_low, _high, _mean, _spread) {
    // Ensure valid spread
    if (_spread <= 0) _spread = 1;

    // Generate a Gaussian random value using the Box-Muller transform
    var u1 = max(random(1), 0.00001); // Ensure u1 > 0 to avoid ln(0)
    var u2 = max(random(1), 0.00001); // Uniform random [0
    var z0 = sqrt(-2 * ln(u1)) * cos(2 * pi * u2); // Standard normal distribution (mean=0, std dev=1)

    // Scale and shift the Gaussian value to the desired mean and spread
    var weighted = _mean + z0 * _spread;

    // Clamp to the specified range and round to integer
    return clamp(round(weighted), _low, _high);
}

function random_range_weighted(_low, _high, _mean, _spread) {
    // Ensure valid spread
    if (_spread <= 0) _spread = 1;

    // Generate a Gaussian random value using the Box-Muller transform
    var u1 = max(random(1), 0.00001); // Ensure u1 > 0 to avoid ln(0)
    var u2 = max(random(1), 0.00001); // Uniform random [0, 1)
    var z0 = sqrt(-2 * ln(u1)) * cos(2 * pi * u2); // Standard normal distribution (mean=0, std dev=1)

    // Scale and shift the Gaussian value to the desired mean and spread
    var weighted = _mean + z0 * _spread;

    // Clamp to the specified range without rounding
    return clamp(weighted, _low, _high);
}

function random_image(_low_range=0, _high_range=sprite_get_number(sprite_index)) {
	return irandom_range(_low_range,_high_range);
}

function lerp_dt(_current, _target, _speed)
{
    var dt = 1//delta_time / 1000000;
    var t  = _speed * dt * global.timeperc;
    t = clamp(t, 0, 1);

    return lerp(_current, _target, t);
}