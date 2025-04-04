extends Node3D

var mh : MouseHandler
var crc : CameraRaycast

func _on_child_entered_tree(node: Node) -> void:
	if node is ReimuChar:
		$MouseHandler.walk_pos_placed.connect(node.move_to)
	
