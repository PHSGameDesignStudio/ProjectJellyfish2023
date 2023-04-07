using Godot;
using System;
using System.Collections.Generic;

public class BattleManager : Node
{
	public static BattleManager Instance;
	public static Node battleBox;
	Random random = new Random();
	public PackedScene[] RefEntities;
	
	
	public static List<BattleEntity> entities;
	public int minEnemies;
	public int maxEnemies;
	public enum BattleState
	{
		PlayerMain,
		PlayerAttack,
		PlayerMagic,
		PlayerInventory,
		PlayerInteract,
		Player,
		PlayerSelectEntity,
		EntityTurn,
	}
	public static BattleState battleState;
	public Control playerMainUI;
	public Control playerAttackUI;
	public Control playerMagicUI;
	public Control playerInventoryUI;
	public Control playerInteractUI;
	public Control entityUI;
	public Control entitySelectorUI;
	public Dictionary<BattleState, Node> currentUI;
	public static string objName;
	void Start()
	{
		Instance = this;
		battleBox = GetNode("BattleBox");
		objName = Name;
		battleState = BattleState.PlayerMain;
		currentUI = new Dictionary<BattleState, Node>() {
			{ BattleState.PlayerMain, playerMainUI },
			{ BattleState.PlayerAttack, playerAttackUI },
			{ BattleState.PlayerMagic, playerMagicUI },
			{ BattleState.PlayerInventory, playerInventoryUI },
			{ BattleState.PlayerInteract, playerInteractUI },
			{ BattleState.PlayerSelectEntity, entitySelectorUI },
			{ BattleState.EntityTurn, entityUI },

		};
		Input.MouseMode = Input.MouseModeEnum.Captured;
		entities = new List<BattleEntity>(); // note this was locked
		InitEntities();
	}
	
	void Update()
	{
		// Reset isAttackDone to Default
		if (battleState == BattleState.EntityTurn && IsAllBattlesOver())
		{
			battleState = BattleState.PlayerMain;
			foreach (var entity in entities)
				entity.isAttackDone = false;
		}

		// Enables UI for mode
		foreach (var item in currentUI)
			item.Value.SetProcess(item.Key == battleState);
	}
	bool IsAllBattlesOver()
	{
		if (entities.Count != 0)
			for (int i = 0; i < entities.Count; i++)
				if (!entities[i].isAttackDone)
					return false;
		return true;
	}
	public void InitEntities()
	{
		var n = random.Next(minEnemies, maxEnemies);
		//transform.SetParent(null); // ABLE TO INSTANTIATE
		for (int i = 0; i <= n; i++)
		{
			var entity = RefEntities[random.Next(0, RefEntities.Length)].Instance() as BattleEntity;
			AddChild(entity);
			entity.i = i; // Item in list
			entity.n = n; // length of list
			entities.Add(entity);
		}
	}
	public void StartBattle()
	{
		battleState = BattleState.EntityTurn;
		for (int i = 0; i < entities.Count; i++)
		{
			//entities[i].transform.SetParent(null);
			entities[i].StartAttack();
		}
	}
	public static bool IsItPlayerTurn()
	{
		var playerStates = new List<BattleState>()
		{
			BattleState.PlayerMain,
			BattleState.PlayerMagic,
			BattleState.PlayerInventory,
			BattleState.PlayerInteract,
			BattleState.PlayerSelectEntity,
		};
		foreach (BattleState state in playerStates)
		{
			if (battleState == state) return true;
		};
		return false;
	}
	public void SelectEntity(BattleState nextState)
	{
		EntitySelector.nextBattleState = nextState;
		battleState = BattleState.PlayerSelectEntity;
	}

	#region Button Functions
	public void AttackSelectEntity()
	{
		SelectEntity(BattleState.PlayerAttack);
	}
	public void MagicSelectEntity()
	{
		SelectEntity(BattleState.PlayerMagic);
	}
	public void ItemsSelectEntity()
	{
		battleState = BattleState.PlayerInventory;
	}
	#endregion

	// The attack UI called when enemy is selected
	public void AttackUI()
	{
		battleState = BattleState.PlayerAttack;
		//battleBox.SetProcess(true);
	}
	// Executes a turn if you select the enemy
	public void ExecuteTurnOnEnemy()
	{
		if (battleState == BattleState.PlayerAttack) AttackUI();
		if (battleState == BattleState.PlayerMagic)
		{
			//Instantiate(Resources.Load("Magic/Magic Nav") as GameObject);
		}
	}
	public void PlayerAttackScore(int score)
	{

	}
}
