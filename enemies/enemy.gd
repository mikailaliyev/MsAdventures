extends Area2D

signal enemy_attack()



func _on_body_entered(_body):
	emit_signal("enemy_attack")
	queue_free()
