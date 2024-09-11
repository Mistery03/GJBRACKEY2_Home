extends TextureProgressBar

@export var anxietyRate:float = 0.01

@export_category("SFX settings")
@export var breathing:AudioStreamPlayer2D
@export var breathIn:AudioStreamPlayer2D
@export var heartbeat:AudioStreamPlayer2D
@export var breathOut:AudioStreamPlayer2D

var originalVolume:float

var holdingBreath:bool = false
var isPlayed:bool = false

func _ready() -> void:
	originalVolume = breathing.volume_db
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	value += anxietyRate

	value = clampf(value,0,max_value)
	
	adjustBreathingNoise(value)
	adjustHeartBeatNoise(value)
	
	if holdingBreath and !isPlayed:
		breathIn.play()
		isPlayed = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("holdBreath"):
		holdingBreath = true
			
	if event.is_action("holdBreath"):
		breathing.stop()
		
		if breathIn.finished:
			heartbeat.volume_db = -5
		value -= 0.1
		adjustBreathingNoise(value)
		
	if event.is_action_released("holdBreath"):
		if breathIn.finished:
			breathOut.play()
			breathing.play()
		holdingBreath = false	
		isPlayed = false

func adjustBreathingNoise(percentage:float):
	var newVolume = originalVolume + (percentage/100 * 30) 
	breathing.volume_db = newVolume
	breathing.volume_db = clamp(breathing.volume_db,originalVolume,20)

func adjustHeartBeatNoise(percentage:float):
	var min_volume_db = -80  # Low volume for fade-out
	var max_volume_db = -10  # Max volume for fade-in
	if percentage >= 45:
		heartbeat.volume_db = max_volume_db
	elif percentage < 45:
		heartbeat.volume_db = min_volume_db + (percentage / 45.0) * (max_volume_db - min_volume_db)
