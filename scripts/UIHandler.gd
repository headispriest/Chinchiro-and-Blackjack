extends Control

var turn_state: Array = ["You", "NPC"]

@onready var RollButton = $RollButton
@onready var BetBox = $SpinBox

# Called when the node enters the scene tree for the first time.
func _ready():
	update_chips()
	BetBox.max_value = SaveData.chips/5
	BetBox.value = SaveData.bet
	$TurnLabel.text = "You"
	$StrikesLabel.text = "3"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
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
	if(wc < 1):
		$WCLabel.text = "You Lost! "+str(wc)+"x"
	elif(wc > 1):
		$WCLabel.text = "You Won! "+str(wc)+"x"
	else:
		$WCLabel.text = "Draw!"
	BetBox.max_value = SaveData.chips
	$WCLabel.show()
	
func bet_edit_change(vlaue: bool):
	BetBox.editable = vlaue

func disable_roll_button(value: bool):
	RollButton.disabled = value
	
func update_chips():
	$Chips.text = str(SaveData.chips)
	
func get_bet() -> int:
	return BetBox.value

