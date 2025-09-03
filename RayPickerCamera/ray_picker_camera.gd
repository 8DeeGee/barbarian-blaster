extends Camera3D

@onready var ray_cast_3d: RayCast3D = $RayCast3D
@export var camera_click_range: float = 100.0
@export var gridmap: GridMap
@export var turret_manager: Node3D

@export var turret_cost : int = 100

@onready var bank = get_tree().get_first_node_in_group("bank")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void: 
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	ray_cast_3d.target_position = project_local_ray_normal(mouse_position) * camera_click_range
	ray_cast_3d.force_raycast_update()
	
	if ray_cast_3d.is_colliding():
		turret_cost = turret_manager.define_turret_cost()
		if bank.current_gold >= turret_cost:
			Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
			var collider = ray_cast_3d.get_collider()
			if collider is GridMap:
				if Input.is_action_just_pressed("click"):
					var collision_point = ray_cast_3d.get_collision_point()
					var cell = gridmap.local_to_map(collision_point)
					if gridmap.get_cell_item(cell) == 0:
						gridmap.set_cell_item(cell, 2)
						var turret_position: Vector3 = gridmap.map_to_local(cell)
						turret_manager.build_turret(turret_position)
						bank.current_gold -= turret_cost
		else:
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
			
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)

