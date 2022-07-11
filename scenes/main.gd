extends Control


var gift := ""
var death := ""
var state := ""


func _ready() -> void:
	Dialogue.connect("dialogue_finished", self, "on_dialogue_finished")
	Dialogue.connect("chosen", self, "on_chosen")
	switch_to("Intro")
	Dialogue.show_dialogue([
		"[i]It is Christmas Eve. My in-laws are hosting dinner with my wife and the kids.[/i]",
		"[i]My parents died last November. They both got sick. I'm still in shock. So I didn't get any presents for anyone. They'll kill me.[/i]",
		"[i]They left me their memorabilia. Including a time-machine. I could use it to get Christmas presents. My son loves dinosaurs, and the in-laws love rock music. But these were what my parents left me... They're my most precious objects.[/i]",
		"[i]The thing is if I die in the past, I will end up at the party with anything I'm able to pick up. I'll still be alive, but then I won't know how good I did till after the fact.[/i]",
		"[i]Or.... I could go to the mall. I'm a big girl. All I need to do is pick up my car keys.[/i]",
	])


func switch_to(to: String) -> void:
	for child in get_children():
		if to == child.name:
			child.show()
			child.get_node("Music").play()
		else:
			child.hide()
			child.get_node("Music").stop()
			
			
func on_dialogue_finished() -> void:
	if state == "end":
		get_tree().change_scene("res://scenes/title.tscn")
	elif gift == "choco":
		Dialogue.choose()
	elif state == "jurassic":
		$Jurassic/Timer.start()
	elif gift == "t-shirt":
		switch_to("Dinner")
		state = "end"
		Dialogue.show_dialogue([
			"Oh god, my ears. This better be worth it.",
			"Spouse: You won't believe how chaotic it was here. You lucked out.",
			'Mother-in-law: Thank you for the gifts.',
			"Father-in-law: A t-shirt? That's it? ",
			"Son: Cool! Rock music! ",

		])


func _on_RomanHelmet_pressed() -> void:
	switch_to("Roman")
	Dialogue.show_dialogue([
		"[i]The Romans were said to be great traders, even if they struggled with keeping a unified society.[/i]",
		"[i]Maybe I can see if I can find a broken statue or some portable architecture back with me. [/i]",
		"[i]Maybe I can trade some of my jewels and get some Roman coins or jewels.[/i]",
		"Shopkeeper: [i]****** ** ** ***** ***** ***![/i]",
		"[i]... Right. I forgot no one speaks English in this time period. [/i]",
		"[i]I could also stand here and look around for ideas.[/i]"
	])


func _on_RecordPlayer_pressed() -> void:
	switch_to("Concert")
	gift = "t-shirt"
	Dialogue.show_dialogue([
		"There are crowds of people. A rock band is playing on the stage.",
		"[i]My parents were a fan of grunge. Maybe I can find a t-shirt or some merchandise to give to my in-laws.[/i]",
		"Soudwaves play out loudly randomly killing the character. They aren't very fun. No matter what you do, they overwhelm you."
	])


func _on_CarKeys_pressed() -> void:
	switch_to("Mall")
	Dialogue.show_dialogue([
		"[i]I can go to one of three shops: either fancy soaps, LEGOs, or chocolate.[/i]",
		"[i]The kids love chocolate and legos. Their grandparents love the soaps.[/i]"
	])


func _on_Tooth_pressed() -> void:
	switch_to("Jurassic")
	state = "jurassic"
	Dialogue.show_dialogue([
		"[i]Ah Jurassic, the period mentioned in the dinosaur movies.[/i]",
		"[i]I can either try to find a fossil, collect some tar, or get a photo of a creature that seems to be really rare. Or I can stay in one place and decide what to do.[/i]"
	])

func _on_Choco_pressed() -> void:
	gift = "choco"
	Dialogue.show_dialogue([
		"Chocolate clerk: Free sample?"
	])


func on_chosen(yes: bool) -> void:
	if yes:
		death = "poison"
		mall_dinner()
	else:
		death = "crowd"
		mall_dinner()
	
	
func mall_dinner() -> void:
	switch_to("Dinner")
	var lines := []
	if death == "crowd":
		lines.append("You were trampled to death by the mall crowd.")
	else:
		lines.append("You died from eating poisonous chocolate.")
	lines.append("HOW DID I DIE? I didn't use the machine!")
	lines.append("Spouse: You're a brave woman, going to the mall.")
	lines.append("Mother-in-law: Thank you for the gifts.")
	if gift == "soap":
		lines.append("Father-in-law: It's nice you finally remember what we like. ")
		lines.append("Son: Um, thanks?")
	elif gift == "lego":
		lines.append("Father-in-law: Yay, more toys for me to step on. ")
		lines.append("Son: Cool! I always wanted the castle.")
	else:
		lines.append("Father-in-law: My doctor will blame you if I die from diabetes.")
		lines.append("Son: Can I have some now? Please please please?!")
	lines.append("Wife: Merry Christmas, honey.")
	state = "end"
	Dialogue.show_dialogue(lines)


func _on_Soap_pressed() -> void:
	death = "crowd"
	mall_dinner()


func _on_Lego_pressed() -> void:
	death = "crowd"
	mall_dinner()


func _on_Timer_timeout() -> void:
	gift = "footprint"
	jurassic_dinner()


func jurassic_dinner() -> void:
	switch_to("Dinner")
	var lines := []
	if gift == "footprint":
		lines.append("You were stomped on by a bachiosaurus.")
	elif gift == "jar":
		lines.append("You fell into a tar pit while gathering some cool tar and fossils possibly, like an egg.")
	elif gift == "all_tooth":
		lines.append("The allosaurus is a dick and decides to eat you.")
	else:
		lines.append("You walk into a crocodile's mouth while looking for teeth.")
	lines.append("[i]So that's why Dad never liked going to the age of reptiles.[/i]")
	lines.append("Spouse: You okay, hon? I don't like you being alone in your parents' house.")
	lines.append("Mother-in-law: Thank you for the gifts.")
	if gift == "footprint":
		lines.append("Father-in-law: You can tell this was made on a three-dimensional printer. ")
		lines.append("Son: Oh wow, this is bigger than my foot!")
	elif gift == "jar":
		lines.append("Father-in-law: Must be one of those glitter jars. You didn't do a good job of making it.")
		lines.append("Son: Hmm, I can probably add glitter to this.")
	elif gift == "all_tooth":
		lines.append("Father-in-law: Is this some junk your father kept?")
		lines.append("Son: Can I make this into a necklace?")
	else:
		lines.append("Father-in-law: You better not have got that from an alligator farm.")
		lines.append("Son: How many teeth do these crocs have?")
	state = "end"
	Dialogue.show_dialogue(lines)


func _on_Jar_pressed() -> void:
	gift = "jar"
	jurassic_dinner()


func _on_Allosaurus_pressed() -> void:
	gift = "all_tooth"
	jurassic_dinner()


func _on_Crocodile_pressed() -> void:
	gift = "croc"
	jurassic_dinner()


func _on_Shopkeeper_pressed() -> void:
	gift = "coins"
	roman_dinner()


func roman_dinner() -> void:
	switch_to("Dinner")
	var lines = []
	lines.append("I guess even the most civilized nations let you die a lot. ")
	lines.append("Spouse: Did you run into a mishap while cleaning? You look frazzled.")
	lines.append("Mother-in-law: Thank you for the presents.")
	if gift == "head":
		lines.append("Father-in-law: Did you steal this from a museum?")
		lines.append("Son: This will go great with my Dark Lord helmet!")
	elif gift == "coins":
		lines.append("Father-in-law: Eh, you overpaid for replicas on eBay.")
		lines.append("Son: Ooh, I can sell these! Thanks, Mom!")
	else:
		lines.append("Father-in-law: Who died? Your parents? Oh wait, they did. ")
		lines.append("Son:  Um, thanks, Mom. ")
	state = "end"
	Dialogue.show_dialogue(lines)


func _on_Rubble_pressed() -> void:
	gift = "head"
	roman_dinner()


func _on_Fire_pressed() -> void:
	gift = "urn"
	roman_dinner()
