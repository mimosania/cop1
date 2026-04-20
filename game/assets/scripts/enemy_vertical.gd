extends Node2D
var alive = true
var direction = 1
@onready var ray_cast_up: RayCast2D = $RayCastUp
@onready var ray_cast_down: RayCast2D = $RayCastDown
@onready var ray_cast_player: RayCast2D = $RayCastPlayer

func die():
	alive = false
	direction = direction * -1
	get_node("Killzone").queue_free()

func _process(delta: float) -> void:
	if alive == true:
		if ray_cast_up.is_colliding():
			direction = 1
		if ray_cast_down.is_colliding():
			direction = -1
		if ray_cast_player.is_colliding():
			die()
		position.y += direction * delta * 140
	
