(declare-project
  :name "janet-chipmunk"
  :description "Janet bindings to Chipmunk2D physics library."
  :url "https://github.com/AlecTroemel/janet-chipmunk.git"
  :author "Alec Troemel <alectroemel@hotmail.com>")


(add-loader)

(import /src/types)
(import /src/body)
(import /src/shapes)
(import /src/spaces)
(import /src/main)

(task "src/types.h" [] (types/render "src/types.h"))
(task "src/body.h" [] (body/render "src/body.h"))
(task "src/shapes.h" [] (shapes/render "src/shapes.h"))
(task "src/spaces.h" [] (spaces/render "src/spaces.h"))
(task "src/main.c" [] (main/render "src/main.c"))

(declare-native
 :name "chipmunk"
 :cflags ["-IChipmunk2D/src" "-IChipmunk2D/include"]
 :source ["src/main.c"

          # Chipmunk sources
          "Chipmunk2D/src/chipmunk.c"
          "Chipmunk2D/src/cpArbiter.c"
          "Chipmunk2D/src/cpArray.c"
          "Chipmunk2D/src/cpBBTree.c"
          "Chipmunk2D/src/cpBody.c"
          "Chipmunk2D/src/cpCollision.c"
          "Chipmunk2D/src/cpConstraint.c"
          "Chipmunk2D/src/cpDampedRotarySpring.c"
          "Chipmunk2D/src/cpDampedSpring.c"
          "Chipmunk2D/src/cpGearJoint.c"
          "Chipmunk2D/src/cpGrooveJoint.c"
          "Chipmunk2D/src/cpHashSet.c"
          "Chipmunk2D/src/cpHastySpace.c"
          "Chipmunk2D/src/cpMarch.c"
          "Chipmunk2D/src/cpPinJoint.c"
          "Chipmunk2D/src/cpPivotJoint.c"
          "Chipmunk2D/src/cpPolyline.c"
          "Chipmunk2D/src/cpPolyShape.c"
          "Chipmunk2D/src/cpRatchetJoint.c"
          "Chipmunk2D/src/cpRobust.c"
          "Chipmunk2D/src/cpRotaryLimitJoint.c"
          "Chipmunk2D/src/cpShape.c"
          "Chipmunk2D/src/cpSimpleMotor.c"
          "Chipmunk2D/src/cpSlideJoint.c"
          "Chipmunk2D/src/cpSpace.c"
          "Chipmunk2D/src/cpSpaceComponent.c"
          "Chipmunk2D/src/cpSpaceDebug.c"
          "Chipmunk2D/src/cpSpaceHash.c"
          "Chipmunk2D/src/cpSpaceQuery.c"
          "Chipmunk2D/src/cpSpaceStep.c"
          "Chipmunk2D/src/cpSpatialIndex.c"
          "Chipmunk2D/src/cpSweep1D.c"]

 :headers ["src/types.h"
           "src/body.h"
           "src/shapes.h"
           "src/spaces.h"])
