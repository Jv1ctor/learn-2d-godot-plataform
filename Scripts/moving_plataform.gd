extends Node2D

const WAIT_DURATION = 1

@onready var platform = $platform

@export var move_speed = 3
@export var distance = 192
@export var moving_horizontal = true

var follow = Vector2.ZERO
var platform_center = 16

func _ready() -> void:
	move_platform()
	
func _physics_process(delta: float) -> void:
	platform.position = platform.position.lerp(follow, .5)
	
func move_platform():
	var move_direction = Vector2.RIGHT * distance if moving_horizontal else Vector2.UP * distance
	var duration = move_direction.length() / float(move_speed * platform_center)
	
	var plataform_tween = create_tween().set_loops().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	
	plataform_tween.tween_property(self, "follow", move_direction, duration).set_delay(WAIT_DURATION)
	plataform_tween.tween_property(self, "follow", Vector2.ZERO, duration).set_delay(duration + WAIT_DURATION * 2)

	
	
