extends Node2D
var alive = true
var direction = 1
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var timer: Timer = $Timer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite.flip_h = true
	
func die():
	alive = false
	animated_sprite.flip_h = false
	get_node("Killzone").queue_free()
	get_node("enemy_killzone").queue_free()
	timer.start()
	animated_sprite.play("dead")
	
func _on_timer_timeout() -> void:
	queue_free()
	
func _process(delta: float) -> void:
	if alive == true:
		if ray_cast_right.is_colliding():
			direction = -1
			animated_sprite.flip_h = false
		if ray_cast_left.is_colliding():
			direction = 1
			animated_sprite.flip_h = true
			
		position.x += direction * delta * 140
		


func _on_enemy_killzone_area_entered(_area) -> void:
	die()
