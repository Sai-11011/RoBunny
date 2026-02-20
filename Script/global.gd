extends Node

var score:int = 0
const max_brightness=0.6
var neon := Color.WHITE
var instant_restart = false

var sound_on : bool = true
var music_on : bool = true

const SAVE_FILE = "user://savegame.dat"
const SECURITY_KEY = "Rabbit_Neon_Galaxy_1919_X" 

func _ready():
	load_data()

func save_data():
	var file = FileAccess.open_encrypted_with_pass(SAVE_FILE, FileAccess.WRITE, SECURITY_KEY)
	if file == null:
		print("Save Error!")
		return
	
	var data = {
		"highscore": score,
		"sound": sound_on,
		"music": music_on
	}
	
	file.store_var(data)

func load_data():
	if not FileAccess.file_exists(SAVE_FILE):
		return
	var file = FileAccess.open_encrypted_with_pass(SAVE_FILE, FileAccess.READ, SECURITY_KEY)
	if file == null:
		return
		
	# Get the dictionary back
	var data = file.get_var()
	
	# Update our variables (with safety checks in case file is old)
	if "highscore" in data: score = data["highscore"]
	if "sound" in data: sound_on = data["sound"]
	if "music" in data: music_on = data["music"]
