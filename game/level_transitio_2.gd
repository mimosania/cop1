extends Control



@onready var timer: Timer = $Timer

func _ready():
	timer.start()

func _on_timer_timeout():
	print("aika")
	get_tree().change_scene_to_file("res://assets/scenes/antinkentta.tscn")
