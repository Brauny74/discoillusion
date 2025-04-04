extends CharacterBody3D

class_name ReimuChar

@export var mov_speed : float = 10.0
@export var accel : float = 1.0
var nav_agent : NavigationAgent3D
var moving : bool
var animator : AnimationPlayer

func turn_to(pos: Vector3):
	var target = pos
	target.y = global_position.y
	look_at(target, Vector3.UP, true)

func move_to(pos : Vector3):
	moving = true
	animator.play("walking")
	nav_agent.target_position = pos

func _on_tree_entered() -> void:
	nav_agent = $NavigationAgent3D
	animator = $reimu/Armature/AnimationPlayer
	moving = false

func move(delta: float):
	if NavigationServer2D.map_get_iteration_id(nav_agent.get_navigation_map()) == 0:
		return
	var next_pos: Vector3 = nav_agent.get_next_path_position()
	var direction = (next_pos - global_position).normalized()	
	#velocity = velocity.lerp(direction * mov_speed, accel * delta)	
	#move_and_slide()
	var new_pos = global_position.move_toward(next_pos, delta * mov_speed)
	turn_to(new_pos)
	global_position = new_pos
	
func _physics_process(delta: float) -> void:
	if moving:
		move(delta)


func _on_navigation_agent_3d_target_reached() -> void:
	animator.play("idle")
	moving = false
