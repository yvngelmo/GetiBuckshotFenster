extends Node3D

@export var cameraAnimator: AnimationPlayer
@export var Fenster: Node

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass

func _input(event):
	if event.is_action_pressed("Mouse Middle") and Fenster.allowedToSwitchPlayer:
		Fenster.allowedToSwitchPlayer = false
		if Fenster.currentPlayer == 0:
			cameraAnimator.play("camera_turn")
			Fenster.currentPlayer = 1
		elif Fenster.currentPlayer == 1:
			cameraAnimator.play("camera_return")
			Fenster.currentPlayer = 0

	
func _on_button_pressed() -> void: #weitergeben Knopf
	if Fenster.currentPlayer == 0:
		cameraAnimator.play("camera_turn")
		Fenster.currentPlayer = 1
	elif Fenster.currentPlayer == 1:
		cameraAnimator.play("camera_return")
		Fenster.currentPlayer = 0
