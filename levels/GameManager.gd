extends Node
#Save path for game variables
var save_path = "res://variable.save"

#Game control tips variables
var is_paused: bool = false
var all_controls: int = 0

func _ready():
	# Loading control tips data if exist
	load_data()

func _process(_delta):
	#Teaching moving controls
	if all_controls == 0:
		if $"../Character".is_on_floor():
			if !Input.is_action_pressed("right"):
				get_tree().paused = true
			else: 
				get_tree().paused = false
				all_controls += 1
				%LabelForRightControl.hide()
				%ArrowRight.hide()
	else:
			%LabelForRightControl.hide()
			%ArrowRight.hide()	
	
	
	if all_controls == 1:
		if %Character.position.x > 600:
			%LabelForLeftControl.show()
			%ArrowLeft.show()
			if !Input.is_action_pressed("left"):
				get_tree().paused = true
			else: 
				get_tree().paused = false
				all_controls += 1
				%LabelForLeftControl.hide()
				%ArrowLeft.hide()
	
			
	if all_controls == 2 :
		if %Character.position.x < 500:
			%LabelForUpControl.show()
			%ArrowUp.show()
			if !Input.is_action_pressed("jump"):
				get_tree().paused = true
			else: 
				get_tree().paused = false
				all_controls += 1
				%LabelForUpControl.hide()
				%ArrowUp.hide()
		
	if all_controls == 3:
		if %Character.position.x > 500:
			%LabelForCoinsCounter.show()
			%RectangleForCoins.show()			
			get_tree().paused = true
			if Input.is_action_just_pressed("pause"): 
				get_tree().paused = false
				all_controls += 1
				%LabelForCoinsCounter.hide()
				%RectangleForCoins.hide()
	
	if all_controls == 4:
		if %Character.position.x > 550:
			%LabelForLivesCounter.show()
			%RectangleForLives.show()
			if !Input.is_action_pressed("pause"):
				get_tree().paused = true
			else: 
				get_tree().paused = false
				all_controls += 1
				%LabelForLivesCounter.hide()
				%RectangleForLives.hide()

	if all_controls == 5:
		if %Character.position.x > 2100:
			%LabelForCoinsIntro.show()
			%RectangleForCoinsIntro.show()
			if !Input.is_action_pressed("pause"):
				get_tree().paused = true
			else: 
				get_tree().paused = false
				all_controls += 1
				%LabelForCoinsIntro.hide()
				%RectangleForCoinsIntro.hide()

	if all_controls == 6:
		if %Character.position.x > 2800:
			%LabelForEnemyIntro.show()
			%RectangleForEnemyIntro.show()
			if !Input.is_action_pressed("pause"):
				get_tree().paused = true
			else: 
				get_tree().paused = false
				all_controls += 1
				save_data(all_controls)
				%LabelForEnemyIntro.hide()
				%RectangleForEnemyIntro.hide()

func pause_game():
	if Input.is_action_just_pressed("pause"):
		if is_paused:
			get_tree().paused = false
			is_paused = false
			return false
		else:
			get_tree().paused = true
			is_paused = true
			return true

func save_data(data):
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(data)
	
func load_data():
	if FileAccess.file_exists(save_path):
		var _file = FileAccess.open(save_path, FileAccess.READ)
		all_controls = 7
	else:
		print("no data")
