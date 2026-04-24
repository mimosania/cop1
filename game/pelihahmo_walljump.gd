extends CharacterBody2D


const SPEED = 300
const JUMP_VELOCITY = -600.0
var has_wall_jumped
var alive = true

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D



func die():
	animated_sprite.play("död")
	alive = false
	velocity.y = JUMP_VELOCITY
	velocity.x = velocity.x*-1

func _physics_process(delta: float) -> void:
	
	var direction := Input.get_axis("move_left", "move_right")
	

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if is_on_floor():
		has_wall_jumped = false
		
	if alive:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif Input.is_action_just_pressed("jump") and is_on_wall() and !has_wall_jumped:
			velocity.y = JUMP_VELOCITY
			velocity.x = SPEED * -1
			has_wall_jumped = true
			

		
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true


		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		#Animation
		if has_wall_jumped == true:
			animated_sprite.play("walljump")
		if velocity.x == 0 and is_on_floor():
			animated_sprite.play("idle")
		if velocity.x != 0 and is_on_floor():
			animated_sprite.play("walking")
		
	move_and_slide()


func _on_attack_hitbox_area_entered(area) -> void:
	velocity.y = JUMP_VELOCITY
	has_wall_jumped = false
