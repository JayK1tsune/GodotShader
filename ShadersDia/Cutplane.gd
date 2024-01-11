extends MeshInstance3D

var origin : Vector3 = Vector3(0.0,0.0,0.0);
@onready var Location = %Location.global_position;
@export var red = Color(1.0,0.0,0.0)
@export var blue = Color(0.0,0.0,1.0)
# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var my_nodes_global_position = %Cutplane.global_position;
	$AnimationPlayer.play("UP_Down")
	if (my_nodes_global_position > Location):
		RenderingServer.global_shader_parameter_set("border_color", lerp(red,blue,0.5))
	if(my_nodes_global_position < Location):
		RenderingServer.global_shader_parameter_set("border_color", lerp(blue,red,0.1));
	pass
