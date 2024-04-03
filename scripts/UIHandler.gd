extends Control

var turn_state: Array = ["You", "NPC"]

# Called when the node enters the scene tree for the first time.
func _ready():
	$TurnLabel.text = "You"
	$StrikesLabel.text = "3"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func UIchange(array: Array, turn: bool):
	if(not turn):
		$PlayerLabel.text = " ".join(array)
	else:
		$NpcLabel.text = " ".join(array)

func ui_strike_update(strikes: int, turn: bool):
	$StrikesLabel.text = str(strikes)
	$TurnLabel.text = turn_state[int(turn)]

func ui_win_condition(wc: int):
	if(wc < 0):
		$WCLabel.text = "You Lost! "+str(wc)+"x"
	elif(wc > 0):
		$WCLabel.text = "You Won! "+str(wc)+"x"
	else:
		$WCLabel.text = "Draw!"
	$WCLabel.show()
