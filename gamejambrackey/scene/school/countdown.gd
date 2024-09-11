extends Label

@export var countdown:Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	countdown.start()

func timeLeftInTimer():
	var timeLeft = countdown.time_left
	var minute = floor(timeLeft/60)
	var second = int(timeLeft)%60
	return[minute,second]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "%02d:%02d" % timeLeftInTimer()
