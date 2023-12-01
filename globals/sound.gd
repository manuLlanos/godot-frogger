extends Node2D

# audio singleton for level sounds

var dict: Dictionary

func _ready():
	for sound: AudioStreamPlayer in get_children():
		dict[sound.name] = sound

func play(sound: String):
	dict[sound].play()
