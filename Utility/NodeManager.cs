using Godot;
using System;
using System.Collections;
using System.Collections.Generic;

public static class NodeManager
{
	public static List<Node> nodes = new List<Node>();
	public static List<string> nodePaths = new List<string>();
	public static void SetActiveFalse(this Node node) {
		if (!nodes.Contains(node))
		{
			nodePaths.Add(node.GetParent().GetPath());
			nodes.Add(node);
			node.GetParent().RemoveChild(node);
		}
	}
	public static void SetActiveTrue(this Node node) {
		if (nodes.Contains(node))
		{
			var index = nodes.IndexOf(node);
			node.GetNode(nodePaths[index]).AddChild(node);
			nodePaths.RemoveAt(index);
			nodes.RemoveAt(index);
		}
	}
	public static void SetActive(this Node node, bool b)
	{
		if (b) SetActiveTrue(node); else SetActiveFalse(node);
	} 
}
