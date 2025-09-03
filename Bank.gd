extends MarginContainer

@export var starting_gold: int = 150

@onready var money_amount: Label = %"Money Amount"


var current_gold: int:
	set(gold_in):
		current_gold = max(gold_in, 0)
		money_amount.text = "gold: " + str(current_gold)
		
		


func _ready() -> void:
	current_gold = starting_gold
