extends Node3D

@export var spin_speed : float = 1.0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node(".").rotate(Vector3(0,1,0),spin_speed);
	pass
