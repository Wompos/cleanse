class_name Interactable extends Node2D

@export var interact_label = "None"
@export var interact_type = "Pylon"
@export var interact_value = "None"

@export var spread_range = 20

# https://docs.godotengine.org/en/stable/classes/class_tilemap.html

var tilemap: TileMap = null

func set_tilemap(new_tilemap: TileMap):
	tilemap = new_tilemap

# see player script, execute_interactions
func interact():
	if tilemap == null:
		print("This pylon is sad as you have not given it a tile map")
	else:
		print("wololo")
		$wololo.play()
		var tileset = tilemap.tile_set.get_source_id(0)
		var center_position = tilemap.local_to_map(self.global_position)
		print(center_position)
		
		# all tiles in the world between -12 and 12 in both axes
		for dx in range(-self.spread_range, self.spread_range + 1):
			for dy in range(-self.spread_range, self.spread_range + 1):
				var delta_position = Vector2i(dx, dy)
				
				# circle
				# squared distance checks are actually slightly faster but this is not performance critical so i dont care
				if delta_position.length() <= self.spread_range:
					# get tile coordinates on the texture atlas (which tile is it?)
					# Note: (-1, -1) means empty. Source: printing values
					var current_tile = tilemap.get_cell_atlas_coords(0, delta_position + center_position)
					
					# Stone section is between (6,12) and (11,14)
					# (including the two empty spots on the tile set)
					if current_tile.x >= 6 and current_tile.x <= 11:
						if current_tile.y >= 12 and current_tile.y <= 14:
							# Grass tiles are 12 tile spaces above stone on the texture atlas
							tilemap.set_cell(0, delta_position + center_position, tileset, current_tile - Vector2i(0, 12))
