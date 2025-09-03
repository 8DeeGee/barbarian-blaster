extends Node3D

@export var projectile: PackedScene 
@export var turret_range: float = 10.0
@export var price: int = 150

var enemy_path: Path3D
var target: PathFollow3D

@onready var muzzle: Node3D = %Muzzle
@onready var turret_top: Node3D = $TurretBase/TurretTop
@onready var turret_base: Node3D = $TurretBase

@onready var arrow_sound: AudioStreamPlayer3D = $TurretBase/TurretTop/Tower_Defense_Ballista_na/Muzzle/AudioStreamPlayer3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	target = find_best_target()
	if target != null:
		turret_top.look_at(target.global_position, Vector3.UP, true)

#Fire!!
func fire() -> void:
	if target != null:
		var shot = projectile.instantiate()
		add_child(shot)
		shot.global_position = muzzle.global_position
		shot.direction = muzzle.global_transform.basis.z
		
		arrow_sound.play()
		animation_player.play("fire")

func find_best_target() -> PathFollow3D:
	var best_target = null
	var best_progress = 0
	var distance: float = 0.0
	
	for enemy in enemy_path.get_children():
		if enemy is PathFollow3D:
			distance = global_position.distance_to(enemy.global_position)
			if distance <= turret_range:
				if enemy.progress > best_progress:
					best_target = enemy
					best_progress = enemy.progress
	
	return best_target
