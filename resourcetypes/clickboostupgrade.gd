extends Upgrade
class_name ClickBoostUpgrade

enum CLICK_BOOST_TYPE{
	ADDITION,
	MULTIPLIER
}

@export var type: CLICK_BOOST_TYPE
@export var modifier: float
