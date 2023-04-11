using Godot;
using System;
using System.Collections.Generic;
public class DataManager : Node
{
    public static List<int[]> incantations;
    // Declare member variables here. Examples:
    // private int a = 2;
    // private string b = "text";

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        
    }

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
    public static int GetIncantationIndex(Godot.Collections.Array arr)
    {
        return DeckOfCards.GetIncantationIndex(arr);
    }
}
