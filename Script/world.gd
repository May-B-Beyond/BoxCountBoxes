extends Node3D

@export var cube_scene: PackedScene  # optional if you already have a cube scene
@onready var score_txt:Label = $CanvasLayer/Score
@onready var sfx_level_switching = $sfx_level_switching
@onready var time_spending = $CanvasLayer/TimeSpending



func _ready():
	reset_boxes()
	_create_floor(1, 3)

func reset_boxes():
	
	sfx_level_switching.play()
	for child in get_children():
		if child is RigidBody3D:
			child.queue_free()
			
	randomize()
	

	var true_count = 0
	var grid_size = 3
	var cube_size = 1.0  # cube spacing (tight grid)

	for x in range(grid_size):
		for y in range(grid_size):
			for z in range(grid_size):
				var value = randi() % 2  # random 0 or 1

				if value == 1:
					true_count += 1

					var cube = _create_cube()
					cube.position = Vector3(x * cube_size, y * cube_size + 5, z * cube_size)

					# Lock X, Z movement + all rotation so it only moves vertically
					cube.axis_lock_linear_x = true
					cube.axis_lock_linear_z = true
					cube.axis_lock_angular_x = true
					cube.axis_lock_angular_y = true
					cube.axis_lock_angular_z = true

					add_child(cube)

	print("Spawned vertical cubes:", true_count)
	Globals.Box_Count = true_count
	_create_floor(grid_size, cube_size)

	
func _create_cube() -> RigidBody3D:
	# Create cube (RigidBody3D)
	var body = RigidBody3D.new()
	body.mass = 1.0
	body.gravity_scale = 1.0

	# Add mesh
	var mesh_instance = MeshInstance3D.new()
	var mesh = BoxMesh.new()
	mesh.size = Vector3(1, 1, 1)
	mesh_instance.mesh = mesh

	# Random color
	var mat = StandardMaterial3D.new()
	var hue = 0.11 + randf() * 0.06   # 0.11–0.17 → stays in yellow zone
	var sat = 0.6 + randf() * 0.4     # 0.6–1.0 → some pale, some rich
	var val = 0.6 + randf() * 0.4     # 0.6–1.0 → dark gold to bright yellow
	mat.albedo_color = Color.from_hsv(hue, sat, val)
	mesh_instance.material_override = mat
	body.add_child(mesh_instance)

	# Add collision
	var collider = CollisionShape3D.new()
	var shape = BoxShape3D.new()
	collider.shape = shape
	body.add_child(collider)
	
	return body


func _create_floor(size: int, spacing: float):
	var floor = StaticBody3D.new()

	var mesh_instance = MeshInstance3D.new()
	var mesh = BoxMesh.new()
	mesh.size = Vector3(size * spacing, 0.5, size * spacing)
	mesh_instance.mesh = mesh

	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color.DARK_GRAY
	mesh_instance.material_override = mat
	floor.add_child(mesh_instance)

	var collider = CollisionShape3D.new()
	var shape = BoxShape3D.new()
	shape.size = Vector3(size * spacing, 0.5, size * spacing)
	collider.shape = shape
	floor.add_child(collider)
	
	floor.visible = false

	floor.position = Vector3((size - 1) * spacing / 2, -0.5, (size - 1) * spacing / 2)
	add_child(floor)



func _process(delta):
	
	if Globals.reset_box:
		score_txt.text = "Score : " + str(Globals.Score) +"\nAvr Time : "+String.num((Globals.Averagetimetook),2)+"s"
		reset_boxes()
		Globals.reset_box = false
	



