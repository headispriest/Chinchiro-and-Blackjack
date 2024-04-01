extends Label

var face1: int
var face2: int
var face3: int

var ok1: bool
var ok2: bool
var ok3: bool

var arr 

# Called when the node enters the scene tree for the first time.
func _ready():
	ok1 = 0
	ok2 = 0
	ok3 = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(ok1 and ok2 and ok3):
		arr = [face1, face2, face3]
		arr.sort()
		text = " ". join(arr)


func _on_dice_dice_finished(face):
	ok1 = 1
	face1 = face


func _on_dice_2_dice_finished(face):
	ok2 = 1
	face2 = face


func _on_dice_3_dice_finished(face):
	ok3 = 1
	face3 = face
