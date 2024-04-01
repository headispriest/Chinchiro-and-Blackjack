extends Sprite2D

var face = 0

func _ready():
	frame = face

func _process(delta):
	pass
		
	 
signal dice_finished(face: int)

func dice_roll():
	for i in range(1, 6):
		face = randi_range(0, 5)
		frame = face
		await get_tree().create_timer(log(i/2.5+0.5)).timeout
	print(face+1)
	dice_finished.emit(face+1)


func _on_roll_button_button_down():
	dice_roll()
