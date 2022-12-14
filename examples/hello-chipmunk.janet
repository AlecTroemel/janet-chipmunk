# adapted from http://chipmunk-physics.net/release/ChipmunkLatest-Docs/#Intro-HelloChipmunk
# added visuals using jaylib

(use jaylib)
(use ../build/chipmunk)

# cpVects are just tuples
(var gravity [0 -100])

# Create an empty space.
(var space (space-new))
(space-set-gravity space [0 100])

# Add a static line segment shape for the ground.
# We'll make it slightly tilted so the ball will roll off.
# We attach it to a static body to tell Chipmunk it shouldn't be movable.
(var ground-point-a [300 300])
(var ground-point-b [600 350])
(var ground (-> (space-get-static-body space)
                (segment-shape-new ground-point-a ground-point-b 0)))
(shape-set-friction ground 1)
(space-add-shape space ground)

# Now let's make a ball that falls onto the line and rolls off.
# First we need to make a cpBody to hold the physical properties of the object.
# These include the mass, position, velocity, angle, etc. of the object.
# Then we attach collision shapes to the cpBody to give it a size and shape.
(var radius 40)
(var mass 1)

# The moment of inertia is like mass for rotation
# Use the cpMomentFor*() functions to help you approximate it.
(var moment (moment-for-circle mass 0 radius [0 0]))

# The space-add-* functions return the thing that you are adding.
# It's convenient to create and add an object in one line.
(var ball-body (space-add-body space (body-new mass moment)))
(body-set-position ball-body [400 100])

# Now we create the collision shape for the ball.
# You can create multiple collision shapes that point to the same body.
# They will all be attached to the body and move around to follow it.
(var ball-shape (space-add-shape space (circle-shape-new ball-body radius [0 0])))
(shape-set-friction ball-shape 0.7)

# Now that it's all set up, we simulate all the objects in the space
# within Raylib's main loop
(def SCREEN_WIDTH 800)
(def SCREEN_HEIGHT 450)
(init-window SCREEN_WIDTH SCREEN_HEIGHT "hello Chipmunk")
(set-target-fps 60)
(var time-step (/ 1 60))

(while (not (window-should-close))
  # Update
  (space-step space time-step)

  (begin-drawing)
  (clear-background [0 0 0])
  (draw-text "Hello Chipmunk" 10 10 10 :white)

  # Draw ground
  (draw-line-v ground-point-a ground-point-b :green)

  # Draw ball
  (let [position (body-get-position ball-body)
        velocity (body-get-velocity ball-body)
       [x y] (map math/round position)]
    (draw-text (string/format "ballBody is at %q. It's velocity is %q"
                              position velocity)
               10 25 10 :white)
    (draw-circle x y radius :green))
  (end-drawing))

# Clean up our objects and exit!
(shape-free ball-shape)
(body-free ball-body)
(shape-free ground)
(space-free space)

(close-window)
