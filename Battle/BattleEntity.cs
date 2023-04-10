using System.Collections;
using System.Collections.Generic;
using Godot;
using System;
public class BattleEntity : Node2D
{
	Random random = new Random();
	public float startHP;
	float hp;
	public PackedScene[] attackOptions;
	public bool isAttackDone;
	public Sprite sprite;
	public int n, i;
	public Sprite selectUI;
	public HPBox hpbox;
	public BattleManager battleManager;

	// Start is called before the first frame update
	void Start()
	{
		hp = startHP;
		sprite = (Sprite)Get("sprite");
		selectUI = (Sprite)Get("selectUI");
		hpbox.SetHP(hp, startHP);
	}

	// Update is called once per frame

	public void StartAttack()
	{
		//transform.SetParent(null);
		if (hp > 0)
		{
			var att = attackOptions[random.Next(0, attackOptions.Length)].Instance() as AttackOption; // Creates new attack
			//obj.transform.SetParent(null);
			att.entity = this; // Gives a reference to parent
		}
		else
		{
			isAttackDone = true;
			// TODO : MAKE SO ENTITY DISSAPEARS
		}
	}
	public void Damage(int hpDec)
	{
		if (hp == 1 && hpDec >= 1)
		{
			// Called when the player wants to destroy the entity
			BattleManager.entities.Remove(this); 
			QueueFree();
		}
		else
		{
			hp -= Mathf.Abs(hpDec);
			if (hp < 1) hp = 1; // So player can spare
		}
		hpbox.SetHP(hp, startHP);
	}
	public override void _Process(float delta)
	{
		//gameObject.SetActive(attackDone);
		SetPosition();


		// If we arent selecting any entities there is no need to show the select sprite.
		if (BattleManager.battleState != BattleManager.BattleState.PlayerSelectEntity)
			selectUI.SetActiveFalse();


	}
	public void SetPosition()
	{
		Position = new Vector2(500, Mathf.Lerp(100, 1000, (float)i / n));
	}
}
