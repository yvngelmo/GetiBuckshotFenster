extends Node3D

var currentPlayer = 0 #1 = Getti, 0 = Blasrohr
var mouseGameplayBlock = false #kann auf true gestellt werden, wenn das Einsätze Menü gerade angezeigt wird
var allowedToSwitchPlayer = false

var stateOfCurrentCard = 0 #0 = kann nicht ausgewählt werden, 1 = Karte hat einen Nachbar, 2 = Karte hat mind. 2 Nachbarn

var Getti_Money = 20:
	set(value):
		Getti_Money = value
		geldGeändert()

var Bleron_Money = 20:
	set(value):
		Bleron_Money = value
		geldGeändert()

@export var gettiGeldLabel: Node
@export var bleronGeldLabel: Node

func _process(delta: float) -> void:
	gettiGeldLabel.text = str(Getti_Money)+"$"
	bleronGeldLabel.text = str(Bleron_Money)+"$"

func geldGeändert(): #sterben aktiviereb bra
	if Getti_Money <= 0 || Bleron_Money <= 0:
		get_tree().change_scene_to_packed(load("res://Levels/endScreen1.tscn"))
