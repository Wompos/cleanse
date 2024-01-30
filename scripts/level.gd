extends Node2D

func _ready():
	#$TileMap.set_layer_enabled(1, false)
	pass

# https://docs.godotengine.org/en/stable/classes/class_tilemap.html

func _physics_process(delta):
	if Input.is_action_just_pressed("Interact"):
		print("wololo")
		var tileset = $TileMap.tile_set.get_source_id(0)
		
		# all tiles in the world between -12 and 12 in both axes
		for x in range(-12, 13):
			for y in range(-12, 13):
				# get tile coordinates on the texture atlas (which tile is it?)
				# Note: (-1, -1) means empty. Source: printing values
				var current_tile = $TileMap.get_cell_atlas_coords(0, Vector2i(x, y))
				
				# Stone section is between (6,12) and (11,14)
				# (including the two empty spots on the tile set)
				if current_tile.x >= 6 and current_tile.x <= 11:
					if current_tile.y >= 12 and current_tile.y <= 14:
						# Grass tiles are 12 tile spaces above stone on the texture atlas
						$TileMap.set_cell(0, Vector2i(x, y), tileset, current_tile - Vector2i(0, 12))
