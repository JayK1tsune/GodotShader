@tool
extends MeshInstance3D
@onready var _cutplane:MeshInstance3D = get_node("%Cutplane");


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	material_override.set_shader_parameter("cutplane", _cutplane.transform);

