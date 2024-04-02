extends Node2D

@onready var RollButton = $Control/RollButton

@onready var PlayerLabel = $Control/PlayerLabel
@onready var NpcLabel = $Control/NpcLabel
@onready var TurnLabel = $Control/TurnLabel

@onready var dice1 = $Dice
@onready var dice2 = $Dice2
@onready var dice3 = $Dice3

var PlayerArray = []
var NpcArray = []
var turn: bool = false
var cnt: int = 0
var can_press = true

func _ready() -> void:
	dice1.connect("dice_finished", roll_wait)
	dice2.connect("dice_finished", roll_wait)
	dice3.connect("dice_finished", roll_wait)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func roll_wait() -> void:
	cnt +=1
	if(cnt>=3):
		if(turn == false):
			get_array(PlayerArray)
			cnt = 0
			await get_tree().create_timer(1.5).timeout
			TurnLabel.text = "NPC"
			turn = true
			roll_dices()
		else:
			get_array(NpcArray)
			RollButton.disabled = false

func get_array(array):
	array = [dice1.final, dice2.final, dice3.final]
	array.sort()
	set_dice_label(array)

func set_dice_label(array) -> void:
	if(turn == false):
		PlayerLabel.text = " ".join(array)
	else:
		NpcLabel.text = " ".join(array)
 
func roll_dices():
	cnt = 0
	dice1.dice_roll()
	dice2.dice_roll()
	dice3.dice_roll()

func _on_roll_button_button_down():
	RollButton.disabled = true
	turn = false
	TurnLabel.text = "You"
	NpcArray = []
	PlayerArray = []
	PlayerLabel.text = ""
	NpcLabel.text = ""
	roll_dices()
