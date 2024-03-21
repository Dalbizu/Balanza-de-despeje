extends Node2D

var rotating : bool = false
@onready var left_plate : Node2D = get_node("Scale/LeftPlate")
@onready var right_plate : Node2D = get_node("Scale/RightPlate")

func rotate_scales(angle : float) -> void:
	if angle >= $Scale.rotation:
		rotate_scales_clockwise(angle)
	elif angle <= $Scale.rotation:
		rotate_scales_counterclockwise(angle)
	else:
		pass
		
func set_angle(angle : float) -> void:
	$Scale.rotation = angle
	get_node("Scale/LeftPlate").rotation = -angle
	get_node("Scale/RightPlate").rotation = -angle
	
func rotate_scales_clockwise(angle : float) -> void:
	var new_angle : float 
	while(angle > $Scale.rotation):
		new_angle = lerp($Scale.rotation, angle, 0.05)
		set_angle(new_angle)
		await get_tree().create_timer(0.01).timeout
		if(new_angle >= angle - 0.005):
			set_angle(angle)
			rotating = false
		
func rotate_scales_counterclockwise(angle : float) -> void:
	var new_angle : float 
	while(angle < $Scale.rotation):
		new_angle = lerp($Scale.rotation, angle, 0.05)
		set_angle(new_angle)
		await get_tree().create_timer(0.01).timeout
		if(new_angle <= angle + 0.005):
			set_angle(angle)
			rotating = false

func _on_to_left_button_pressed():
	if $Scale.rotation != -0.5 and not rotating:
		rotate_scales(-0.5)
		rotating = true

func _on_to_center_button_pressed():
	if $Scale.rotation != 0 and not rotating:
		rotate_scales(0)
		rotating = true

func _on_to_right_button_pressed():
	if $Scale.rotation != 0.5 and not rotating:
		rotate_scales(0.5)
		rotating = true

