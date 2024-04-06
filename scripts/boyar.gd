extends Node2D

@export var amount: int = 3

@onready var DiceHandler = $DiceHandler
@onready var UiHandler = $Control

var turn: bool = false
var PlayerArray: Array = []
var NpcArray: Array = []
var bet: int

func _ready() -> void:
	bet = SaveData.bet
	DiceHandler.array_ready.connect(arrays_final_set)
	DiceHandler.strikes_set.connect(ui_update_strikes)
	DiceHandler.array_found.connect(ui_update_arrays)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func arrays_final_set(value_array):
	turn = not turn
	if(turn):
		PlayerArray = value_array
		print(" ".join(PlayerArray), '\n')
		if(get_points(PlayerArray) == 1 or get_points(PlayerArray) == 6 or get_points(PlayerArray) == 7 or get_points(PlayerArray) == 12):
			NpcArray = [0, 0, 0]
			arrays_process()
		else:
			await get_tree().create_timer(1).timeout
			DiceHandler.roll_dices(amount)
	else: 
		NpcArray = value_array
		print(" ".join(NpcArray), '\n')
		arrays_process()

func arrays_process():
	var PlayerPoints: int = get_points(PlayerArray)
	var NpcPoints: int = get_points(NpcArray)
	var mult: int = 1
	if(PlayerArray == [1, 2, 3] or PlayerPoints == 1 or NpcArray == [4, 5, 6]):
		mult = 0
	elif(PlayerArray == [4, 5, 6] or PlayerPoints == 6 or NpcArray == [1, 2, 3]):
		mult = 2
	elif(PlayerPoints > NpcPoints):
		if(PlayerPoints > 6):
			if(PlayerPoints == 12):
				mult = 6
			else: 
				mult = 4
		else:
			mult = 2
	elif(PlayerPoints < NpcPoints):
		if(NpcPoints > 6):
			if(NpcPoints == 12):
				mult = -4
			else: 
				mult = -2
		else:
			mult = 0
	SaveData.gain_lose(mult, bet)
	SaveData.save_save()
	UiHandler.update_chips()
	UiHandler.ui_win_condition(mult)
	UiHandler.bet_edit_change(true)
	UiHandler.disable_roll_button(false)

func get_points(array: Array) -> int:
	if(array[0] == array[1]):
		if(array[0] == array[2]):
			return array[2]+6
		else:
			return array[2]
	elif(array[1] == array[2]):
		if(array[0] == array[1]):
			return array[0]+6
		else:
			return array[0]
	else: return 0

func _on_roll_button_button_down():
	UiHandler.bet_edit_change(false)
	SaveData.gain_lose(-1, bet)
	SaveData.save_save()
	UiHandler.update_chips()
	UiHandler.disable_roll_button(true)
	$Control/WCLabel.hide()
	UiHandler.UIchange([], turn)
	UiHandler.UIchange([], not turn)
	DiceHandler.roll_dices(amount)
	
func ui_update_strikes(strikes: int):
	UiHandler.ui_strike_update(strikes, turn)

func ui_update_arrays(array: Array):
	UiHandler.UIchange(array, turn)

func _on_spin_box_value_changed(value):
	bet = value 
	SaveData.bet = value
	print(value)
