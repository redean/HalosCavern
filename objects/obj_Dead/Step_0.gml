if(done == 0){
	//Apply gravity
	vsp = vsp + grv;

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
		if (vsp > 0) {
			done = 1;
			image_index = 1;
		}
		while (!place_meeting(x,y+sign(vsp),obj_Wall)){
			y = y + sign(vsp);
		}
		vsp = 0;
	}
	//Adjust y coord
	y = y + vsp;
}