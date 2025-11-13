extends Area3D

func _physics_process(_delta):
	input_ray_pickable = false
	for card in get_node("../Fenster").get_children():
		if card.get_node("AnimationPlayer").is_playing() and (card.get_node("AnimationPlayer").current_animation == "flip" or card.get_node("AnimationPlayer").current_animation == "flip_back"):
			input_ray_pickable = true
			return
