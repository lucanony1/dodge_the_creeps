extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	$Message.text = "Dodge the Creeps!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)	

func _on_start_button_pressed():
	$StartButton.hide()
	$TitleLabel.hide()
	$LeaderBoardLabel.hide()
	start_game.emit()

func _on_message_timer_timeout():
	$Message.hide()
	
func show_leader_board(score_list, new_score = 0):
	var high_score = score_list[-1] if len(score_list) > 0 else 0 
	var second_score = score_list[-2] if len(score_list) > 1 else 0
	var third_score = score_list[-3] if len(score_list) > 2 else 0
	
	var final_display = ""
	final_display +="1rst " + str(high_score) + "\n"
	final_display +="2nd " + str(second_score) + "\n"
	final_display +="3rd " + str(third_score) + "\n"
	var is_highscore = (high_score == new_score)
	if is_highscore:
		$TitleLabel.text = "¡NEW HIGHSCORE!"
	else:
		$TitleLabel.text = "LEADERBOARD"
	$TitleLabel.show()
	$LeaderBoardLabel.text = final_display
	$LeaderBoardLabel.show()
	
