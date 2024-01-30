extends Node2D

func _ready():
	$Pylon1.set_tilemap($TileMap)
	$Pylon2.set_tilemap($TileMap)
