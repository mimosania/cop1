extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body) -> void:
	timer.start()
	Engine.time_scale = 0.5
	if body.has_method("die"):
		body.die()
	body.get_node("CollisionPolygon2D").queue_free()

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
	Engine.time_scale = 1
