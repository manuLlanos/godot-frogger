the classic frog game, with *original* sprites + sounds and some particle effects

## 1/12/2023

first hours of work and commit, made a character with a simple dead animation, tiles for a wall, walkways, a road
and animated water.
Movement is grid based, cannot walk through walls, and player detects if it enters water, where it will drown
(playing a dead animation, emiting some water particles, and playing a splash sound
Still have to make the sprites for vehicles, logs, turtles, crocodiles the tadpoles and some "nature" being the top wall
and all the logic 

## 3/12/2023

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


## 5/12/2023

# The moving on update
Added final touches, game should be fully playable (with one little annoying part) and beatable.
The one level it has right now is a bit hard, and it doesn't help that sometimes standing on floating objects
makes the frog slide a bit until an input is used again
The idea was to have 3 levels in total, from easy to hard, but at this point im just bored of this project
and i think i've learned and worked enough.

- Changed the moving object method entirely, no longer repeating tweens (this is not a "pure" tile game) but simply
moving them on a process function, this is done to let the frog stand on logs/turtles and move along with them
- Added score system and finally the game goal, lily pads that can be reached an a "safe frog" is placed there
50 points per safe frog, 5 points per second left on the timer, 1000 points when all 5 frogs are safe, 100 points per life left
- Added barebones UI, couldn't get progress bar to work for timer
- Should be able to reload by pressing R on game over and game won screens
- Made a level class, so more levels can be added by inheriting from that
