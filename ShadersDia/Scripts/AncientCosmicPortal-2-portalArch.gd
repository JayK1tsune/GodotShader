@tool
extends MeshInstance3D
@onready var PyramidShips:MeshInstance3D = get_node("%Cutplane");


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	material_override.set_shader_parameter("cutplane", PyramidShips.transform);
