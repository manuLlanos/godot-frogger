the classic frog game, with *original* sprites + sounds and some particle effects

# 1/12/2023

first hours of work and commit, made a character with a simple dead animation, tiles for a wall, walkways, a road
and animated water.
Movement is grid based, cannot walk through walls, and player detects if it enters water, where it will drown
(playing a dead animation, emiting some water particles, and playing a splash sound
Still have to make the sprites for vehicles, logs, turtles, crocodiles the tadpoles and some "nature" being the top wall
and all the logic 

# 3/12/2023

- Added more vehicles, logs, turtles that can be static or diving.
- Added a lane node to easily edit the level 
- Added a generic "MovingObject" class, vehicles, logs and turtles inherit from this since they all share the same logic,
only the collision/visibility shapes change, or the diving turtle having animation cycles
(Each lane controls the speed of the vehicles on it, and vehicles restart on its position)
- Changed the water to just a graphical tile, with a big detection area on top of it to make it to easy to detect
when the player should drown
(Before every water tile had its own collision, and it was making things a pain)
- Added top wall and lily pads (victory spots)

Core gameplay features are done, now it's missing the winning logic.
Once the frog reaches an empty lily pad, it should go back to the starting position, and in that lily pad a winner frog appears
(the sprite with sunglasses), that lily pad can no longer be entered. Once the 5 lily pads have a frog, player wins.
Then add all the score/lives/timer logic + UI and game over screen
