extends Node2D

func _ready():
	#$TileMap.set_layer_enabled(1, false)
	pass

# https://docs.godotengine.org/en/stable/classes/class_tilemap.html

func _physics_process(delta):
	if Input.is_action_just_pressed("Interact"):
		print("wolololo")
		var tileset = $TileMap.tile_set.get_source_id(0)
		var grass_tile = Vector2i(7, 0)  # texture atlas coordinates
		
		for x in range(4):
			for y in range(4):
				$TileMap.set_cell(0, Vector2i(x, y), tileset, grass_tile)
