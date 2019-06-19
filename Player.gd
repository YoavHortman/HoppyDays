extends KinematicBody2D

var motion = Vector2(0, 0);

const SPEED = 1000;
const GRAVITY = 300;
const JUMP_SPEED = 3000;
const UP = Vector2(0, -1);

signal animate;

func _physics_process(delta):
	apply_gravity();
	jump();
	move();
	animate();
	move_and_slide(motion, UP);
	
func apply_gravity():
	if not is_on_floor():
		motion.y += GRAVITY;
	else:
		motion.y = 0;
		
func jump():
	if Input.is_action_pressed("Jump") && is_on_floor():
		motion.y = -JUMP_SPEED;
		
func move():
	if Input.is_action_pressed("Left") && !Input.is_action_pressed("Right"):
		motion.x = -SPEED;
	elif Input.is_action_pressed("Right") && !Input.is_action_pressed("Left"):
		motion.x = SPEED;
	else:
		motion.x = 0;
		
func animate():
	emit_signal("animate", motion);
	
	
	