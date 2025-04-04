extends Node3D
class_name MouseHandler

signal walk_pos_placed(new_pos : Vector3)

@export var mark_scene: PackedScene
var mark : Node3D
var mark_cooldown : float
var max_cooldown : float = 0.2

var mouse_point_at_obj

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = get_viewport().get_camera_3d()
	#walk_pos_placed.connect(get_node("../Reimu").move_to)


func create_mark(pos: Vector3) -> void:
	mark = mark_scene.instantiate()
	add_child(mark)
	mark.global_position = pos

const RAYLENGTH = 1000

var camera : Camera3D

func mouse_to_world_position():
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_length = RAYLENGTH
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	ray_query.collide_with_areas = true
	ray_query.collision_mask = 2
	var raycast_result = space.intersect_ray(ray_query)
	if raycast_result.size() == 0:
		return null
	else:
		return raycast_result.position

func mouse_to_object():
	var camera = get_viewport().get_camera_3d()
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_length = RAYLENGTH
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	ray_query.collide_with_areas = true
	ray_query.collision_mask = 4
	var raycast_result = space.intersect_ray(ray_query)
	if raycast_result.size() != 0:
		return raycast_result.collider
	else:
		return null

func _physics_process(delta: float) -> void:
	if  mark_cooldown <= 0 && Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if mouse_point_at_obj == null:
			mark_cooldown = max_cooldown
			var pos = mouse_to_world_position()
			if pos != null:
				create_mark(pos)
				walk_pos_placed.emit(pos)
		else:
			walk_pos_placed.emit((mouse_point_at_obj as NPCharacter).get_walk_to_talk())
	
	var obj = mouse_to_object()
	if obj == null || obj != mouse_point_at_obj:
		if mouse_point_at_obj != null:
			(mouse_point_at_obj as NPCharacter).show_outline(false)
			mouse_point_at_obj = null
	if obj != null:
		var char = obj as NPCharacter
		if char != null:
			mouse_point_at_obj = obj
			char.show_outline(true)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mark_cooldown -= delta
	
