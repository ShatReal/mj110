extends CanvasLayer


signal dialogue_finished
signal chosen(yes)

var lines := []
var current := -1


func _ready() -> void:
	$Text.hide()
	set_process_input(false)
	$Choice.hide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		if $Timer.is_stopped():
			advance()
		else:
			$Timer.stop()
			$Text.percent_visible = 1.0
		get_tree().set_input_as_handled()
			

func show_dialogue(l: Array) -> void:
	$Text.show()
	set_process_input(true)
	lines = l
	current = -1
	advance()


func advance() -> void:
	current += 1
	if current >= lines.size():
		set_process_input(false)
		$Text.hide()
		emit_signal("dialogue_finished")
		return
	$Text.bbcode_text = "[center]%s[/center]" % lines[current]
	$Text.visible_characters = 0
	$Timer.start()


func _on_Timer_timeout() -> void:
	$Text.visible_characters += 1
	if not $Text.percent_visible == 1.0:
		$Timer.start()


func choose() -> void:
	$Choice.show()


func _on_Yes_pressed() -> void:
	$Choice.hide()
	emit_signal("chosen", true)


func _on_No_pressed() -> void:
	$Choice.hide()
	emit_signal("chosen", false)
