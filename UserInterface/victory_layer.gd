extends CanvasLayer

@onready var star_1: TextureRect = %Star1
@onready var star_2: TextureRect = %Star2
@onready var star_3: TextureRect = %Star3

@onready var health_label: Label = %"HealthLabel"
@onready var bank_label: Label = %BankLabel

@onready var base: Node3D = get_tree().get_first_node_in_group("Base")
@onready var bank:= get_tree().get_first_node_in_group("bank")

func victory() -> void:
	visible = true
	if base.base_health == base.current_health:
		star_2.modulate = Color.WHITE
		health_label.visible = true
	if bank.current_gold >= 500:
		star_3.modulate = Color.WHITE
		bank_label.visible = true;
	

func restartGame() -> void:
	get_tree().reload_current_scene()
	
func quitGame() -> void:
	get_tree().quit()
