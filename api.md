Docs --> http://chipmunk-physics.net/release/ChipmunkLatest-Docs/

# chipmunk.h
- [ ] void cpMessage(const char *condition, const char *file, int line, int isError, int isHardError, const char *message, ...);
- [ ] extern const char *cpVersionString;
- [x] cpFloat cpMomentForCircle(cpFloat m, cpFloat r1, cpFloat r2, cpVect offset);
- [x] cpFloat cpAreaForCircle(cpFloat r1, cpFloat r2);
- [x] cpFloat cpMomentForSegment(cpFloat m, cpVect a, cpVect b, cpFloat radius);
- [x] cpFloat cpAreaForSegment(cpVect a, cpVect b, cpFloat radius);
- [ ] cpFloat cpMomentForPoly(cpFloat m, int count, const cpVect *verts, cpVect offset, cpFloat radius);
- [ ] cpFloat cpAreaForPoly(const int count, const cpVect *verts, cpFloat radius);
- [ ] cpVect cpCentroidForPoly(const int count, const cpVect *verts);
- [x] cpFloat cpMomentForBox(cpFloat m, cpFloat width, cpFloat height);
- [x] cpFloat cpMomentForBox2(cpFloat m, cpBB box);
- [ ] int cpConvexHull(int count, const cpVect *verts, cpVect *result, int *first, cpFloat tol);

# chipmunk_unsafe.h
- [ ] void cpCircleShapeSetRadius(cpShape *shape, cpFloat radius);
- [ ] void cpCircleShapeSetOffset(cpShape *shape, cpVect offset);
- [ ] void cpSegmentShapeSetEndpoints(cpShape *shape, cpVect a, cpVect b);
- [ ] void cpSegmentShapeSetRadius(cpShape *shape, cpFloat radius);
- [ ] void cpPolyShapeSetVerts(cpShape *shape, int count, cpVect *verts, cpTransform transform);
- [ ] void cpPolyShapeSetVertsRaw(cpShape *shape, int count, cpVect *verts);
- [ ] void cpPolyShapeSetRadius(cpShape *shape, cpFloat radius);

# cpArbiter.h
- [ ] cpFloat cpArbiterGetRestitution(const cpArbiter *arb);
- [ ] void cpArbiterSetRestitution(cpArbiter *arb, cpFloat restitution);
- [ ] cpFloat cpArbiterGetFriction(const cpArbiter *arb);
- [ ] void cpArbiterSetFriction(cpArbiter *arb, cpFloat friction);
- [ ] cpVect cpArbiterGetSurfaceVelocity(cpArbiter *arb);
- [ ] void cpArbiterSetSurfaceVelocity(cpArbiter *arb, cpVect vr);
- [ ] cpDataPointer cpArbiterGetUserData(const cpArbiter *arb);
- [ ] void cpArbiterSetUserData(cpArbiter *arb, cpDataPointer userData);
- [ ] cpVect cpArbiterTotalImpulse(const cpArbiter *arb);
- [ ] cpFloat cpArbiterTotalKE(const cpArbiter *arb);
- [ ] cpBool cpArbiterIgnore(cpArbiter *arb);
- [ ] void cpArbiterGetShapes(const cpArbiter *arb, cpShape **a, cpShape **b);
- [ ] void cpArbiterGetBodies(const cpArbiter *arb, cpBody **a, cpBody **b);
- [ ] cpContactPointSet cpArbiterGetContactPointSet(const cpArbiter *arb);
- [ ] void cpArbiterSetContactPointSet(cpArbiter *arb, cpContactPointSet *set);
- [ ] cpBool cpArbiterIsFirstContact(const cpArbiter *arb);
- [ ] cpBool cpArbiterIsRemoval(const cpArbiter *arb);
- [ ] int cpArbiterGetCount(const cpArbiter *arb);
- [ ] cpVect cpArbiterGetNormal(const cpArbiter *arb);
- [ ] cpVect cpArbiterGetPointA(const cpArbiter *arb, int i);
- [ ] cpVect cpArbiterGetPointB(const cpArbiter *arb, int i);
- [ ] cpFloat cpArbiterGetDepth(const cpArbiter *arb, int i);
- [ ] cpBool cpArbiterCallWildcardBeginA(cpArbiter *arb, cpSpace *space);
- [ ] cpBool cpArbiterCallWildcardBeginB(cpArbiter *arb, cpSpace *space);
- [ ] cpBool cpArbiterCallWildcardPreSolveA(cpArbiter *arb, cpSpace *space);
- [ ] cpBool cpArbiterCallWildcardPreSolveB(cpArbiter *arb, cpSpace *space);
- [ ] void cpArbiterCallWildcardPostSolveA(cpArbiter *arb, cpSpace *space);
- [ ] void cpArbiterCallWildcardPostSolveB(cpArbiter *arb, cpSpace *space);
- [ ] void cpArbiterCallWildcardSeparateA(cpArbiter *arb, cpSpace *space);
- [ ] void cpArbiterCallWildcardSeparateB(cpArbiter *arb, cpSpace *space);

# cpBody.h
- [ ] cpBody* cpBodyAlloc(void);
- [ ] cpBody* cpBodyInit(cpBody *body, cpFloat mass, cpFloat moment);
- [x] cpBody* cpBodyNew(cpFloat mass, cpFloat moment);
- [ ] cpBody* cpBodyNewKinematic(void);
- [ ] cpBody* cpBodyNewStatic(void);
- [ ] void cpBodyDestroy(cpBody *body);
- [x] void cpBodyFree(cpBody *body);
- [ ] void cpBodyActivate(cpBody *body);
- [ ] void cpBodyActivateStatic(cpBody *body, cpShape *filter);
- [ ] void cpBodySleep(cpBody *body);
- [ ] void cpBodySleepWithGroup(cpBody *body, cpBody *group);
- [ ] cpBool cpBodyIsSleeping(const cpBody *body);
- [x] cpBodyType cpBodyGetType(cpBody *body);
- [x] void cpBodySetType(cpBody *body, cpBodyType type);
- [ ] cpSpace* cpBodyGetSpace(const cpBody *body);
- [ ] cpFloat cpBodyGetMass(const cpBody *body);
- [ ] void cpBodySetMass(cpBody *body, cpFloat m);
- [ ] cpFloat cpBodyGetMoment(const cpBody *body);
- [ ] void cpBodySetMoment(cpBody *body, cpFloat i);
- [x] cpVect cpBodyGetPosition(const cpBody *body);
- [x] void cpBodySetPosition(cpBody *body, cpVect pos);
- [ ] cpVect cpBodyGetCenterOfGravity(const cpBody *body);
- [ ] void cpBodySetCenterOfGravity(cpBody *body, cpVect cog);
- [x] cpVect cpBodyGetVelocity(const cpBody *body);
- [x] void cpBodySetVelocity(cpBody *body, cpVect velocity);
- [x] cpVect cpBodyGetForce(const cpBody *body);
- [x] void cpBodySetForce(cpBody *body, cpVect force);
- [ ] cpFloat cpBodyGetAngle(const cpBody *body);
- [ ] void cpBodySetAngle(cpBody *body, cpFloat a);
- [ ] cpFloat cpBodyGetAngularVelocity(const cpBody *body);
- [ ] void cpBodySetAngularVelocity(cpBody *body, cpFloat angularVelocity);
- [ ] cpFloat cpBodyGetTorque(const cpBody *body);
- [ ] void cpBodySetTorque(cpBody *body, cpFloat torque);
- [ ] cpVect cpBodyGetRotation(const cpBody *body);
- [ ] cpDataPointer cpBodyGetUserData(const cpBody *body);
- [ ] void cpBodySetUserData(cpBody *body, cpDataPointer userData);
- [ ] void cpBodySetVelocityUpdateFunc(cpBody *body, cpBodyVelocityFunc velocityFunc);
- [ ] void cpBodySetPositionUpdateFunc(cpBody *body, cpBodyPositionFunc positionFunc);
- [ ] void cpBodyUpdateVelocity(cpBody *body, cpVect gravity, cpFloat damping, cpFloat dt);
- [ ] void cpBodyUpdatePosition(cpBody *body, cpFloat dt);
- [ ] cpVect cpBodyLocalToWorld(const cpBody *body, const cpVect point);
- [ ] cpVect cpBodyWorldToLocal(const cpBody *body, const cpVect point);
- [ ] void cpBodyApplyForceAtWorldPoint(cpBody *body, cpVect force, cpVect point);
- [ ] void cpBodyApplyForceAtLocalPoint(cpBody *body, cpVect force, cpVect point);
- [ ] void cpBodyApplyImpulseAtWorldPoint(cpBody *body, cpVect impulse, cpVect point);
- [ ] void cpBodyApplyImpulseAtLocalPoint(cpBody *body, cpVect impulse, cpVect point);
- [ ] cpVect cpBodyGetVelocityAtWorldPoint(const cpBody *body, cpVect point);
- [ ] cpVect cpBodyGetVelocityAtLocalPoint(const cpBody *body, cpVect point);
- [ ] cpFloat cpBodyKineticEnergy(const cpBody *body);
- [ ] void cpBodyEachShape(cpBody *body, cpBodyShapeIteratorFunc func, void *data);
- [ ] void cpBodyEachConstraint(cpBody *body, cpBodyConstraintIteratorFunc func, void *data);
- [ ] void cpBodyEachArbiter(cpBody *body, cpBodyArbiterIteratorFunc func, void *data);

# cpConstraint.h
- [ ] void cpConstraintDestroy(cpConstraint *constraint);
- [ ] void cpConstraintFree(cpConstraint *constraint);
- [ ] cpSpace* cpConstraintGetSpace(const cpConstraint *constraint);
- [ ] cpBody* cpConstraintGetBodyA(const cpConstraint *constraint);
- [ ] cpBody* cpConstraintGetBodyB(const cpConstraint *constraint);
- [ ] cpFloat cpConstraintGetMaxForce(const cpConstraint *constraint);
- [ ] void cpConstraintSetMaxForce(cpConstraint *constraint, cpFloat maxForce);
- [ ] cpFloat cpConstraintGetErrorBias(const cpConstraint *constraint);
- [ ] void cpConstraintSetErrorBias(cpConstraint *constraint, cpFloat errorBias);
- [ ] cpFloat cpConstraintGetMaxBias(const cpConstraint *constraint);
- [ ] void cpConstraintSetMaxBias(cpConstraint *constraint, cpFloat maxBias);
- [ ] cpBool cpConstraintGetCollideBodies(const cpConstraint *constraint);
- [ ] void cpConstraintSetCollideBodies(cpConstraint *constraint, cpBool collideBodies);
- [ ] cpConstraintPreSolveFunc cpConstraintGetPreSolveFunc(const cpConstraint *constraint);
- [ ] void cpConstraintSetPreSolveFunc(cpConstraint *constraint, cpConstraintPreSolveFunc preSolveFunc);
- [ ] cpConstraintPostSolveFunc cpConstraintGetPostSolveFunc(const cpConstraint *constraint);
- [ ] void cpConstraintSetPostSolveFunc(cpConstraint *constraint, cpConstraintPostSolveFunc postSolveFunc);
- [ ] cpDataPointer cpConstraintGetUserData(const cpConstraint *constraint);
- [ ] void cpConstraintSetUserData(cpConstraint *constraint, cpDataPointer userData);
- [ ] cpFloat cpConstraintGetImpulse(cpConstraint *constraint);

# cpDampedRotarySpring.h
- [ ] cpBool cpConstraintIsDampedRotarySpring(const cpConstraint *constraint);
- [ ] cpDampedRotarySpring* cpDampedRotarySpringAlloc(void);
- [ ] cpDampedRotarySpring* cpDampedRotarySpringInit(cpDampedRotarySpring *joint, cpBody *a, cpBody *b, cpFloat restAngle, cpFloat stiffness, cpFloat damping);
- [x] cpConstraint* cpDampedRotarySpringNew(cpBody *a, cpBody *b, cpFloat restAngle, cpFloat stiffness, cpFloat damping);
- [ ] cpFloat cpDampedRotarySpringGetRestAngle(const cpConstraint *constraint);
- [ ] void cpDampedRotarySpringSetRestAngle(cpConstraint *constraint, cpFloat restAngle);
- [ ] cpFloat cpDampedRotarySpringGetStiffness(const cpConstraint *constraint);
- [ ] void cpDampedRotarySpringSetStiffness(cpConstraint *constraint, cpFloat stiffness);
- [ ] cpFloat cpDampedRotarySpringGetDamping(const cpConstraint *constraint);
- [ ] void cpDampedRotarySpringSetDamping(cpConstraint *constraint, cpFloat damping);
- [ ] cpDampedRotarySpringTorqueFunc cpDampedRotarySpringGetSpringTorqueFunc(const cpConstraint *constraint);
- [ ] void cpDampedRotarySpringSetSpringTorqueFunc(cpConstraint *constraint, cpDampedRotarySpringTorqueFunc springTorqueFunc);

# cpDampedSpring.h
- [ ] cpBool cpConstraintIsDampedSpring(const cpConstraint *constraint);
- [ ] cpDampedSpring* cpDampedSpringAlloc(void);
- [ ] cpDampedSpring* cpDampedSpringInit(cpDampedSpring *joint, cpBody *a, cpBody *b, cpVect anchorA, cpVect anchorB, cpFloat restLength, cpFloat stiffness, cpFloat damping);
- [x] cpConstraint* cpDampedSpringNew(cpBody *a, cpBody *b, cpVect anchorA, cpVect anchorB, cpFloat restLength, cpFloat stiffness, cpFloat damping);
- [ ] cpVect cpDampedSpringGetAnchorA(const cpConstraint *constraint);
- [ ] void cpDampedSpringSetAnchorA(cpConstraint *constraint, cpVect anchorA);
- [ ] cpVect cpDampedSpringGetAnchorB(const cpConstraint *constraint);
- [ ] void cpDampedSpringSetAnchorB(cpConstraint *constraint, cpVect anchorB);
- [ ] cpFloat cpDampedSpringGetRestLength(const cpConstraint *constraint);
- [ ] void cpDampedSpringSetRestLength(cpConstraint *constraint, cpFloat restLength);
- [ ] cpFloat cpDampedSpringGetStiffness(const cpConstraint *constraint);
- [ ] void cpDampedSpringSetStiffness(cpConstraint *constraint, cpFloat stiffness);
- [ ] cpFloat cpDampedSpringGetDamping(const cpConstraint *constraint);
- [ ] void cpDampedSpringSetDamping(cpConstraint *constraint, cpFloat damping);
- [ ] cpDampedSpringForceFunc cpDampedSpringGetSpringForceFunc(const cpConstraint *constraint);
- [ ] void cpDampedSpringSetSpringForceFunc(cpConstraint *constraint, cpDampedSpringForceFunc springForceFunc);

# cpGearJoint.h
- [ ] cpBool cpConstraintIsGearJoint(const cpConstraint *constraint);
- [ ] cpGearJoint* cpGearJointAlloc(void);
- [ ] cpGearJoint* cpGearJointInit(cpGearJoint *joint, cpBody *a, cpBody *b, cpFloat phase, cpFloat ratio);
- [x] cpConstraint* cpGearJointNew(cpBody *a, cpBody *b, cpFloat phase, cpFloat ratio);
- [ ] cpFloat cpGearJointGetPhase(const cpConstraint *constraint);
- [ ] void cpGearJointSetPhase(cpConstraint *constraint, cpFloat phase);
- [ ] cpFloat cpGearJointGetRatio(const cpConstraint *constraint);
- [ ] void cpGearJointSetRatio(cpConstraint *constraint, cpFloat ratio);

# cpGrooveJoint.h
- [ ] cpBool cpConstraintIsGrooveJoint(const cpConstraint *constraint);
- [ ] cpGrooveJoint* cpGrooveJointAlloc(void);
- [ ] cpGrooveJoint* cpGrooveJointInit(cpGrooveJoint *joint, cpBody *a, cpBody *b, cpVect groove_a, cpVect groove_b, cpVect anchorB);
- [x] cpConstraint* cpGrooveJointNew(cpBody *a, cpBody *b, cpVect groove_a, cpVect groove_b, cpVect anchorB);
- [ ] cpVect cpGrooveJointGetGrooveA(const cpConstraint *constraint);
- [ ] void cpGrooveJointSetGrooveA(cpConstraint *constraint, cpVect grooveA);
- [ ] cpVect cpGrooveJointGetGrooveB(const cpConstraint *constraint);
- [ ] void cpGrooveJointSetGrooveB(cpConstraint *constraint, cpVect grooveB);
- [ ] cpVect cpGrooveJointGetAnchorB(const cpConstraint *constraint);
- [ ] void cpGrooveJointSetAnchorB(cpConstraint *constraint, cpVect anchorB);

# cpHastySpace.h
- [ ] cpSpace *cpHastySpaceNew(void);
- [ ] void cpHastySpaceFree(cpSpace *space);
- [ ] void cpHastySpaceSetThreads(cpSpace *space, unsigned long threads);
- [ ] unsigned long cpHastySpaceGetThreads(cpSpace *space);
- [ ] void cpHastySpaceStep(cpSpace *space, cpFloat dt);

# cpMarch.h
- [ ] void cpMarchSoft(
- [ ] void cpMarchHard(

# cpPinJoint.h
- [ ] cpBool cpConstraintIsPinJoint(const cpConstraint *constraint);
- [ ] cpPinJoint* cpPinJointAlloc(void);
- [ ] cpPinJoint* cpPinJointInit(cpPinJoint *joint, cpBody *a, cpBody *b, cpVect anchorA, cpVect anchorB);
- [x] cpConstraint* cpPinJointNew(cpBody *a, cpBody *b, cpVect anchorA, cpVect anchorB);
- [ ] cpVect cpPinJointGetAnchorA(const cpConstraint *constraint);
- [ ] void cpPinJointSetAnchorA(cpConstraint *constraint, cpVect anchorA);
- [ ] cpVect cpPinJointGetAnchorB(const cpConstraint *constraint);
- [ ] void cpPinJointSetAnchorB(cpConstraint *constraint, cpVect anchorB);
- [ ] cpFloat cpPinJointGetDist(const cpConstraint *constraint);
- [ ] void cpPinJointSetDist(cpConstraint *constraint, cpFloat dist);

# cpPivotJoint.h
- [ ] cpBool cpConstraintIsPivotJoint(const cpConstraint *constraint);
- [ ] cpPivotJoint* cpPivotJointAlloc(void);
- [ ] cpPivotJoint* cpPivotJointInit(cpPivotJoint *joint, cpBody *a, cpBody *b, cpVect anchorA, cpVect anchorB);
- [x] cpConstraint* cpPivotJointNew(cpBody *a, cpBody *b, cpVect pivot);
- [ ] cpConstraint* cpPivotJointNew2(cpBody *a, cpBody *b, cpVect anchorA, cpVect anchorB);
- [ ] cpVect cpPivotJointGetAnchorA(const cpConstraint *constraint);
- [ ] void cpPivotJointSetAnchorA(cpConstraint *constraint, cpVect anchorA);
- [ ] cpVect cpPivotJointGetAnchorB(const cpConstraint *constraint);
- [ ] void cpPivotJointSetAnchorB(cpConstraint *constraint, cpVect anchorB);

# cpPolyline.h
- [ ] void cpPolylineFree(cpPolyline *line);
- [ ] cpBool cpPolylineIsClosed(cpPolyline *line);
- [ ] cpPolyline *cpPolylineSimplifyCurves(cpPolyline *line, cpFloat tol);
- [ ] cpPolyline *cpPolylineSimplifyVertexes(cpPolyline *line, cpFloat tol);
- [ ] cpPolyline *cpPolylineToConvexHull(cpPolyline *line, cpFloat tol);
- [ ] cpPolylineSet *cpPolylineSetAlloc(void);
- [ ] cpPolylineSet *cpPolylineSetInit(cpPolylineSet *set);
- [ ] cpPolylineSet *cpPolylineSetNew(void);
- [ ] void cpPolylineSetDestroy(cpPolylineSet *set, cpBool freePolylines);
- [ ] void cpPolylineSetFree(cpPolylineSet *set, cpBool freePolylines);
- [ ] void cpPolylineSetCollectSegment(cpVect v0, cpVect v1, cpPolylineSet *lines);
- [ ] cpPolylineSet *cpPolylineConvexDecomposition(cpPolyline *line, cpFloat tol);

# cpPolyShape.h
- [ ] cpPolyShape* cpPolyShapeAlloc(void);
- [ ] cpPolyShape* cpPolyShapeInit(cpPolyShape *poly, cpBody *body, int count, const cpVect *verts, cpTransform transform, cpFloat radius);
- [ ] cpPolyShape* cpPolyShapeInitRaw(cpPolyShape *poly, cpBody *body, int count, const cpVect *verts, cpFloat radius);
- [ ] cpShape* cpPolyShapeNew(cpBody *body, int count, const cpVect *verts, cpTransform transform, cpFloat radius);
- [ ] cpShape* cpPolyShapeNewRaw(cpBody *body, int count, const cpVect *verts, cpFloat radius);
- [ ] cpPolyShape* cpBoxShapeInit(cpPolyShape *poly, cpBody *body, cpFloat width, cpFloat height, cpFloat radius);
- [ ] cpPolyShape* cpBoxShapeInit2(cpPolyShape *poly, cpBody *body, cpBB box, cpFloat radius);
- [x] cpShape* cpBoxShapeNew(cpBody *body, cpFloat width, cpFloat height, cpFloat radius);
- [x] cpShape* cpBoxShapeNew2(cpBody *body, cpBB box, cpFloat radius);
- [ ] int cpPolyShapeGetCount(const cpShape *shape);
- [ ] cpVect cpPolyShapeGetVert(const cpShape *shape, int index);
- [ ] cpFloat cpPolyShapeGetRadius(const cpShape *shape);

# cpRatchetJoint.h
- [ ] cpBool cpConstraintIsRatchetJoint(const cpConstraint *constraint);
- [ ] cpRatchetJoint* cpRatchetJointAlloc(void);
- [ ] cpRatchetJoint* cpRatchetJointInit(cpRatchetJoint *joint, cpBody *a, cpBody *b, cpFloat phase, cpFloat ratchet);
- [x] cpConstraint* cpRatchetJointNew(cpBody *a, cpBody *b, cpFloat phase, cpFloat ratchet);
- [ ] cpFloat cpRatchetJointGetAngle(const cpConstraint *constraint);
- [ ] void cpRatchetJointSetAngle(cpConstraint *constraint, cpFloat angle);
- [ ] cpFloat cpRatchetJointGetPhase(const cpConstraint *constraint);
- [ ] void cpRatchetJointSetPhase(cpConstraint *constraint, cpFloat phase);
- [ ] cpFloat cpRatchetJointGetRatchet(const cpConstraint *constraint);
- [ ] void cpRatchetJointSetRatchet(cpConstraint *constraint, cpFloat ratchet);

# cpRotaryLimitJoint.h
- [ ] cpBool cpConstraintIsRotaryLimitJoint(const cpConstraint *constraint);
- [ ] cpRotaryLimitJoint* cpRotaryLimitJointAlloc(void);
- [ ] cpRotaryLimitJoint* cpRotaryLimitJointInit(cpRotaryLimitJoint *joint, cpBody *a, cpBody *b, cpFloat min, cpFloat max);
- [ ] cpConstraint* cpRotaryLimitJointNew(cpBody *a, cpBody *b, cpFloat min, cpFloat max);
- [ ] cpFloat cpRotaryLimitJointGetMin(const cpConstraint *constraint);
- [ ] void cpRotaryLimitJointSetMin(cpConstraint *constraint, cpFloat min);
- [ ] cpFloat cpRotaryLimitJointGetMax(const cpConstraint *constraint);
- [ ] void cpRotaryLimitJointSetMax(cpConstraint *constraint, cpFloat max);

# cpShape.h
- [ ] void cpShapeDestroy(cpShape *shape);
- [x] void cpShapeFree(cpShape *shape);
- [ ] cpBB cpShapeCacheBB(cpShape *shape);
- [ ] cpBB cpShapeUpdate(cpShape *shape, cpTransform transform);
- [ ] cpFloat cpShapePointQuery(const cpShape *shape, cpVect p, cpPointQueryInfo *out);
- [ ] cpBool cpShapeSegmentQuery(const cpShape *shape, cpVect a, cpVect b, cpFloat radius, cpSegmentQueryInfo *info);
- [ ] cpContactPointSet cpShapesCollide(const cpShape *a, const cpShape *b);
- [ ] cpSpace* cpShapeGetSpace(const cpShape *shape);
- [ ] cpBody* cpShapeGetBody(const cpShape *shape);
- [ ] void cpShapeSetBody(cpShape *shape, cpBody *body);
- [ ] cpFloat cpShapeGetMass(cpShape *shape);
- [ ] void cpShapeSetMass(cpShape *shape, cpFloat mass);
- [ ] cpFloat cpShapeGetDensity(cpShape *shape);
- [ ] void cpShapeSetDensity(cpShape *shape, cpFloat density);
- [ ] cpFloat cpShapeGetMoment(cpShape *shape);
- [ ] cpFloat cpShapeGetArea(cpShape *shape);
- [ ] cpVect cpShapeGetCenterOfGravity(cpShape *shape);
- [ ] cpBB cpShapeGetBB(const cpShape *shape);
- [ ] cpBool cpShapeGetSensor(const cpShape *shape);
- [ ] void cpShapeSetSensor(cpShape *shape, cpBool sensor);
- [x] cpFloat cpShapeGetElasticity(const cpShape *shape);
- [x] void cpShapeSetElasticity(cpShape *shape, cpFloat elasticity);
- [x] cpFloat cpShapeGetFriction(const cpShape *shape);
- [x] void cpShapeSetFriction(cpShape *shape, cpFloat friction);
- [ ] cpVect cpShapeGetSurfaceVelocity(const cpShape *shape);
- [ ] void cpShapeSetSurfaceVelocity(cpShape *shape, cpVect surfaceVelocity);
- [ ] cpDataPointer cpShapeGetUserData(const cpShape *shape);
- [ ] void cpShapeSetUserData(cpShape *shape, cpDataPointer userData);
- [ ] cpCollisionType cpShapeGetCollisionType(const cpShape *shape);
- [ ] void cpShapeSetCollisionType(cpShape *shape, cpCollisionType collisionType);
- [x] cpShapeFilter cpShapeGetFilter(const cpShape *shape);
- [x] void cpShapeSetFilter(cpShape *shape, cpShapeFilter filter);
- [ ] cpCircleShape* cpCircleShapeAlloc(void);
- [ ] cpCircleShape* cpCircleShapeInit(cpCircleShape *circle, cpBody *body, cpFloat radius, cpVect offset);
- [x] cpShape* cpCircleShapeNew(cpBody *body, cpFloat radius, cpVect offset);
- [x] cpVect cpCircleShapeGetOffset(const cpShape *shape);
- [x] cpFloat cpCircleShapeGetRadius(const cpShape *shape);
- [ ] cpSegmentShape* cpSegmentShapeAlloc(void);
- [ ] cpSegmentShape* cpSegmentShapeInit(cpSegmentShape *seg, cpBody *body, cpVect a, cpVect b, cpFloat radius);
- [x] cpShape* cpSegmentShapeNew(cpBody *body, cpVect a, cpVect b, cpFloat radius);
- [ ] void cpSegmentShapeSetNeighbors(cpShape *shape, cpVect prev, cpVect next);
- [ ] cpVect cpSegmentShapeGetA(const cpShape *shape);
- [ ] cpVect cpSegmentShapeGetB(const cpShape *shape);
- [ ] cpVect cpSegmentShapeGetNormal(const cpShape *shape);
- [ ] cpFloat cpSegmentShapeGetRadius(const cpShape *shape);

# cpSimpleMotor.h
- [ ] cpBool cpConstraintIsSimpleMotor(const cpConstraint *constraint);
- [ ] cpSimpleMotor* cpSimpleMotorAlloc(void);
- [ ] cpSimpleMotor* cpSimpleMotorInit(cpSimpleMotor *joint, cpBody *a, cpBody *b, cpFloat rate);
- [x] cpConstraint* cpSimpleMotorNew(cpBody *a, cpBody *b, cpFloat rate);
- [ ] cpFloat cpSimpleMotorGetRate(const cpConstraint *constraint);
- [ ] void cpSimpleMotorSetRate(cpConstraint *constraint, cpFloat rate);

# cpSlideJoint.h
- [ ] cpBool cpConstraintIsSlideJoint(const cpConstraint *constraint);
- [ ] cpSlideJoint* cpSlideJointAlloc(void);
- [ ] cpSlideJoint* cpSlideJointInit(cpSlideJoint *joint, cpBody *a, cpBody *b, cpVect anchorA, cpVect anchorB, cpFloat min, cpFloat max);
- [x] cpConstraint* cpSlideJointNew(cpBody *a, cpBody *b, cpVect anchorA, cpVect anchorB, cpFloat min, cpFloat max);
- [ ] cpVect cpSlideJointGetAnchorA(const cpConstraint *constraint);
- [ ] void cpSlideJointSetAnchorA(cpConstraint *constraint, cpVect anchorA);
- [ ] cpVect cpSlideJointGetAnchorB(const cpConstraint *constraint);
- [ ] void cpSlideJointSetAnchorB(cpConstraint *constraint, cpVect anchorB);
- [ ] cpFloat cpSlideJointGetMin(const cpConstraint *constraint);
- [ ] void cpSlideJointSetMin(cpConstraint *constraint, cpFloat min);
- [ ] cpFloat cpSlideJointGetMax(const cpConstraint *constraint);
- [ ] void cpSlideJointSetMax(cpConstraint *constraint, cpFloat max);

# cpSpace.h
- [ ]cpSpace* cpSpaceAlloc(void);
- [ ] cpSpace* cpSpaceInit(cpSpace *space);
- [x] cpSpace* cpSpaceNew(void);
- [ ] void cpSpaceDestroy(cpSpace *space);
- [x] void cpSpaceFree(cpSpace *space);
- [ ] int cpSpaceGetIterations(const cpSpace *space);
- [x] void cpSpaceSetIterations(cpSpace *space, int iterations);
- [x] cpVect cpSpaceGetGravity(const cpSpace *space);
- [x] void cpSpaceSetGravity(cpSpace *space, cpVect gravity);
- [ ] cpFloat cpSpaceGetDamping(const cpSpace *space);
- [ ] void cpSpaceSetDamping(cpSpace *space, cpFloat damping);
- [ ] cpFloat cpSpaceGetIdleSpeedThreshold(const cpSpace *space);
- [ ] void cpSpaceSetIdleSpeedThreshold(cpSpace *space, cpFloat idleSpeedThreshold);
- [ ] cpFloat cpSpaceGetSleepTimeThreshold(const cpSpace *space);
- [x] void cpSpaceSetSleepTimeThreshold(cpSpace *space, cpFloat sleepTimeThreshold);
- [ ] cpFloat cpSpaceGetCollisionSlop(const cpSpace *space);
- [ ] void cpSpaceSetCollisionSlop(cpSpace *space, cpFloat collisionSlop);
- [ ] cpFloat cpSpaceGetCollisionBias(const cpSpace *space);
- [ ] void cpSpaceSetCollisionBias(cpSpace *space, cpFloat collisionBias);
- [ ] cpTimestamp cpSpaceGetCollisionPersistence(const cpSpace *space);
- [ ] void cpSpaceSetCollisionPersistence(cpSpace *space, cpTimestamp collisionPersistence);
- [ ] cpDataPointer cpSpaceGetUserData(const cpSpace *space);
- [ ] void cpSpaceSetUserData(cpSpace *space, cpDataPointer userData);
- [x] cpBody* cpSpaceGetStaticBody(const cpSpace *space);
- [ ] cpFloat cpSpaceGetCurrentTimeStep(const cpSpace *space);
- [ ] cpBool cpSpaceIsLocked(cpSpace *space);
- [ ] cpCollisionHandler *cpSpaceAddDefaultCollisionHandler(cpSpace *space);
- [ ] cpCollisionHandler *cpSpaceAddCollisionHandler(cpSpace *space, cpCollisionType a, cpCollisionType b);
- [ ] cpCollisionHandler *cpSpaceAddWildcardHandler(cpSpace *space, cpCollisionType type);
- [x] cpShape* cpSpaceAddShape(cpSpace *space, cpShape *shape);
- [x] cpBody* cpSpaceAddBody(cpSpace *space, cpBody *body);
- [x] cpConstraint* cpSpaceAddConstraint(cpSpace *space, cpConstraint *constraint);
- [ ] void cpSpaceRemoveShape(cpSpace *space, cpShape *shape);
- [ ] void cpSpaceRemoveBody(cpSpace *space, cpBody *body);
- [ ] void cpSpaceRemoveConstraint(cpSpace *space, cpConstraint *constraint);
- [ ] cpBool cpSpaceContainsShape(cpSpace *space, cpShape *shape);
- [ ] cpBool cpSpaceContainsBody(cpSpace *space, cpBody *body);
- [ ] cpBool cpSpaceContainsConstraint(cpSpace *space, cpConstraint *constraint);
- [ ] cpBool cpSpaceAddPostStepCallback(cpSpace *space, cpPostStepFunc func, void *key, void *data);
- [ ] void cpSpacePointQuery(cpSpace *space, cpVect point, cpFloat maxDistance, cpShapeFilter filter, cpSpacePointQueryFunc func, void *data);
- [ ] cpShape *cpSpacePointQueryNearest(cpSpace *space, cpVect point, cpFloat maxDistance, cpShapeFilter filter, cpPointQueryInfo *out);
- [ ] void cpSpaceSegmentQuery(cpSpace *space, cpVect start, cpVect end, cpFloat radius, cpShapeFilter filter, cpSpaceSegmentQueryFunc func, void *data);
- [ ] cpShape *cpSpaceSegmentQueryFirst(cpSpace *space, cpVect start, cpVect end, cpFloat radius, cpShapeFilter filter, cpSegmentQueryInfo *out);
- [ ] void cpSpaceBBQuery(cpSpace *space, cpBB bb, cpShapeFilter filter, cpSpaceBBQueryFunc func, void *data);
- [ ] cpBool cpSpaceShapeQuery(cpSpace *space, cpShape *shape, cpSpaceShapeQueryFunc func, void *data);
- [ ] void cpSpaceEachBody(cpSpace *space, cpSpaceBodyIteratorFunc func, void *data);
- [ ] void cpSpaceEachShape(cpSpace *space, cpSpaceShapeIteratorFunc func, void *data);
- [ ] void cpSpaceEachConstraint(cpSpace *space, cpSpaceConstraintIteratorFunc func, void *data);
- [ ] void cpSpaceReindexStatic(cpSpace *space);
- [ ] void cpSpaceReindexShape(cpSpace *space, cpShape *shape);
- [ ] void cpSpaceReindexShapesForBody(cpSpace *space, cpBody *body);
- [ ] void cpSpaceUseSpatialHash(cpSpace *space, cpFloat dim, int count);
- [x] void cpSpaceStep(cpSpace *space, cpFloat dt);
- [ ] void cpSpaceDebugDraw(cpSpace *space, cpSpaceDebugDrawOptions *options);

# cpSpatialIndex.h
- [ ] cpSpaceHash* cpSpaceHashAlloc(void);
- [ ] cpSpatialIndex* cpSpaceHashInit(cpSpaceHash *hash, cpFloat celldim, int numcells, cpSpatialIndexBBFunc bbfunc, cpSpatialIndex *staticIndex);
- [ ] cpSpatialIndex* cpSpaceHashNew(cpFloat celldim, int cells, cpSpatialIndexBBFunc bbfunc, cpSpatialIndex *staticIndex);
- [ ] void cpSpaceHashResize(cpSpaceHash *hash, cpFloat celldim, int numcells);
- [ ] cpBBTree* cpBBTreeAlloc(void);
- [ ] cpSpatialIndex* cpBBTreeInit(cpBBTree *tree, cpSpatialIndexBBFunc bbfunc, cpSpatialIndex *staticIndex);
- [ ] cpSpatialIndex* cpBBTreeNew(cpSpatialIndexBBFunc bbfunc, cpSpatialIndex *staticIndex);
- [ ] void cpBBTreeOptimize(cpSpatialIndex *index);
- [ ] void cpBBTreeSetVelocityFunc(cpSpatialIndex *index, cpBBTreeVelocityFunc func);
- [ ] cpSweep1D* cpSweep1DAlloc(void);
- [ ] cpSpatialIndex* cpSweep1DInit(cpSweep1D *sweep, cpSpatialIndexBBFunc bbfunc, cpSpatialIndex *staticIndex);
- [ ] cpSpatialIndex* cpSweep1DNew(cpSpatialIndexBBFunc bbfunc, cpSpatialIndex *staticIndex);
- [ ] void cpSpatialIndexFree(cpSpatialIndex *index);
- [ ] void cpSpatialIndexCollideStatic(cpSpatialIndex *dynamicIndex, cpSpatialIndex *staticIndex, cpSpatialIndexQueryFunc func, void *data);
