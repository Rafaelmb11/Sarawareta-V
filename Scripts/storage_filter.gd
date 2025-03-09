extends GridContainer

func apply_filter(type : String):
	var slots = self.get_children()
	if type == "All":
		for s in slots:
			s.visible = true
		return
	for s in slots:
		if s.ItemType == type:
			s.visible = true
		else:
			s.visible = false
