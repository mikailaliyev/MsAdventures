extends Area2D

signal coin_collected()


func _on_body_entered(_body):
	$AnimationPlayer.play("pickup")
	emit_signal("coin_collected")
