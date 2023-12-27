extends AudioStreamPlayer2D

func _ready():
	# Set the stream to your music file.
	stream = load("res://audio/ArdinAudio2.wav")
	# Start playing the music.
	play()
