extends Node2D

var isPicked = false;

func _on_Area2D_body_entered(body):
	if !isPicked:
		isPicked = true;
		$AnimationPlayer.play("die");
		$AudioStreamPlayer.play();
		get_tree().call_group("GameState", "coin_up");


func die():
	queue_free();