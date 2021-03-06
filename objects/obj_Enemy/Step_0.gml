//Apply gravity
vsp = vsp + grv;

//Horizontal collision
if (place_meeting(x+hsp,y,obj_Wall)){
	while (!place_meeting(x+sign(hsp),y,obj_Wall)){
		x = x + sign(hsp);
	}
	hsp = -hsp;
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

//Animation
if (!place_meeting(x,y+1,obj_Wall)){
	sprite_index = spr_EnemyA;
	image_speed = 0;
	if (sign(vsp) > 0) image_index = 1; else image_index = 0;
} else {
	image_speed = 1;
	if (hsp == 0){
		sprite_index = spr_Enemy;
	} else {
		sprite_index = spr_EnemyR;
	}
}

//Set image direction
if (hsp != 0) image_xscale = sign(hsp);

if (vulnerable > 0) {
	vulnerable--;
}