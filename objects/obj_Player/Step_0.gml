//If the player has control
if (hasControl){

	//Keyboard listeners for inputs, sets as 1 if active
	key_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
	key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
	key_jump = keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W"));
	key_jump_held = keyboard_check(vk_space) || keyboard_check(ord("W"));
	key_attack = mouse_check_button_pressed(mb_left) || gamepad_button_check(0,gp_shoulderrb);
	
	//If keyboard used, controller is not used
	if (key_left) || (key_right) || (key_jump) || (key_attack){
		controller = 0;
	}
	
	//Check if gamepad is being used and instead grab inputs for gamepad
	if (abs(gamepad_axis_value(0,gp_axislh)) > 0.2){
		key_left = abs(min(gamepad_axis_value(0,gp_axislh),0));
		key_right = max(gamepad_axis_value(0,gp_axislh),0);
		controller = 1;
	}
	
	//Check if jump button is being pressed on gamepad and active controller if it is
	if (gamepad_button_check_pressed(0,gp_face1)){
		key_jump = 1;
		controller = 1;
	}

//Otherwise all inputs set to 0
} else {
	key_right = 0;
	key_left = 0;
	key_jump = 0;
	key_jump_held = 0;
	key_attack = 0;
}

//Calculate direction of movement
var move = key_right - key_left;

//Apply movespeed
hsp = move * walksp;


if (key_jump_held && (thrustResourceCurrent > 0)){
	vsp = vsp - thrustAcceleration;
	thrustResourceCurrent--;
	timeUntilThrustRecharge = thrustRechargeCooldown;
} else {
	vsp = vsp + grv;
	if (timeUntilThrustRecharge > 0){
		timeUntilThrustRecharge--;
	} else {
		if ((thrustResourceCurrent < thrustResourceMax) && !key_jump_held){
			thrustResourceCurrent++;
		}
	}	
}

if (place_meeting(x,y+1,obj_Wall) && key_jump){
	vsp = jumpsp;
}

//Horizontal collision
if (place_meeting(x+hsp,y,obj_Wall)){
	while (!place_meeting(x+sign(hsp),y,obj_Wall)){
		x = x + sign(hsp);
	}
	hsp = 0;
}
//Adjust x coord
x = x + hsp;


//Vertical Collision
if (place_meeting(x,y+vsp,obj_Wall)){
	while (!place_meeting(x,y+sign(vsp),obj_Wall)){
		y = y + sign(vsp);
	}
	vsp = 0;
}
//Adjust y coord
y = y + vsp;

//Check direction of mouse relative to player
if (x > mouse_x) {
	facingRight = false;
} else {
	facingRight = true;
}

//Check if attacking
if (key_attack) && (timeUntilNextBasicAttack <= 0){
	//Create attack instance
	with (instance_create_layer(x,y,"Slashes",obj_Slash)){
		image_angle = point_direction(other.x,other.y,mouse_x,mouse_y);
	}
	//Reset attack cooldown
	timeUntilNextBasicAttack = basicAttackCooldown;
}

//Tick down attack cooldown if not at 0
if (timeUntilNextBasicAttack > 0) {
	timeUntilNextBasicAttack--;
}

//Animation
if (!place_meeting(x,y+1,obj_Wall)){
	sprite_index = spr_PlayerA;
	image_speed = 0;
	if (sign(vsp) > 0) image_index = 1; else image_index = 0;
} else {
	image_speed = 1;
	if (hsp == 0){
		sprite_index = spr_Player;
	} else {
		sprite_index = spr_PlayerR;
	}
}

//Set image direction
if (hsp != 0) image_xscale = sign(hsp);