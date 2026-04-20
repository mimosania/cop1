extends Node2D
var alive = true
var direction = 1
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_player: RayCast2D = $RayCastPlayer

func die():
	alive = false
	direction = direction * -1
	get_node("Killzone").queue_free()

func _process(delta: float) -> void:
	if alive == true:
		if ray_cast_right.is_colliding():
			direction = -1
			animated_sprite_2d.flip_h = true
		if ray_cast_left.is_colliding():
			direction = 1
			animated_sprite_2d.flip_h = false
		if ray_cast_player.is_colliding():
			die()
			
		position.x += direction * delta * 140
		
