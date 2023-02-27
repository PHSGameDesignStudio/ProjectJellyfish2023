using Godot;
using System;
using System.Collections.Generic;
public class Inventory : Control
{
	private static List<Resource> inventoryItems = new List<Resource>();
	private Godot.Sprite[,] itemBGNodes = new Godot.Sprite[6,3];
	private Godot.TextureRect[] itemImages = new Godot.TextureRect[13];
	private Godot.Label itemDescription;
	int nodePointerX = 3;
	int nodePointerY = 0;
	public override void _Ready()
	{
		inventoryItems.Add(ResourceLoader.Load("InventoryItems/Sword.tres"));
		itemDescription = (Label)GetNode("Description");
		
		for (int i = 0; i < 3; i++) itemBGNodes[i,0] = null;
		int thisX = 3, thisY = 0;
		for (int i = 0; i < 15; i++) {
			if (thisX >= 6)
			{
				thisX = 0;
				thisY += 1;
			}
			itemBGNodes[thisX,thisY] = (Sprite)GetNode(new NodePath($"ItemBG{i}"));
			thisX += 1;
		}
		for (int i = 0; i < itemImages.Length; i++)
		{
			itemImages[i] = (TextureRect)GetNode(new NodePath($"ItemImg{i}"));
		}
		Select(nodePointerX,nodePointerY);
		UpdateItemImages();
	}
	public override void _Process(float delta)
	{
		if (Input.IsActionJustPressed("ui_left")) MovePointer(-1,0);
		else if (Input.IsActionJustPressed("ui_right")) MovePointer(1,0);
		else if (Input.IsActionJustPressed("ui_up")) MovePointer(0,-1);
		else if (Input.IsActionJustPressed("ui_down")) MovePointer(0,1);

		if (Input.IsActionJustPressed("ui_accept")) OnPressed();
		else if (Input.IsActionJustPressed("ui_cancel")) OnCancel();
	}
	void MovePointer(int dirX, int dirY)
	{
		GD.Print($"move pointer: {dirX},{dirY}");
		if (0 <= nodePointerX + dirX && nodePointerX + dirX < 6 && 0 <= nodePointerY + dirY && nodePointerY + dirY < 3)
		{
			if (itemBGNodes[nodePointerX + dirX, nodePointerY + dirY] != null) 
			{
				Unselect(nodePointerX, nodePointerY);
				nodePointerX += dirX;
				nodePointerY += dirY;
				Select(nodePointerX, nodePointerY);
			}
		}
	}
	void Unselect(int x, int y)
	{
		itemBGNodes[nodePointerX, nodePointerY].SelfModulate = new Color(1,1,1);
	}
	void Select(int x, int y)
	{
		itemBGNodes[nodePointerX, nodePointerY].SelfModulate = new Color(0,0,0);
		int itemID = (nodePointerX - 3) + (nodePointerY * 6);
		if (itemID < inventoryItems.Count)
			itemDescription.Text = (String)inventoryItems[itemID].Get("description");
		else
			itemDescription.Text = "";
	}
	void UpdateItemImages()
	{
		for (int i = 0; i < inventoryItems.Count; i++)
		{
			itemImages[i].Texture = (Godot.Texture)inventoryItems[i].Get("texture");
		}
	}
	void OnPressed()
	{

	}
	void OnDiscard()
	{

	}
	void OnCancel()
	{
		
	}

	[Signal] public delegate void OnExitInventory();
}
