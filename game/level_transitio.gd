extends Control

@export var next_scene: String

@onready var timer: Timer = $Timer

func ready():
	timer.start()
	
	
func on_timer_timeout():
	get_tree()change_scene_to_file(next_scene)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
