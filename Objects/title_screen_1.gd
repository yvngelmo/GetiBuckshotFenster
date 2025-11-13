extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CenterContainer/VBoxContainer/startGame.pressed.connect(startsaftung)
	$CenterContainer/VBoxContainer/endGame.pressed.connect(endsaftung)

func startsaftung():
	var canvas_layer = CanvasLayer.new()
	canvas_layer.layer = 100
	canvas_layer.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().root.add_child(canvas_layer)
	
	var overlay = ColorRect.new()
	overlay.color = Color.BLACK
	overlay.set_anchors_preset(Control.PRESET_FULL_RECT)
	overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
	canvas_layer.add_child(overlay)
	
	await get_tree().create_timer(0.2).timeout
	
	get_tree().change_scene_to_packed(load("res://Levels/main3d.tscn"))
	
	var tween = canvas_layer.create_tween()
	tween.tween_property(overlay, "modulate:a", 0.0, 2)
	await tween.finished
	canvas_layer.queue_free()

func endsaftung():
	get_tree().quit()
