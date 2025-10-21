extends Node
'''
func _ready():
	randomize()  # ensure new random numbers each run

	var cube = []  # 3x3x3 array
	var true_count = 0  # number of 1s

	# Generate the 3x3x3 array
	for x in range(3):
		var layer = []
		for y in range(3):
			var row = []
			for z in range(3):
				var value = randi() % 2  # random 0 or 1
				row.append(value)

				# Count how many are 1 (true)
				if value == 1:
					true_count += 1
			layer.append(row)
		cube.append(layer)

	# Print the full cube
	print("3x3x3 Random Cube:")
	for layer in cube:
		print(layer)

	# Print how many 1s (true values) exist
	print("Total number of 1s (true): ", true_count)
'''
