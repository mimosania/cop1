extends Area2D
@onready var enemy_killzone: Area2D = $"."

func _on_body_entered(body: Node2D) -> void:
	if tree
