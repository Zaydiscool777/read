def tprint(a, lvl=0):
	if hasattr(a, "__iter__"):
		print("-" * lvl)
		for i in a:
			tprint(i, lvl+1)
	else:
		print("[" * lvl, a, type(a))
