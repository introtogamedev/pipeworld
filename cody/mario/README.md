```
   -CODY-
┏━━━━━━━━━┓
┗┳━━━━━━━┳┛
 ┃       ┃
 ┃       ┃
┈┃       ┃┈
 ┗ ━ ━ ━ ┛
```

# Refined Scope Items List for Character Controller:
Gravity and Jumping Mechanics
- Frame-perfect Gravity Tuning - Adjust gravity to match frame count from the reference for different fall heights.
- Initial Impulse Tuning - Tune the initial jump impulse to match the minimum jump height frame count.
- Hold Gravity Adjustment - Fine-tune gravity when the jump button is held, to match the maximum jump height frame count.
- Maximum Fall Speed - Determine the max fall speed by counting frames it takes to fall from the greatest height in the reference.
Movement Mechanics
- Walk Acceleration Tuning - Adjust walk acceleration by feeling out the time it takes to reach max walk speed.
- Run Acceleration Tuning - Fine-tune run acceleration by feeling out the time it takes to reach max run speed.
- Deceleration Tuning - Measure and adjust deceleration to match how many frames it takes to stop from max walk speed.
- Turn Deceleration Tuning - Refine turn deceleration to match frame count to change direction from max speed.
Speed Metrics
- Max Walk Speed Frame Count - Determine max walk speed based on how many frames to cross a block.
- Max Run Speed Frame Count - Calculate max run speed using frame count to cross a block.
- Minimum Walk Speed Perception - Define min walk speed by feeling it out comparatively to the original game.
Skid Mechanics
- Skid Trigger Logic - Define exact conditions under which the character will start a skid.
- Skid Animation Implementation - Add a unique animation for skidding.
- Skid Movement Physics - Implement altered movement dynamics while skidding, including reduced speed and control.
- Skid Termination Criteria - Define how and when the skid stops, including frame count and change in input state.
Additional Mechanics for Authenticity
- Bounce Mechanics - Implement precise bounce heights and mechanics when jumping on enemies or certain objects.
- Power-Up System - Create a detailed system for power-ups that affect the character's abilities and interactions.
- Collision Buffering - Improve collision detection to prevent clipping and add buffer zones for smoother interactions.
- Multi-State Animation - Different animations for small, big, and powered-up character states, including transitions.
- Environmental Effects - Implement effects of different environmental elements like water, ice, and slopes on the character's movement.



# Given frame count data for falling from different heights, we can calculate the gravity.
# Assuming that the original Super Mario Bros game runs at 60 frames per second (FPS)
FPS = 60

# Using the provided frame counts to calculate gravity for each height
# Using the formula: d = 0.5 * g * t^2 to solve for g, where d is distance, g is gravity, and t is time in seconds.
# Considering each block to be 1 unit of distance.

# 2 blocks fall data (averaging two frame counts)
fall_frames_2_blocks = (12 + 10) / 2
gravity_2_blocks = (2 * 2) / ((fall_frames_2_blocks / FPS) ** 2)

# 4 blocks fall data (averaging two frame counts)
fall_frames_4_blocks = (20 + 19) / 2
gravity_4_blocks = (4 * 2) / ((fall_frames_4_blocks / FPS) ** 2)

# 8 blocks fall data
fall_frames_8_blocks = 34
gravity_8_blocks = (8 * 2) / ((fall_frames_8_blocks / FPS) ** 2)

# Average the gravity calculations to get an estimated gravity value
estimated_gravity = (gravity_2_blocks + gravity_4_blocks + gravity_8_blocks) / 3

# Initial impulse calculation based on minimum jump height
# Using the formula: v = u + at, where v is final velocity (0 at the peak of the jump), u is initial velocity (initial impulse),
# a is acceleration (gravity in this case), and t is time.
# Considering the jump to reach a height of 1 block for the minimum jump.

min_jump_frames = 10
initial_impulse = estimated_gravity * (min_jump_frames / FPS)

# Hold gravity calculation based on maximum jump height
# For maximum jump height, assuming the character reaches 4 blocks high when the jump button is held.
max_jump_frames = 29
hold_gravity = (4 * 2) / ((max_jump_frames / FPS) ** 2)

# Now the calculated gravity, initial impulse, and hold gravity values
estimated_gravity, initial_impulse, hold_gravity = (81.5249663508671, 13.587494391811184, 34.244946492271104)