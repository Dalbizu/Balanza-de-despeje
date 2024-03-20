extends Node2D

func _on_button_pressed():
	rotate_scales(float(get_node("TestTools/TextEdit").text))
	
func rotate_scales(angle : float) -> void:
	var new_angle : float 
	while(angle > $Scale.rotation):
		new_angle = lerp($Scale.rotation, angle, 0.01 + ($Scale.rotation/angle)*0.1)
		$Scale.rotation = new_angle
		get_node("Scale/LeftPlate").rotation = -new_angle
		get_node("Scale/RightPlate").rotation = -new_angle
		await get_tree().create_timer(0.01).timeout
	print("stop")


func _on_to_left_button_pressed():
	pass # Replace with function body.


func _on_to_center_button_pressed():
	pass # Replace with function body.


func _on_to_right_button_pressed():
	
	pass # Replace with function body.
