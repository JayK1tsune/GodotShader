extends DirectionalLight3D

var colors = [Color(1.0,0.0,1.0),Color(0.0,1.0,1.0),
				Color.ALICE_BLUE,Color.DARK_GREEN,Color.YELLOW_GREEN]
var timer = Timer.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(timer);
	timer.set_autostart(true);
	timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(timer % 2.0):
		light_color = colors.pick_random();
	pass
