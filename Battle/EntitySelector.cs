using System.Collections;
using System.Collections.Generic;
using Godot;
public class EntitySelector : Node
{
    public BattleManager battleManager;
    public static BattleManager.BattleState nextBattleState; // Battle State to switch to once enemy is selected.
    public static int selectedEntity = 0;
    public float cooldown;
    float timer = 0;

    public override void _Ready()
    {

    }

    // Update is called once per frame
    public override void _Process(float delta)
    {
        for (int i = 0; i < BattleManager.entities.Count; i++)
        {
            var e = BattleManager.entities[i];
            var s = e.GetNode("selectUI");
            s.SetProcess(i == selectedEntity);
        }
        var verticalAxis = Input.GetAxis("ui_down", "ui_up");
        if (verticalAxis != 0 && timer <= 0)
        {
            selectedEntity += (int)Mathf.Round(verticalAxis);
            if (selectedEntity == BattleManager.entities.Count) selectedEntity = 0;
            timer = cooldown;
        }
        timer -= delta;
        if (Input.IsActionJustPressed("ui_submit"))
        {
            BattleManager.battleState = nextBattleState;
            battleManager.ExecuteTurnOnEnemy();
        }
    }
    public static BattleEntity GetSelectedEntity()
    {
        return BattleManager.entities[selectedEntity];
    }
}