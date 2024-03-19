extends Node2D

var selected : bool = false
var rest_point : Vector2 
@onready var rest_node : Node = get_node("../RestNode1")	

var rest_node_position : Vector2

func _ready():
	rest_point = rest_node.global_position
	rest_node_position = rest_node.global_position
	
func _on_area_2d_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("Left Clic"):
		selected = true
		
func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	else:
		global_position = lerp(global_position, rest_point, 10 * delta)
		
	if rest_node_position != rest_node.global_position:
		global_position = rest_node.global_position
		rest_node_position = rest_node.global_position
		rest_point = rest_node.global_position

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false

func _on_area_2d_area_entered(area):
	rest_node = area
	rest_point = area.global_position
