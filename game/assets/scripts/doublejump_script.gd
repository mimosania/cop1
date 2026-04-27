extends CharacterBody2D


const SPEED = 300
const JUMP_VELOCITY = -400.0
var has_double_jumped
var alive = true

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D



func die():
	animated_sprite.play("död")
	alive = false
	velocity.y = JUMP_VELOCITY
	velocity.x = velocity.x*-1
	get_node("AttackHitbox").queue_free()

func _physics_process(delta: float) -> void:

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if is_on_floor():
		has_double_jumped = false
		
	if alive:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif Input.is_action_just_pressed("jump") and !is_on_floor() and !has_double_jumped:
			velocity.y = JUMP_VELOCITY
			has_double_jumped = true
			
		var direction := Input.get_axis("move_left", "move_right")
		
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true


		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		#Animation
		if velocity.y < 0 and !has_double_jumped:
			animated_sprite.play("jump_up")
		if velocity.y > 0 and !has_double_jumped:
			animated_sprite.play("jump_down")
		if has_double_jumped == true:
			animated_sprite.play("doublejump")
		if velocity.x == 0 and is_on_floor():
			animated_sprite.play("idle")
		if velocity.x != 0 and is_on_floor():
			animated_sprite.play("walking")
		
	move_and_slide()


func _on_attack_hitbox_area_entered(_area) -> void:
	velocity.y = JUMP_VELOCITY
	has_double_jumped = false


func chill():
	animated_sprite.play("chill")
	velocity.x = 0
	velocity.y = 0
	alive = false
