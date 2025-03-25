extends CharacterBody2D


var direction = -1

@export var SPEED = 700.0
@export var DISTANCE_PATROL = 100

@onready var detect_wall = $detect_wall as RayCast2D
@onready var sprite = $sprite_enemy as Sprite2D


var start_position: Vector2

func _handle_direction():
	direction *= -1 
	detect_wall.scale.x *= -1
	sprite.scale.x *= -1

func _ready() -> void:
	start_position = global_position
	
	

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	velocity.x = direction * SPEED * delta
	move_and_slide()

	var current_distance = global_position.x - start_position.x	
	if detect_wall.is_colliding():
		_handle_direction()
	
	if abs(current_distance) >= DISTANCE_PATROL:
		_handle_direction()
