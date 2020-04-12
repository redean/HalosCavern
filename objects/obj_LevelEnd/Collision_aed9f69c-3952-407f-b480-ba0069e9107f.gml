/// @description Move to next room

with (obj_Player){
	if (hasControl){
		hasControl = false;
		SlideTransition(TRANS_MODE.GOTO, other.target);
	}
}
