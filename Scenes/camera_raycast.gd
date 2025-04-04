extends RayCast3D

class_name CameraRaycast

static var instance : CameraRaycast

func ready():
	if instance == null:
		instance = self
	else:
		queue_free()

func get_collision():
	var obj = get_collider()
	if obj == null:
		return null
	else:
		print(obj)
