extends Node

@export var amount: int = 3
var cnt: int = 0
var value_array: Array = []
var strikes: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		child.dice_finished.connect(dice_counter)

signal array_ready(value: Array)
signal strikes_set(strikes: int)
signal array_found(value: Array)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func roll_dices(value: int):
	strikes = value
	strikes_set.emit(strikes)
	cnt = 0
	value_array = []
	for child in get_children():
		child.dice_roll()
	
func dice_counter():
	cnt += 1
	if(cnt >= amount):
		for child in get_children():
			value_array.push_back(child.final)
		value_array.sort()
		array_found.emit(value_array)
		var ok: bool = 0
		for i in range(0, amount-1):
			if(value_array[i]==value_array[i+1]):
				ok = 1
		if(value_array == [1, 2, 3] or value_array == [4, 5 , 6]):
			ok = 1
		if(ok):
			array_ready.emit(value_array)
		else:
			if(strikes > 1):
				await get_tree().create_timer(1).timeout
				roll_dices(strikes - 1)
				
			else:
				array_ready.emit(value_array)
	
