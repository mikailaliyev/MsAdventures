extends Area2D

signal coin_collected()


func _on_body_entered(_body):
	emit_signal("coin_collected")
	
	$AnimationPlayer.play("pickup")
