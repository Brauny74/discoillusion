extends Camera3D
class_name CameraMovement

@export var target: Node3D

var offset : Vector3

func _ready() -> void:
	init()

func init():
	offset = global_position - target.global_position

func _process(delta: float) -> void:
	global_position = target.global_position + offset
