extends Sprite2D

var face = 0
var final

func _ready():
	frame = face

signal dice_finished()

func dice_roll():
	for i in range(1, 6):
		face = randi_range(0, 5)
		frame = face
		await get_tree().create_timer(log(i/2+0.7)+0.5).timeout
	final = face+1
	print(final)
	dice_finished.emit()
