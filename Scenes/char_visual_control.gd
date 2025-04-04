extends Node3D

class_name CharacterVisualControl

var outlines : Array[Material]

func _ready() -> void:
	toggle_outline(false)

func _on_child_entered_tree(node: Node) -> void:
	if node is Node3D:
		for c in node.find_children("*", "MeshInstance3D"):			
			if c is MeshInstance3D:
				print(c.get_surface_override_material(0))
				outlines.push_back(c.get_surface_override_material(0).next_pass)

func toggle_outline(state : bool):
	if state:
		for outline in outlines:
			outline.set_shader_parameter("outline_width", 2.0)
	else:
		for outline in outlines:
			outline.set_shader_parameter("outline_width", 0.0)
