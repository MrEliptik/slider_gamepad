@tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("SliderGamepad", "HSlider", preload("res://addons/slidergamepad/slider_gamepad.gd"), preload("res://icon.svg"))

func _exit_tree():
	# Clean-up of the plugin goes here.
	remove_custom_type("SliderGamepad")
