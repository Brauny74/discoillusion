extends CharacterBody3D

class_name NPCharacter

@export var _walk_target : Node3D

var visuals : CharacterVisualControl

func _ready() -> void:
	visuals = $aya
	
func show_outline(state : bool):
	visuals.toggle_outline(state)

func get_walk_to_talk() -> Vector3:
	return _walk_target.global_position
