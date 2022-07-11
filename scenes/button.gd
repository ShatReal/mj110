extends TextureButton



func _ready() -> void:
	connect("mouse_entered", self, "on_mouse_entered")
	connect("mouse_exited", self, "on_mouse_exited")
	

func on_mouse_entered() -> void:
	modulate = Color(1.5, 1.5, 1.5, 1.0)
	

func on_mouse_exited() -> void:
	modulate = Color(1.0, 1.0, 1.0, 1.0)
