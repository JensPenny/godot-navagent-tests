# Navigation Agents Tests

The purpose of this repository is to centralize some tests that I did to figure out how navigation in Godot works.
I'd like to use the navagent-framework for this instead of implementing A* myself, but that means that there are some quirks I need to get familiar with.
This repository will contain some tags with setups that are hopefully useful for others as well. 

## Base setup
The main scene has a navigationRegion2D in the middle.
This navigationRegion has a hole in the middle, where the navigation should route around.

There is a static `player` scene.
This represents the target of the pathfinding. 

There is a `follower` scene.
The follower will attempt to path towards the player.

There is a `wall` scene.
The walls represent collision-enabled sprites that will block the follower.
This plan is for the follower to path around the walls. 

## Tests

### 1. NavigationRegion2D and NavigationObstacle

- The main scene contains a NavigationRegion2D. This looks to be working.
- The wall scene is a NavigationObstacle

This works as long as the obstacles don't fully block a path.
It seems that navigationObstacles are useful for small pathfinding changes, or basic avoidance.
For actual recalculated full paths, another solution is required. 
