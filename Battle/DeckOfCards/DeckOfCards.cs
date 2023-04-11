using Godot;
using System;
using System.Collections.Generic;

public static class DOC
{
	public static List<Resource> spells;
	public static List<int[]> incantations = new List<int[]>();
	public static T[] ToArray<T>(this Godot.Collections.Array arr)
	{
		var newArr = new T[arr.Count];
		for (int i = 0; i < arr.Count; i++)
			newArr[i] = (T)arr[i];
		return newArr;
	}

}
public class DeckOfCards : Control
{
	[Export]
	List<Resource> spells; // change to static eventually!
	public static List<Node> spellNodes;
	public static Godot.Collections.Array currentIncantation;
	private int currentItem = 0;
	[Export]
	private PackedScene spellCardPrefab;
	[Export]
	private float startX;
	[Export]
	private float endX;
	[Export]
	private float Y;
	[Export]
	private float transitionTime;
	public override void _Ready()
	{
		DOC.spells = spells;
		DOC.incantations = new List<int[]>();
		spellNodes = new List<Node>();
		for (int i = 0; i < spells.Count; i++)
		{
			spellNodes.Add(spellCardPrefab.Instance());
			AddChild(spellNodes[i]);
			((TextureRect)spellNodes[i]).Texture = (Texture)spells[i].Get("spell_card_image");
			DOC.incantations.Add(((Godot.Collections.Array)spells[i].Get("incantation")).ToArray<int>());
		}
		UpdateNodes();
	}
	public override void _Process(float delta)
	{
		if (Input.IsActionJustPressed("ui_right"))
		{
			currentItem += 1;
			if (currentItem >= spells.Count) currentItem = 0;
			UpdateNodes();
		}
		if (Input.IsActionJustPressed("ui_left"))
		{
			currentItem -= 1;
			if (currentItem < 0) currentItem = spells.Count - 1;
			UpdateNodes();
		}
		if (Input.IsActionJustPressed("ui_accept"))
		{
			currentIncantation = (Godot.Collections.Array)spells[currentItem].Get("incantation");
			GetTree().ChangeScene("res://Battle/MagicIncantation/MagicIncantation.tscn");
		}
	}
	public Vector2 GetPosition(int index)
	{
		var newI = index - currentItem;
		if (newI < 0) newI += spells.Count;
		if (newI >= spells.Count) newI -= spells.Count;

		return new Vector2(Mathf.Lerp(startX, endX, (float)newI / spells.Count), Y);
	}
	public void RaiseNodes()
	{
		int i = currentItem - 1;
		GD.Print("--");
		for (int count = 0; count < spellNodes.Count; count += 1)
		{
			if (i < 0)
			{
				i += spellNodes.Count;
			}
			spellNodes[i].Raise();
			GD.Print(i);
			i -= 1;
		}
	}
	public void UpdateNodes()
	{
		RaiseNodes();
		for (int i = 0; i < spellNodes.Count; i++)
		{
			var tween = GetTree().CreateTween();
			tween.TweenProperty(spellNodes[i], "rect_position", GetPosition(i), transitionTime).SetEase(Tween.EaseType.InOut);
			// note to make special animation case for selected node
		}
	}
	public static int GetIncantationIndex(Godot.Collections.Array incantation)
	{
		int[] inc = incantation.ToArray<int>();
		return DOC.incantations.IndexOf(inc);
	}
}
