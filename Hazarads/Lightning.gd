extends Node2D

const speed = 300;

func _ready():
	set_as_toplevel(true)
	global_position = get_parent().global_position;

func _on_VisibilityNotifier2D_screen_exited():
	queue_free();
	
func manage_collision():
	var collider = $Area2D.get_overlapping_bodies();
	for object in collider:
		if object.name == "Player":
			get_tree().call_group("GameState", "hurt");
		queue_free();
		

func _process(delta):
	position.y += speed * delta;
	manage_collision();