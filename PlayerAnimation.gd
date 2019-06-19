extends AnimatedSprite

func _on_Player_animate(motion):
	if motion.y < 0:
		play("Jump");
	elif motion.x > 0:
		play("Walk");
		flip_h = false;
	elif motion.x < 0:
		play("Walk");
		flip_h = true;
	else:
		play("Idle");
