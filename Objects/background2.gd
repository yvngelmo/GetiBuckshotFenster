extends MeshInstance3D

var start_pos

func _ready():
	start_pos = global_transform.origin

func _process(_delta):
	var offset = (get_viewport().get_mouse_position() - get_viewport().get_visible_rect().size * 0.5) * 0.0001
	global_transform.origin = start_pos + Vector3(offset.x, offset.y, 0)
