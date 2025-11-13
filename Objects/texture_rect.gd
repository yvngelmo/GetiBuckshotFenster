extends TextureRect

func _process(_delta):
	position = get_viewport_rect().size * 0.5 - size * 0.5 - (get_viewport().get_mouse_position() - get_viewport_rect().size * 0.5) * 0.02
