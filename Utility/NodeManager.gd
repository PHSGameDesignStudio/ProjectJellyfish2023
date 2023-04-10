extends Node

var nodes = []
var node_paths = []

func set_active_false(node : Node):
	if not nodes.has(node):
		node_paths.append(node.get_parent().get_path())
		nodes.append(node)
		node.get_parent().remove_child(node)

func set_active_true(node : Node):
	if nodes.has(node):
		var index = nodes.find(node)
		get_node(node_paths[index]).add_child(node)
		node_paths.remove(index)
		nodes.remove(index)
