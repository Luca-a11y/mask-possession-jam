# Mask Possesion Game Document

## Brief description

In Mask Possession you are a doll who wants to escape her/his dollhouse to comprehend your human friend. In your journey you will use the masks to animate or interact with other objects

## Game elements

	- TILES: The drawn image of a room, akin to the tiles of [Mansion of Madness](https://www.dicebreaker.com/games/mansions-of-madness-second-edition/news/no-more-mansions-of-madness-2e-expansions-ffg)
	- MASKS: Object who need to be thrown around to get the possession of the objects in the scene, every not possessable object must be drawn in the floor tile so it is clear what can and cannot be possessable
	- PLAYER: The 2d sprite of a doll, animated by pose or using a 2d skeleton
	- OBJECTS: the element of the scene that can be possessed by the player to help or obstacle them

## Masks

Masks permit to posses and alter the behaviour of the objects in the scene.
Each object can be possesed by one and only one mask and every mask can posses one and only one object.

Masks can be of different type:
	- MOVE: Permit to move objects
	- SLOW: Permit to slow down the velocity of a 
	- CLONE: Permit to create a clone of the object. Said object can be then possessed as long as the original copy still has the mask
		> [!WARNING]
		> Once the player reclaim the clone mask the mask that possess said clone must be gave back tp the player
	- GROW: Increase the size of possessed object
	- REDUCE: Reduce the size of possessed object
