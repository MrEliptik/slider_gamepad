@tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("HSliderGamepad", "HSlider", \
		preload("res://addons/slidergamepad/hslider_gamepad.gd"), \
		preload("res://addons/slidergamepad/hslider_gamepad.svg"))
	add_custom_type("VSliderGamepad", "VSlider", \
		preload("res://addons/slidergamepad/vslider_gamepad.gd"), \
		preload("res://addons/slidergamepad/vslider_gamepad.svg"))

func _exit_tree():
	# Clean-up of the plugin goes here.
	remove_custom_type("HSliderGamepad")
	remove_custom_type("VSliderGamepad")
