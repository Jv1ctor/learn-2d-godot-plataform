extends CharacterBody2D


const SPEED = 300.0
const JUMP_FORCE = -400.0

@onready var animatedPlayer = $AnimatedSprite as AnimatedSprite2D
var is_jumping = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_FORCE
		is_jumping = true
		animatedPlayer.play("jump")
	elif is_on_floor():
		is_jumping = false
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animatedPlayer.scale.x = direction
		if !is_jumping:
			animatedPlayer.play("run")
	elif is_jumping:
		animatedPlayer.play("jump")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animatedPlayer.play("idle")

	move_and_slide()
