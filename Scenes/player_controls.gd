extends CharacterBody3D

@export var speed: float = 10.0
var cur_speed : float = 0
@export var acceleration : float = 1.0
var input_dir : Vector2
var facing_direction : Vector3
var target_rotation : Vector3
@export var rot_speed : float = 1.0
@export var animation_tree : AnimationTree


func _dir_to_rotation(direction: Vector3) -> Vector3:
	var res = Vector3(Vector3.ZERO)
	if direction.z > 0:
		res.y = 0
	if direction.z < 0:
		res.y = 180
	if direction.x < 0:
		res.y = -90
	if direction.x > 0:
		res.y = 90
	return res

func _ready() -> void:
	animation_tree = (get_node("./Aya") as ModelAnim).anim_tree

func _physics_process(delta: float) -> void:
	DebugText.debug_text = str(cur_speed)
	input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")	 
	var cur_fac_dir = Vector3(input_dir.x, 0, input_dir.y)
	
	if input_dir.length() != 0:
		cur_speed += acceleration * delta
		if cur_speed > speed:
			cur_speed = speed
	else:
		cur_speed -= acceleration * delta
		if cur_speed < 0:
			cur_speed = 0
	
	animation_tree.set(
		"parameters/BlendSpace2D/blend_position", 
		Vector2(remap(cur_speed, 0.0, speed, 0.0, 1.0),
		 0.0))
	
	if cur_fac_dir.length() > 0 && cur_fac_dir != facing_direction:
		facing_direction = cur_fac_dir
		target_rotation = _dir_to_rotation(facing_direction)
	
	if rotation_degrees != target_rotation:
		rotation_degrees = rotation_degrees.lerp(target_rotation, rot_speed)
	
	velocity = facing_direction * cur_speed
	move_and_slide()
	
