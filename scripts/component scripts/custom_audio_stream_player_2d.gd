extends AudioStreamPlayer2D

class_name CustomAudioStreamPlayer2D

func load_stream(path : String):
	stop()
	var sound = load(path)
	stream = sound

func reset():
	stop()
	pitch_scale = 1
