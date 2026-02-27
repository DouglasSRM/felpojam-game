extends GameCarimbo

func carimbar():
	can_grab = false
	await Utils.sleep(0.5)
	terminou.emit()
