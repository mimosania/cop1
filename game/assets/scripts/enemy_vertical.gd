extends Node2D
var alive = true
var direction = 1
@onready var ray_cast_up: RayCast2D = $RayCastUp
@onready var ray_cast_down: RayCast2D = $RayCastDown
@onready var ray_cast_player: RayCast2D = $RayCastPlayer
@onready var timer: Timer = $Timer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func die():
	alive = false
	get_node("Killzone").queue_free()
	get_node("enemy_killzone").queue_free()
	timer.start()
	animated_sprite.play("dead")
	
func _on_timer_timeout() -> void:
	queue_free()
	
func _process(delta: float) -> void:
	if alive == true:
		if ray_cast_up.is_colliding():
			direction = 1
		if ray_cast_down.is_colliding():
			direction = -1
		position.y += direction * delta * 140


func _on_enemy_killzone_area_entered(area) -> void:
	die()
