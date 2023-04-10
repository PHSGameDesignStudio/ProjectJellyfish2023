extends Resource
class_name Magic_Card_Item
const Element = {
	EARTH = 0,
	AIR = 1,
	FIRE = 2,
	WATER = 3
}
export (String) var spell_name
export (String) var spell_description
export (Element) var element
export (PoolIntArray) var incantation
export (Texture) var spell_card_image
