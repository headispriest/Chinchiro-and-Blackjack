extends Node

# Saving *data*
var chips: int = 10000
var bet: int = 10

# Saving information
var password: String = "open sesame"
var save_path: String = "user://save.ceelo"

func _ready():
	load_save()

func gain_lose(mult: int, bet_value: int):
	chips = chips + (mult*bet_value)
	
func save_save():
	var config = ConfigFile.new()
	
	config.set_value("Data", "Chips", chips)
	config.set_value("Data", "Bet", bet)
	config.save(save_path)
	
func load_save():
	var config = ConfigFile.new()
	
	var err = config.load(save_path)
	
	if err != OK:
		print(err)
		return
	
	chips = config.get_value("Data", "Chips", 10000)
	bet = config.get_value("Data", "Bet", 10)
