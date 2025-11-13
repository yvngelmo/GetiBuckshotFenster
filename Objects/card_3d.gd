extends Node3D

@export var debug_Label: Node
@export var cardSprite: Node
@export var isCorner = true
@export var topCard: Node
@export var bottomCard: Node
@export var leftCard: Node 
@export var rightCard: Node

var abzugProKarte = 1

var cardValue = 0; #max 12
var cardSymbol = 0; #max 3

var cardDimensions = Vector2i(51,79)
var distbetweenCards = 6

var hasBeenTurned = false
var hasTurnedNeighbours = false

var mouseIsOn = false

@onready var animation_player = $AnimationPlayer
@onready var master = get_parent()
@onready var flipFX = $flipFX
var lastResetID = null

func _ready() -> void:
	cardValue = randi_range(0,12)
	cardSymbol = randi_range(0,3)
	debug_Label.text = str(cardValue)
	cardSprite.frame_coords = Vector2i(cardValue,cardSymbol)
	if isCorner:
		hasBeenTurned = true
		animation_player.play("flip")

func _process(delta: float) -> void:
	hasTurnedNeighbours = false
	if topCard != null:
		if topCard.hasBeenTurned == true:
			hasTurnedNeighbours = true
	if bottomCard != null:
		if bottomCard.hasBeenTurned == true:
			hasTurnedNeighbours = true
	if leftCard != null:
		if leftCard.hasBeenTurned == true:
			hasTurnedNeighbours = true
	if rightCard != null:
		if rightCard.hasBeenTurned == true:
			hasTurnedNeighbours = true

func getAmountOfTurnedNeighbours() -> Vector3i:
	var temp = Vector3i(0,0,0)
	var max = 0
	var min = 999
	if topCard != null:
		if topCard.hasBeenTurned == true:
			temp.x += 1
			if topCard.cardValue > max:
				max = topCard.cardValue
			if topCard.cardValue < min:
				min = topCard.cardValue
	
	if bottomCard != null:
		if bottomCard.hasBeenTurned == true:
			temp.x += 1
			if bottomCard.cardValue > max:
				max = bottomCard.cardValue
			if bottomCard.cardValue < min:
				min = bottomCard.cardValue
	
	if leftCard != null:
		if leftCard.hasBeenTurned == true:
			temp.x += 1
			if leftCard.cardValue > max:
				min = leftCard.cardValue
			if leftCard.cardValue < min:
				min = leftCard.cardValue
	
	if rightCard != null:
		if rightCard.hasBeenTurned == true:
			temp.x += 1
			if rightCard.cardValue > max:
				max = rightCard.cardValue
			if rightCard.cardValue < min:
				max = rightCard.cardValue
	
	
	if temp.x == 1:
		if min != 999:
			print("triggered")
			max = min
		else:
			min = max
	temp.y = min
	temp.z = max
	return temp

func reset(resetid: int, eventEntry: bool) -> void:
	if eventEntry:
		await get_tree().create_timer(0.75).timeout
	
	if resetid != lastResetID and hasBeenTurned:
		lastResetID = resetid
		hasBeenTurned = false
		animation_player.play("flip_back")
		$flipFX.play()
		cardValue = randi_range(0,12)
		debug_Label.text = str(cardValue)
		if master.currentPlayer == 1:
			master.Getti_Money -= abzugProKarte
		else:
			master.Bleron_Money -= abzugProKarte
		
		if not is_inside_tree():
			return
		await get_tree().create_timer(0.05).timeout
		mouseIsOn = false
		if topCard != null:
			topCard.reset(resetid,false)
		if bottomCard != null:
			bottomCard.reset(resetid,false)
		if rightCard != null:
			rightCard.reset(resetid,false)
		if leftCard != null:
			leftCard.reset(resetid,false)
		
		if isCorner:
			await get_tree().create_timer(0.3).timeout
			hasBeenTurned = true
			animation_player.play("flip")

func _input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("Mouse Middle"):
			print("amk")
		elif mouseIsOn and not hasBeenTurned:
			hasBeenTurned = true
			animation_player.play("flip")
			$flipFX.play()
			var numN = getAmountOfTurnedNeighbours()
			if event.is_action_pressed("Mouse Left"):
				if numN.x == 1:
					if cardValue <= numN.z:
						reset(randi(),true)
						print("verloren du Pisser")
				if numN.x >= 2:
					if cardValue <= numN.z and cardValue >= numN.y:
						reset(randi(),true)
						print("innerhalb du kleiner Peach")
						
			if event.is_action_pressed("Mouse Right"):
				if numN.x == 1:
					if cardValue >= numN.z:
						reset(randi(),true)
						print("verloren weil kleiner")
				if numN.x >= 2:
					print(cardValue >= numN.z, cardValue <= numN.y)
					if cardValue <= numN.z and cardValue <= numN.y:
						reset(randi(),true)
						print("außerhalb du Pisser")
			
			else:
				master.allowedToSwitchPlayer = true
	elif event is InputEventMouseMotion:
		pass

func _on_area_3d_mouse_entered() -> void:
	if not hasBeenTurned and hasTurnedNeighbours:
		animation_player.play("hover")
		mouseIsOn = true;
		
		master.stateOfCurrentCard = getAmountOfTurnedNeighbours().x

func _on_area_3d_mouse_exited() -> void:
	if not hasBeenTurned and hasTurnedNeighbours:
		animation_player.play("hover_down")
		mouseIsOn = false 

		master.stateOfCurrentCard = 0
