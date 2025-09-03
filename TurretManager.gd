extends Node3D

@export var cannon_turret: PackedScene
@export var ballista_turret: PackedScene
@export var enemy_path: Path3D

@onready var current_turret_label: Label = %CurrentTurretLabel

@onready var build_sound: AudioStreamPlayer = $AudioStreamPlayer

var selected_turret: String = "cannon_turret"

func build_turret(position: Vector3) -> void:
	var new_turret
	if selected_turret == "cannon_turret":
		new_turret = cannon_turret.instantiate()
		
	elif selected_turret == "ballista_turret":
		new_turret = ballista_turret.instantiate()
	add_child(new_turret)
	new_turret.global_position = position
	new_turret.enemy_path = enemy_path
	build_sound.play()

func define_cannon() -> void:
	selected_turret = "cannon_turret"
	current_turret_label.text = "Selected Turret: Cannon"

func define_ballista() -> void:
	selected_turret = "ballista_turret"
	current_turret_label.text = "Selected Turret: Ballista"
	
func define_turret_cost() -> int:
	if selected_turret == "cannon_turret":
		var new_turret = cannon_turret.instantiate()
		return new_turret.price
		
	elif selected_turret == "ballista_turret":
		var new_turret = ballista_turret.instantiate()
		return new_turret.price
		
	return 100
	
func _on_ready() -> void:
	selected_turret = "cannon_turret"
	current_turret_label.text = "Selected Turret: Cannon"
