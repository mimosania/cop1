extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("die"):
		body.die()
	body.get_node("Killzone").queue_free()

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
	Engine.time_scale = 1
