extends Node2D
	
func rotate_scales_clockwise(angle : float) -> void:
	var new_angle : float 
	while(angle > $Scale.rotation):
		print($Scale.rotation)
		new_angle = lerp($Scale.rotation, angle, 0.05)
		$Scale.rotation = new_angle
		get_node("Scale/LeftPlate").rotation = -new_angle
		get_node("Scale/RightPlate").rotation = -new_angle
		await get_tree().create_timer(0.01).timeout
		if(new_angle >= angle - 0.005):
			$Scale.rotation = angle
	print("end")
		

func rotate_scales_counterclockwise(angle : float) -> void:
	var new_angle : float 
	while(angle < $Scale.rotation):
		new_angle = lerp($Scale.rotation, angle, 0.05)
		$Scale.rotation = new_angle
		get_node("Scale/LeftPlate").rotation = -new_angle
		get_node("Scale/RightPlate").rotation = -new_angle
		await get_tree().create_timer(0.01).timeout

func rotate_scales(angle : float) -> void:
	if angle > $Scale.rotation:
		rotate_scales_clockwise(angle)
	elif angle < $Scale.rotation:
		rotate_scales_counterclockwise(angle)
	else:
		pass

func _on_to_left_button_pressed():
	rotate_scales(-0.5)


func _on_to_center_button_pressed():
	rotate_scales(0)


func _on_to_right_button_pressed():
	rotate_scales(0.5)
	
	pass # Replace with function body.
