macroScript BipedScal tooltip:"Bipedのスケールをオン/オフ" Category:"# Scripts" Icon:#("BipedScal",1)
(
	--********************************************************************************************
	-- Script for 3dsMax (MaxScript)
	-- ***Biped_Scaler***
	-- Updated 2018/11/27
	-- Copyright (c) 2018 @Takayuki Sato All rights reserved.
	--********************************************************************************************

	try (destroydialog Biped_Scaler_RO) catch() -- 二重起動の防止

	global RF_width = 200 -- RolloutFloaterの幅を定義
	global RF_height = 135 -- RolloutFloaterの高さを定義

	-- Rollout名を変更
	rollout Biped_Scaler_RO "Biped Scaler"
	(
		label lbl1 "Select Biped Bones and press button to add scale controller" pos:[5,5] width:180 height:25
		button BTN_run "Run Biped Scaler" offset:[0,5] width:150 height:35
		button BTN_disable "Del Biped Scaler" offset:[0,10] width:150 height:35

		on BTN_run pressed do
		(
			max create mode 
			Undo "Biped Scaler" on
			(
				for o in selection do
				(
					if (classof o.controller == BipSlave_Control) and (classof o.transform.controller[1].controller.BipScaleList.controller[1].controller != ScaleXYZ) then
					(
						o.transform.controller[1].controller.BipScaleList.controller.Available.controller = ScaleXYZ()
					)
				)
				-- Enable Subanims make ON
				for o in objects do
				(
					if (classof o.controller == Vertical_Horizontal_Turn) then
					(
						o.controller.enableSubAnims = true
					)
				)
			)
		)

		on BTN_disable pressed do
		(
			max create mode 
			Undo "Biped Scaler" on
			(
				for o in selection do
				(
					if (classof o.controller == BipSlave_Control) and (classof o.transform.controller[1].controller.BipScaleList.controller[1].controller == ScaleXYZ) then
					(
						o.transform.controller[1].controller.BipScaleList.controller.delete 1
					)
				)
				-- Enable Subanims make ON
				for o in objects do
				(
					if (classof o.controller == Vertical_Horizontal_Turn) then
					(
						o.controller.enableSubAnims = true
					)
				)
			)
		)
	)

	-- 正しいRollout名でダイアログを作成
	createdialog Biped_Scaler_RO width:RF_width height:RF_height
)

