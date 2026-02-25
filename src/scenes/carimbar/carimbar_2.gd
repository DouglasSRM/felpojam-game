extends GameCarimbo

func chamar_ticket():
	if current_ticket == 11:
		for i in range(5):
			SceneManager.set_dark_effect()
			await Utils.sleep(0.5)
		Global.pos_carimbo_4 = true
		terminou.emit()
		return
	super()
	if current_ticket > 2:
		SceneManager.set_dark_effect()
