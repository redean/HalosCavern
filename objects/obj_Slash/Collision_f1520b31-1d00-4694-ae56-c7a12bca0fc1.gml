with(other){
	if (vulnerable <= 0){
		hp--;
		flash = 3;
		hitfrom = other.direction;
		vulnerable = invulnerableFrames;
	}
}