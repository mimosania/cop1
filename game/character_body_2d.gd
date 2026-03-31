extends CharacterBody2D


const SPEED = 300
const JUMP_VELOCITY = -400.0

const DASH_SPEED = 900.0
const DASH_TIME = 0.15
var dashing = false
var dash_timer = 0.0
var facing = 1

func _physics_process(delta: float) -> void:
	
	
	if dashing:
		dash_timer -= delta
	if dash_timer <=0:
		dashing = false
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if  direction != 0:
		facing = direction
		

		
	if Input.is_action_just_pressed("dash") and not dashing:
		dashing = true
		dash_timer = DASH_TIME
		velocity.y = 0
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if dashing:
		velocity.x = facing *DASH_SPEED
	else:
		if direction:
			if dashing:
				velocity.x = direction * DASH_SPEED
			else:
				velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
