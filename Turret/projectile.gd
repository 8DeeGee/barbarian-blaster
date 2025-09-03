extends Area3D

var direction: Vector3 = Vector3.FORWARD

@export var speed: float = 30.0
@export var damage: int = 30


func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	rotation.y = atan2(direction.x, direction.z)
	

func _on_timer_timeout() -> void:
	queue_free()


func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("enemy_area"):
		var enemy = area.get_parent()
		enemy.take_damage(damage)
		queue_free()
	
