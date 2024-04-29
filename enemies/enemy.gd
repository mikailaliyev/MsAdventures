extends Area2D

signal enemy_attack()



func _on_body_entered(body):
	emit_signal("enemy_attack")
	queue_free()
