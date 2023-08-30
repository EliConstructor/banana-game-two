extends Item
class_name Producer

var upgrades: Node
@export var production: int

func get_production():
	return get_base_production() * amount

func get_base_production():
	var production_modifier = 1
	for upgrade in upgrades.upgrades:
		if upgrade is ProductionUpgrade:
			if upgrade.producer_filter == self or upgrade.producer_filter == null:
				production_modifier = production_modifier * pow(upgrade.modifier, upgrade.amount)
	return production * production_modifier
