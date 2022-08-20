# adapted almost line for line from:
# http://chipmunk-physics.net/release/ChipmunkLatest-Docs/#Intro-HelloChipmunk

(use ../build/chipmunk)

# cpVects are just tuples
(var gravity [0 -100])

# Create an empty space.
(var space (space-new))
(space-set-gravity space [0 -100])

# Add a static line segment shape for the ground.
# We'll make it slightly tilted so the ball will roll off.
# We attach it to a static body to tell Chipmunk it shouldn't be movable.

(var ground (-> (space-get-static-body space)
                (segment-shape-new [-20 5] [20 -5] 0)))
(shape-set-friction ground 1)
(space-add-shape space ground)

# Now let's make a ball that falls onto the line and rolls off.
# First we need to make a cpBody to hold the physical properties of the object.
# These include the mass, position, velocity, angle, etc. of the object.
# Then we attach collision shapes to the cpBody to give it a size and shape.
(var radius 1)
(var mass 1)

# The moment of inertia is like mass for rotation
# Use the cpMomentFor*() functions to help you approximate it.
(var moment (moment-for-circle mass 0 radius [0 0]))

# The space-add-* functions return the thing that you are adding.
# It's convenient to create and add an object in one line.
(var ball-body (space-add-body space (body-new mass moment)))
(body-set-position ball-body [0 15])

# Now we create the collision shape for the ball.
# You can create multiple collision shapes that point to the same body.
# They will all be attached to the body and move around to follow it.
(var ball-shape (space-add-shape space (circle-shape-new ball-body radius [0 0])))
(shape-set-friction ball-shape 0.7)

# Now that it's all set up, we simulate all the objects in the space by
# stepping forward through time in small increments called steps.
# It is *highly* recommended to use a fixed size time step.
(let [time-step (/ 1 60)]
  (each time (range 0 2 time-step)
    (printf "Time is %5.2f. ballBody is at %q. It's velocity is %q"
            time
            (body-get-position ball-body)
            (body-get-velocity ball-body))
    (space-step space time-step)))

# Clean up our objects and exit!
(shape-free ball-shape)
(body-free ball-body)
(shape-free ground)
(space-free space)
