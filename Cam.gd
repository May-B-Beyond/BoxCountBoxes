extends Node3D
'''
var cams: Array[Camera3D] = []
var current_index: int = 0

func _ready() -> void:
	cams.clear()
	var nodes = get_tree().get_nodes_in_group("cams")
	for n in nodes:
		if n is Camera3D:
			cams.append(n)
	if cams.size() == 0:
		push_warning("No cameras in group 'cams' found")
	update_camera()

func update_camera() -> void:
	for i in range(cams.size()):
		cams[i].current = (i == current_index)

func _on_button_pressed() -> void:
	print("cam_change")
	if cams.size() == 0: return
	current_index = (current_index + 1) % cams.size()
	update_camera()
'''
@onready var camera_1 = $Camera3D
@onready var camera_2 = $Camera3D2
@onready var camera_3 = $Camera3D3
@onready var statetxxt = $View_State_txt

var state = 1

func _ready():
	# Make Camera1 the initial current camera
	var my_button = $"Camera Change"
	camera_1.current = true
	camera_2.current = false
	camera_3.current = false
	
func updateCam():
	if (state == 0):
		statetxxt.text = "Top "
		camera_1.current = false
		camera_2.current = true
		camera_3.current = false
	if state == 1:
		statetxxt.text = "Front"
		camera_2.current = false
		camera_1.current = true
		camera_3.current = false
	if state == 2:
		statetxxt.text = "Side"
		camera_2.current = false
		camera_1.current = false
		camera_3.current = true
	
func _input(event):
	if event.is_action_pressed("switch_camera"): # Define "switch_camera" in Project Settings -> Input Map
		state = (state+1)%3
		updateCam()
