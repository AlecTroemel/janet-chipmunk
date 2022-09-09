# Addapted from https://github.com/slembcke/Chipmunk2D/blob/master/demo/Joints.c
# chipmunk's demos are programmed...interestingly. So theres been some creative
# freedom in how I write this.
(use jaylib)
(use ../build/chipmunk)

(def SCREEN_WIDTH 800)
(def SCREEN_HEIGHT 450)
(def space (space-new))

# keep track of shapes and their bodies so we can
# draw them using raylib.
# TODO: find a way to use
(def shapes @[])


(defn vadd [& vs]
  [(reduce |(+ $0 ($1 0)) 0 vs)
   (reduce |(+ $0 ($1 1)) 0 vs)])

(defn add-ball [pos box-offset &named static]
  (default static false)
  (let [radius 10
        mass 1
        moment (moment-for-circle mass 0 radius [0 0])
        body (body-new mass moment)
        shape (circle-shape-new body radius [0 0])]
    (space-add-body space body)
    (space-add-shape space shape)
    (body-set-position body (vadd pos box-offset))
    (when static (body-set-type body :static))
    (shape-set-elasticity shape 0)
    (shape-set-friction shape 0.7)
    (array/push shapes [:circle radius body])
    body))

(defn add-lever [pos box-offset &named static]
  (default static false)
  (let [mass 1
        a [0 15]
        b [0 -15]
        moment (moment-for-segment mass a b 0)
        body (body-new mass moment)
        shape (segment-shape-new body a b 5)]
    (space-add-body space body)
    (space-add-shape space shape)
    (body-set-position body (vadd pos box-offset [0 -15]))
    (when static (body-set-type body :static))
    (shape-set-elasticity shape 0)
    (shape-set-friction shape 0.7)
    (array/push shapes [:segment a b body])
    body))

(defn add-bar [pos box-offset &named static]
  (default static false)
  (let [mass 2
        a [0 30]
        b [0 -30]
        moment (moment-for-segment mass a b 0)
        body (body-new mass moment)
        shape (segment-shape-new body a b 5)]
    (space-add-body space body)
    (space-add-shape space shape)
    (body-set-position body (vadd pos box-offset))
    (when static (body-set-type body :static))
    (shape-set-elasticity shape 0)
    (shape-set-friction shape 0.7)
    (shape-set-filter shape {:group 1 :categories :all :mask :all})
    (array/push shapes [:segment a b body])
    body))

(defn add-wheel [pos box-offset]
  (let [radius 15
        mass 1
        moment (moment-for-circle mass 0 radius [0 0])
        body (body-new mass moment)
        shape (circle-shape-new body radius [0 0])]
    (space-add-body space body)
    (space-add-shape space shape)
    (body-set-position body (vadd pos box-offset))
    (shape-set-elasticity shape 0)
    (shape-set-friction shape 0.7)
    (shape-set-filter shape {:group 1 :categories :all :mask :all})
    (array/push shapes [:circle radius body])
    body))

(defn add-chassis [pos]
  (let [mass 1
        width 80
        height 30
        moment (moment-for-box mass width height)
        body (body-new mass moment)
        shape (box-shape-new body width height 0)]
    (space-add-body space body)
    (space-add-shape space shape)
    (body-set-position body pos)
    (shape-set-elasticity shape 0)
    (shape-set-friction shape 0.7)
    (shape-set-filter shape {:group 1 :categories :all :mask :all})
    (array/push shapes [:box width height body])
    body))


(defn create-plank [static-body a b]
  (let [shape (segment-shape-new static-body a b 0)]
    (space-add-shape space shape)
    (shape-set-elasticity shape 1)
    (shape-set-friction shape 1)
    # (shape-set-filter :not-grabbable)
    (array/push shapes [:segment a b static-body])
    shape))

(def QUAD_WIDTH (/ SCREEN_WIDTH 4))
(def QUAD_HEIGHT (/ SCREEN_HEIGHT 3))

(defn quadrant-to-coord [[x y]] [(* x QUAD_WIDTH) (* y QUAD_HEIGHT)])

(def pos-a [0 0])
(def pos-b [40 0])

# Pin Joints - Link shapes with a solid bar or pin.
# Keeps the anchor points the same distance apart from when the joint was created.
(defn create-pin-joint [quad]
  (let [box-offset (vadd (quadrant-to-coord quad) [100 50])
        body1 (add-ball pos-a box-offset :static true)
        body2 (add-ball pos-b box-offset)]
    (body-set-type body1 :static)
    (space-add-constraint space (pin-joint-new body1 body2 [0 0] [0 0]))))

# Slide Joints - Like pin joints but with a min/max distance.
# Can be used for a cheap approximation of a rope.
(defn create-slide-joint [quad]
  (let [box-offset (vadd (quadrant-to-coord quad) [100 50])
        body1 (add-ball pos-a box-offset :static true)
        body2 (add-ball pos-b box-offset)]
    (body-set-type body1 :static)
    (space-add-constraint space (slide-joint-new body1 body2 [5 0] [-5 0] 20 40))))

# Pivot Joints - Holds the two anchor points together. Like a swivel.
(defn create-pivot-joint [quad]
  (let [box-offset (vadd (quadrant-to-coord quad) [100 50])
        body1 (add-ball pos-a box-offset :static true)
        body2 (add-ball pos-b box-offset)]
    (space-add-constraint space (pivot-joint-new body1 body2 (vadd box-offset [30 00])))))

# Groove Joints - Like a pivot joint, but one of the anchors is a line segment that the pivot can slide in
(defn create-groove-joint [quad]
  (let [box-offset (vadd (quadrant-to-coord quad) [100 50])
        body1 (add-ball pos-a box-offset :static true)
        body2 (add-ball pos-b box-offset)]
    (space-add-constraint space (groove-joint-new body1 body2 [30 30] [30 -30] [-30 0]))))

# Damped Springs
(defn create-damped-spring [quad]
  (let [box-offset (vadd (quadrant-to-coord quad) [100 50])
        body1 (add-ball pos-a box-offset :static true)
        body2 (add-ball pos-b box-offset)]
    (space-add-constraint space (damped-spring-new body1 body2 [0 0] [0 0] 20 5 0.3))))

(defn create-damped-rotary-spring [quad static-body]
  (let [box-offset (vadd (quadrant-to-coord quad) [100 50])
        body1 (add-bar pos-a box-offset)
        body2 (add-bar pos-b box-offset)]
    # Add some pin joints to hold the circles in place.
    (space-add-constraint space (pivot-joint-new body1 static-body (vadd box-offset pos-a)))
    (space-add-constraint space (pivot-joint-new body2 static-body (vadd box-offset pos-b)))
    (space-add-constraint space (damped-rotary-spring-new body1 body2 0 3000 60))))

(defn create-rotary-limit-spring [quad static-body]
  (let [box-offset (vadd (quadrant-to-coord quad) [100 50])
        body1 (add-lever pos-a box-offset)
        body2 (add-lever pos-b box-offset)]
    # Add some pin joints to hold the circles in place.
    (space-add-constraint space (pivot-joint-new body1 static-body (vadd box-offset pos-a)))
    (space-add-constraint space (pivot-joint-new body2 static-body (vadd box-offset pos-b)))
    # Hold their rotation within 90 degrees of each other.
    (space-add-constraint space (rotary-limit-joint-new body1 body2 (/ (- math/pi) 2) (/ math/pi 2)))))

# A rotary ratchet, like a socket wrench
(defn create-ratchet-joint [quad static-body]
  (let [box-offset (vadd (quadrant-to-coord quad) [100 50])
        body1 (add-lever pos-a box-offset)
        body2 (add-lever pos-b box-offset)]
    # Add some pin joints to hold the circles in place.
    (space-add-constraint space (pivot-joint-new body1 static-body (vadd box-offset pos-a)))
    (space-add-constraint space (pivot-joint-new body2 static-body (vadd box-offset pos-b)))
    # ratchet every 90 degrees
    (space-add-constraint space (ratchet-joint-new body1 body2 0 (/ math/pi 2)))))

# Gear Joint - Maintain a specific angular velocity ratio
(defn create-gear-joint [quad static-body]
  (let [box-offset (vadd (quadrant-to-coord quad) [100 50])
        body1 (add-bar pos-a box-offset)
        body2 (add-bar pos-b box-offset)]
    # Add some pin joints to hold the circles in place.
    (space-add-constraint space (pivot-joint-new body1 static-body (vadd box-offset pos-a)))
    (space-add-constraint space (pivot-joint-new body2 static-body (vadd box-offset pos-b)))
    # Force one to sping 2x as fast as the other
    (space-add-constraint space (gear-joint-new body1 body2 0 2))))

# Maintain a specific angular relative velocity
(defn create-simple-motor [quad static-body]
  (let [box-offset (vadd (quadrant-to-coord quad) [100 50])
        body1 (add-bar pos-a box-offset)
        body2 (add-bar pos-b box-offset)]
    # Add some pin joints to hold the circles in place.
    (space-add-constraint space (pivot-joint-new body1 static-body (vadd box-offset pos-a)))
    (space-add-constraint space (pivot-joint-new body2 static-body (vadd box-offset pos-b)))
    # Make them spin at 1/2 revolution per second in relation to each other.
    (space-add-constraint space (simple-motor-new body1 body2 math/pi))))

# Make a car with some nice soft suspension
(defn create-car [quad]
  (let [box-offset (vadd (quadrant-to-coord quad) [40 50])
        wheel1 (add-wheel pos-a box-offset)
        wheel2 (add-wheel pos-b (vadd box-offset [40 0]))
        chassis (add-chassis (vadd box-offset [0 -30]))]

    (space-add-constraint space (groove-joint-new chassis wheel1 [-10 40] [-10 70] [0 0]))
    (space-add-constraint space (groove-joint-new chassis wheel2 [90 40] [90 70] [0 0]))

    (space-add-constraint space (damped-spring-new chassis wheel1 [-10 0] [0 0] 50 20 10))
    (space-add-constraint space (damped-spring-new chassis wheel2 [90 0] [0 0] 50 20 10))))

(defn init []
  (space-set-iterations space 10)
  (space-set-gravity space [0 100])
  (space-set-sleep-time-threshold space 0.5)

  (let [static-body (space-get-static-body space)]
    (each i (range 0 (+ SCREEN_WIDTH QUAD_WIDTH) QUAD_WIDTH)
      (create-plank static-body [i 0] [i SCREEN_HEIGHT]))
    (each i (range 0 (+ SCREEN_HEIGHT QUAD_HEIGHT) QUAD_HEIGHT)
      (create-plank static-body [0 i] [SCREEN_WIDTH i]))

    (create-pin-joint [0 0])
    (create-slide-joint [1 0])
    (create-pivot-joint [2 0])
    (create-groove-joint [3 0])
    (create-damped-spring [0 1])
    (create-damped-rotary-spring [1 1] static-body)
    (create-rotary-limit-spring [2 1] static-body)
    (create-ratchet-joint [3 1] static-body)
    (create-gear-joint [0 2] static-body)
    (create-simple-motor [1 2] static-body)
    (create-car [2 2])
    ))

(defn update [dt]
  (space-step space dt))

(defn draw []
  (clear-background [0 0 0])
  (draw-text "Joints and Constraints" 10 10 10 :white)

  (each shape shapes
    (match shape
      [:segment a b body]
      (let [position (body-get-position body)
            position (map math/round position)]
        (draw-line-ex (vadd position a)
                      (vadd position b)
                      3 :green))

      [:circle radius body]
      (let [position (body-get-position body)
            [x y] (map math/round position)]
        (draw-circle x y radius :blue))

      [:box width height body]
      (let [position (body-get-position body)
            [x y] (map math/round position)]
        (draw-rectangle x y width height :red)))))

(init-window SCREEN_WIDTH SCREEN_HEIGHT "Joints and Constraints")
(set-target-fps 60)
(var time-step (/ 1 60))

(init)

(while (not (window-should-close))
  (update (get-frame-time))
  (begin-drawing)
  (draw)
  (end-drawing))

(space-free space)
(close-window)
