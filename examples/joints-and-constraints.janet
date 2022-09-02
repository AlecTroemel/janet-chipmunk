# Addapted from https://github.com/slembcke/Chipmunk2D/blob/master/demo/Joints.c
# chipmunk's demos are programmed...interestingly. So theres been some creative
# freedom in how I write this.
(use jaylib)
(use ../build/chipmunk)

(def SCREEN_WIDTH 800)
(def SCREEN_HEIGHT 450)
(def space (space-new))

(defn vadd [& vs]
  [(reduce |(+ $0 ($1 0)) 0 vs)
   (reduce |(+ $0 ($1 1)) 0 vs)])

(defn add-ball [pos box-offset]
  (let [radius 15
        mass 1
        moment (moment-for-circle mass 0 radius [0 0])
        body (body-new mass moment)
        space (space-add-shape space (circle-shape-new body radius [0 0]))]
    (space-add-body space body)
    (body-set-position body (vadd pos box-offset))
    (shape-set-elasticity shape 0)
    (shape-set-friction shape 0.7)
    body))

(defn add-lever [pos box-offset]
  (let [mass 1
        a [0 15]
        b [0 -15]
        moment (moment-for-segment mass a b 0)
        body (body-new mass moment)
        space (space-add-shape space (segment-shape-new body a b 5))]
    (space-add-body space body)
    (body-set-position body (vadd pos box-offset [0 -15]))
    (shape-set-elasticity shape 0)
    (shape-set-friction shape 0.7)
    body))

(defn add-bar [pos box-offset]
  (let [mass 2
        a [0 30]
        b [0 -30]
        moment (moment-for-segment mass a b 0)
        body (body-new mass moment)
        space (space-add-shape space (segment-shape-new body a b 5))]
    (space-add-body space body)
    (body-set-position body (vadd pos box-offset))
    (shape-set-elasticity shape 0)
    (shape-set-friction shape 0.7)

    (shape-set-filter shape {:group 1 :categories :all :mask :all})

    body))

(defn add-wheel [pos box-offset]
  (let [radius 15
        mass 1
        moment (moment-for-circle mass 0 radius [0 0])
        body (body-new mass moment)
        space (space-add-shape space (circle-shape-new body radius [0 0]))]
    (space-add-body space body)
    (body-set-position body (vadd pos box-offset))
    (shape-set-elasticity shape 0)
    (shape-set-friction shape 0.7)

    (shape-set-filter shape {:group 1 :categories :all :mask :all})

    body))

(defn add-chassis [pos box-offset]
  (let [mass 1
        width 80
        height 30
        moment (moment-for-box mass width height)
        body (body-new mass moment)
        space (space-add-shape space (box-shape-new body width height 0))]
    (space-add-body space body)
    (body-set-position body (vadd pos box-offset))
    (shape-set-elasticity shape 0)
    (shape-set-friction shape 0.7)

    (shape-set-filter shape {:group 1 :categories :all :mask :all})

    body))


(defn create-plank [a b]
  (-> (space-add-shape space (segment-shape-new static-body a b 0))
      (shape-set-elasticity 1)
      (shape-set-friction 1)
      (shape-set-filter :not-grabbable)))

(def pos-a [50 60])
(def pos-b [110 60])

# Pin Joints - Link shapes with a solid bar or pin.
# Keeps the anchor points the same distance apart from when the joint was created.
(defn create-pin-joint []
  (let [box-offset [-320 -240]
        body1 (add-ball space pos-a box-offset)
        body2 (add-ball space pos-b box-offset)]
    (space-add-constraint space (pin-joint-new body1 body2 [15 0] [-15 0]))))

# Slide Joints - Like pin joints but with a min/max distance.
# Can be used for a cheap approximation of a rope.
(defn create-slide-joint []
  (let [box-offset [-160 -240]
        body1 (add-ball space pos-a box-offset)
        body2 (add-ball space pos-b box-offset)]
    (space-add-constraint space (slide-joint-new body1 body2 [15 0] [-15 0] 20 40))))

# Pivot Joints - Holds the two anchor points together. Like a swivel.
(defn create-pivot-joint []
  (let [box-offset [0 -240]
        body1 (add-ball space pos-a box-offset)
        body2 (add-ball space pos-b box-offset)]
    (space-add-constraint space (pivot-joint-new body1 body2 (vadd box-offset [80 60])))))

# Groove Joints - Like a pivot joint, but one of the anchors is a line segment that the pivot can slide in
(defn create-groove-joint []
  (let [box-offset [160 -240]
        body1 (add-ball space pos-a box-offset)
        body2 (add-ball space pos-b box-offset)]
    (space-add-constraint space (groove-joint-new body1 body2 [30 30] [30 -30] [-30 0]))))

# Damped Springs
(defn create-damped-spring []
  (let [box-offset [-320 -120]
        body1 (add-ball space pos-a box-offset)
        body2 (add-ball space pos-b box-offset)]
    (space-add-constraint space (damped-spring-new body1 body2 [15 0] [-15 0] 20 5 0.3))))

(defn create-damped-rotary-spring []
  (let [box-offset [-160 -120]
        body1 (add-bar space pos-a box-offset)
        body2 (add-bar space pos-b box-offset)]
    # Add some pin joints to hold the circles in place.
    (space-add-constraint space (pivot-joint-new body1 static-body (vadd box-offset pos-a)))
    (space-add-constraint space (pivot-joint-new body2 static-body (vadd box-offset pos-b)))
    (space-add-constraint space (damped-rotary-spring-new body1 body2 0 3000 60))))

(defn create-rotary-limit-spring []
  (let [box-offset [0 -120]
        body1 (add-lever space pos-a box-offset)
        body2 (add-lever space pos-b box-offset)]
    # Add some pin joints to hold the circles in place.
    (space-add-constraint space (pivot-joint-new body1 static-body (vadd box-offset pos-a)))
    (space-add-constraint space (pivot-joint-new body2 static-body (vadd box-offset pos-b)))
    # Hold their rotation within 90 degrees of each other.
    (space-add-constraint space (rotary-limit-joint-new body1 body2 (/ (- math/pi) 2) (/ math/pi 2)))))

# A rotary ratchet, like a socket wrench
(defn create-ratchet-joint []
  (let [box-offset [160 -120]
        body1 (add-lever space pos-a box-offset)
        body2 (add-lever space pos-b box-offset)]
    # Add some pin joints to hold the circles in place.
    (space-add-constraint space (pivot-joint-new body1 static-body (vadd box-offset pos-a)))
    (space-add-constraint space (pivot-joint-new body2 static-body (vadd box-offset pos-b)))
    # ratchet every 90 degrees
    (space-add-constraint space (ratchet-join-new body1 body2 0 (/ math/pi 2)))))

# Gear Joint - Maintain a specific angular velocity ratio
(defn create-gear-joint []
  (let [box-offset [-320 0]
        body1 (add-bar space pos-a box-offset)
        body2 (add-bar space pos-b box-offset)]
    # Add some pin joints to hold the circles in place.
    (space-add-constraint space (pivot-joint-new body1 static-body (vadd box-offset pos-a)))
    (space-add-constraint space (pivot-joint-new body2 static-body (vadd box-offset pos-b)))
    # Force one to sping 2x as fast as the other
    (space-add-constraint space (gear-joint-new body1 body2 0 2))))

# Maintain a specific angular relative velocity
(defn create-simple-motor []
  (let [box-offset [-160 0]
        body1 (add-bar space pos-a box-offset)
        body2 (add-bar space pos-b box-offset)]
    # Add some pin joints to hold the circles in place.
    (space-add-constraint space (pivot-joint-new body1 static-body (vadd box-offset pos-a)))
    (space-add-constraint space (pivot-joint-new body2 static-body (vadd box-offset pos-b)))
    # Make them spin at 1/2 revolution per second in relation to each other.
    (space-add-constraint space (simple-motor-new body1 body2 math/pi))))

# Make a car with some nice soft suspension
(defn create-car []
  (let [box-offset [0 0]
        wheel1 (add-wheel space pos-a box-offset)
        wheel2 (add-wheel space pos-b box-offset)
        chassis (add-chassis space [80 100] box-offset)]

    (space-add-constraint space (groove-joint-new chassis wheel1 [-30 -10] [-30 -40] [0 0]))
    (space-add-constraint space (groove-joint-new chassis wheel2 [30 -10] [30 -40] [0 0]))

    (space-add-constraint space (damped-spring-new chassis wheel1 [-30 0] [0 0] 50 20 10))
    (space-add-constraint space (damped-spring-new chassis wheel2 [30 0] [0 0] 50 20 10))))

(defn init []
  (space-set-iterations space 10)
  (space-set-gravity space [0 -100])
  (space-set-sleep-time-threshold space 0.5)

  (let [static-body (space-get-static-body space)]
    (create-plank [-320 240] [320 240])
    (create-plank [-320 120] [320 120])
    (create-plank [-320 0] [320 0])
    (create-plank [-320 -120] [320 -120])
    (create-plank [-320 -240] [320 -240])
    (create-plank [-320 -240] [320 240])
    (create-plank [-160 -240] [-160 240])
    (create-plank [0 -240] [0 240])
    (create-plank [160 -240] [160 240])
    (create-plank [320 -240] [320 240])

    (create-pin-joint)
    (create-slide-joint)
    (create-pivot-joint)
    (create-groove-joint)
    (create-damped-spring)
    (create-damped-rotary-spring)
    (create-rotary-limit-spring)
    (create-ratchet-joint)
    (create-gear-joint)
    (create-simple-motor)
    (create-car)))

(defn update [dt]
  (space-step space dt))

(defn draw []
  (clear-background [0 0 0])
  (draw-text "Joints and Constraints" 10 10 10 :white))

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
