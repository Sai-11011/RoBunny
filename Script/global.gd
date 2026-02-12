extends Node

var score:int = 0
const max_brightness=0.6
var neon := Color.WHITE

const SAVE_FILE = "user://highscore.save"

const SECURITY_KEY = "Rabbit_Neon_Galaxy_1919_X" 

func _ready():
	load_score()

func save_score():
	var file = FileAccess.open_encrypted_with_pass(SAVE_FILE, FileAccess.WRITE, SECURITY_KEY)
	
	if file == null:
		print("Error: Could not save encrypted file!")
		return
		
	file.store_32(score)

func load_score():
	if FileAccess.file_exists(SAVE_FILE):
		# We must use the SAME key to open it
		var file = FileAccess.open_encrypted_with_pass(SAVE_FILE, FileAccess.READ, SECURITY_KEY)
		
		if file == null:
			print("Error: Save file is corrupted or password changed.")
			score = 0
			return
			
		score = file.get_32()
	else:
		score = 0
