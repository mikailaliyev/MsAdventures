extends Area2D
signal portal_reached()


func _on_body_entered(_body):
	emit_signal("portal_reached")
