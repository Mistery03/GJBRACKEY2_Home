extends Node

@export var player:Player
@export var stoneWalk:AudioStreamPlayer2D
@export var walk_timer:Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.localTilemap:
		var playerPos = player.localTilemap.local_to_map(player.position)
		var floorData:TileData = player.localTilemap.get_cell_tile_data(playerPos)
		
		if floorData:
			if player.direction:
				if floorData.get_custom_data("type") == "stone":
					if walk_timer.time_left <=0:
						stoneWalk.pitch_scale = randf_range(0.8,1.2)
						stoneWalk.play()
						walk_timer.start(0.5)
			else:
				stoneWalk.stop()
				
