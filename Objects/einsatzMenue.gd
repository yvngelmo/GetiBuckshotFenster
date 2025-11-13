extends Control
signal item_chosen(id: String)

@onready var items_row: HBoxContainer = %Einsätze

func _ready() -> void:
	print("EinsatzMenu READY")
	%Titel.text = "Wähle deinen Einsatz"
	_wire_items()

func _wire_items() -> void:
	for v in items_row.get_children():
		if v is VBoxContainer:
			var icon: TextureButton = null
			var caption: Label = null

			# finde den ersten TextureButton + Label in der VBox
			for c in v.get_children():
				if icon == null and c is TextureButton:
					icon = c
				elif caption == null and c is Label:
					caption = c

			if icon == null or caption == null:
				continue

			# ID: Metadaten "id" bevorzugen, sonst Label-Text (klein)
			var id := (str(v.get_meta("id")) if v.has_meta("id") else caption.text.to_lower())

			# Hover → Namen drucken
			icon.mouse_entered.connect(func(): print("id"))

			# Klick → Auswahl drucken + Signal + Scene schließen
			icon.pressed.connect(func():
				print("choose:", id)
				emit_signal("item_chosen", id)
				queue_free()
			)

			icon.tooltip_text = caption.text
