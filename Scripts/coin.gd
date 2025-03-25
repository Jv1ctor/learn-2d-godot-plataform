extends Area2D


signal scoring

@onready var anim = $animated


func _on_animated_animation_finished() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	anim.play("collect")
	emit_signal("scoring")
