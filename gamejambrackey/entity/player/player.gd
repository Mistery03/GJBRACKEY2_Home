class_name Player
extends Entity

@export var localTilemap:TileMapLayer
var direction

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())

func _physics_process(delta: float) -> void:
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left","right","forward","backward")
	if direction:
		velocity = direction* movementSpeed
		animation.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, movementSpeed)
		velocity.y = move_toward(velocity.y, 0, movementSpeed)
		animation.play("idle")

	move_and_slide()
