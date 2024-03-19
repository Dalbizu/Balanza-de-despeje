extends Node2D

@onready var crossbar : Sprite2D = get_node("Crossbar/Sprite2D")
@onready var left_plate : Node2D = get_node("LeftPlate")
@onready var right_plate : Node2D = get_node("RightPlate")

var left_plate_displacement : float = 3*PI/2
var right_plate_displacement : float = PI/2
var crossbar_size : float = 4
var positive_crossbar : float = 4
var negative_crossbar : float = -4
var _delta : float
var is_rotating : bool = false
var correction_value : float = 1

var target_rotation : float
var move_to_right : bool
var move_to_center : bool
var move_to_left : bool

var left_entered: bool = false

func _process(delta):
	_delta = delta
	if left_entered and Input.is_action_just_released("Left Clic"):
		move_scale_to_left()
		
func move() -> void:
	while(should_rotate()):
		await get_tree().create_timer(0.001).timeout
		crossbar.rotate(_delta * correction_value)
		move_left_plate()
		move_right_plate()
	move_to_right = false
	move_to_left = false
	if(target_rotation == 0):
		crossbar.rotation = 0
		

func move_left_plate() -> void:
	left_plate_displacement = left_plate_displacement + _delta * correction_value
	left_plate.position = (left_plate.position +
	Vector2(cos(left_plate_displacement), sin(left_plate_displacement)* crossbar_size))
	
func move_right_plate() -> void:
	right_plate_displacement = right_plate_displacement + _delta * correction_value
	right_plate.position = (right_plate.position + 
	Vector2(cos(right_plate_displacement), sin(right_plate_displacement)* crossbar_size)) 

func _on_light_right_button_down():
	move_to_right = true
	target_rotation = PI / 10
	crossbar_size = positive_crossbar
	correction_value = 1
	move()
	
func move_scale_to_left():
	move_to_left = true
	target_rotation = - PI / 10
	crossbar_size = negative_crossbar
	correction_value = -1
	move()

func _on_center_button_down():
	target_rotation = 0
	if(crossbar.rotation >= PI / 10):
		move_to_left = true
		crossbar_size = negative_crossbar
		correction_value = -1
	else:
		move_to_right = true
		crossbar_size = positive_crossbar
		correction_value = 1
	move()
	
func should_rotate() -> bool:
	if(move_to_right and crossbar.rotation < target_rotation):
		return true
	elif(move_to_left and crossbar.rotation > target_rotation): 
		return true
	return false


func _on_left_area_area_entered(_area):
	left_entered = true

