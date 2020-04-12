//Check if slash should be removed
if (timeUntilDeath <= 0){
	instance_destroy();
}
//Tick down counter until slash removed
timeUntilDeath--;

x = obj_Player.x;
y = obj_Player.y;