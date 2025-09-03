extends CanvasLayer

func defeat() -> void:
	visible = true
	

func restartGame() -> void:
	get_tree().reload_current_scene()
	
func quitGame() -> void:
	get_tree().quit()
