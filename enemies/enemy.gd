extends Area2D

signal enemy_attack()



func _on_body_entered(_body):
	$AnimationPlayer.play("damage")
	emit_signal("enemy_attack")
