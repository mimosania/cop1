extends Area2D
@onready var timer: Timer = $Timer

func _on_body_entered(body) -> void:
	timer.start()
	body.chill()

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://assets/scenes/level_transitio_2.tscn")
