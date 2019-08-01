extends KinematicBody2D

var motion = Vector2(0, 0);

const SPEED = 1000;
const GRAVITY = 300;
const JUMP_SPEED = 5000;
const UP = Vector2(0, -1);
const WORLD_LIMIT = 3000;
export var BOOST_MULTIPLAYER = 1.2

signal animate;

func _physics_process(delta):
	apply_gravity();
	jump();
	move();
	animate();
	move_and_slide(motion, UP);
	
func apply_gravity():
	if position.y > WORLD_LIMIT:
		get_tree().call_group("GameState", "end_game");
	if is_on_floor() and motion.y > 0:
		motion.y = 0;
	elif is_on_ceiling(): 
		motion.y = 1;
	else:
		motion.y += GRAVITY;
		
func jump():
	if Input.is_action_pressed("Jump") && is_on_floor():
		motion.y = -JUMP_SPEED;
		$JumpSFX.play();
		
func move():
	if Input.is_action_pressed("Left") && !Input.is_action_pressed("Right"):
		motion.x = -SPEED;
	elif Input.is_action_pressed("Right") && !Input.is_action_pressed("Left"):
		motion.x = SPEED;
	else:
		motion.x = 0;
		
func animate():
	emit_signal("animate", motion);
	
	
func hurt():
	$PainSFX.play();
	position.y -= 1;
	yield(get_tree(), "idle_frame");
	motion.y = -JUMP_SPEED;
	
func boost():
	position.y -= 1;
	yield(get_tree(), "idle_frame");
	motion.y -= JUMP_SPEED * BOOST_MULTIPLAYER;
	