extends Node3D

signal game_over

@onready var label_3d: Label3D = $Label3D

@onready var soundtrack: AudioStreamPlayer = $Soundtrack

@export var base_health: float = 5.0
@export var hp_offset:= Vector3(0, 5.5, 0)

var current_health: float = base_health:
	set(new_health_value):
		#a couple hiccups were found: 
			#first i tried making it dynamically change from white to red, but i was passing Color(hp_dynamic_value, 0.0, 0.0), which would obviously start fully red and go black by the end;
			#then i had the idea to pass hp_dynamic_value on the green and blue channels, with a 1.0 on the red channel, which actually got me the desired result, with one issue;
			#because the health values were ints, and for some odd reason a division between two ints can't return a float, it was going straight from white to pure black;
			#first i solved it by turning the hp into a float, but for ease of use reasons, i decided to go with the course's solution of only converting the ints to floats during the division;  
		
		current_health = new_health_value
		var hp_red_dynamic_value: float = current_health/base_health
		label_3d.text = str(current_health) + "/" + str(base_health)
		label_3d.global_position = global_position + hp_offset
		#print(hp_red_dynamic_value)
		label_3d.modulate = Color(1.0, hp_red_dynamic_value,hp_red_dynamic_value)
		
		#alternative way, as shown by gamedev.tv: 
			#var red: Color = Color.RED
			#var white: Color = Color.WHITE
			#var blended_color = red.lerp(white, current_health/base_health)
		
		#print("var 'current_health' was set to: " + str(new_health_value))
		if(current_health < 1):
			game_over.emit()
			
	get:
		return current_health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_health = base_health
	soundtrack.play()
	#Engine.time_scale = 3
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func take_damage() -> void: 
	print("Enemy armor is hit!")
	current_health -= 1
	
	
