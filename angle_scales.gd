extends Node2D

func _on_button_pressed():
	var value : float = float($TextEdit.text)
	$Scale.rotation = (value)
	get_node("Scale/LeftPlate").rotation = (-value)
	get_node("Scale/RightPlate").rotation = (-value)
