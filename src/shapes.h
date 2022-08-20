static Janet cfun_moment_for_circle(int32_t argc, Janet *argv) {
  janet_fixarity(argc, 4);

  float mass = janet_getnumber(argv, 0);
  float r1 = janet_getnumber(argv, 1);
  float r2 = janet_getnumber(argv, 2);
  cpVect offset = cp_getvec2(argv, 3);

  float moment = cpMomentForCircle(mass, r1, r2, offset);
  return janet_wrap_number(moment);
}

static Janet cfun_moment_for_box(int32_t argc, Janet *argv) {
  janet_fixarity(argc, 3);

  float mass = janet_getnumber(argv, 0);
  float width = janet_getnumber(argv, 1);
  float height = janet_getnumber(argv, 2);

  float moment = cpMomentForBox(mass, width, height);
  return janet_wrap_number(moment);
}

static Janet cfun_segment_shape_new(int32_t argc, Janet *argv) {
  janet_fixarity(argc, 4);

  cpBody *body = cp_getbody(argv, 0);
  cpVect a = cp_getvec2(argv, 1);
  cpVect b = cp_getvec2(argv, 2);
  float radius = janet_getnumber(argv, 3);

  cpShape *shape = cpSegmentShapeNew(body, a, b, radius);
  return cp_wrap_shape(shape);
}

static Janet cfun_circle_shape_new(int32_t argc, Janet *argv) {
  janet_fixarity(argc, 3);

  cpBody *body = cp_getbody(argv, 0);
  float radius = janet_getnumber(argv, 1);
  cpVect offset = cp_getvec2(argv, 2);

  cpShape *shape = cpCircleShapeNew(body, radius, offset);
  return cp_wrap_shape(shape);
}

static Janet cfun_box_shape_new(int32_t argc, Janet *argv) {
  janet_fixarity(argc, 4);

  cpBody *body = cp_getbody(argv, 0);
  float width = janet_getnumber(argv, 1);
  float height = janet_getnumber(argv, 2);
  float radius = janet_getnumber(argv, 3);

  cpShape *shape = cpBoxShapeNew(body, width, height, radius);
  return cp_wrap_shape(shape);
}

static Janet cfun_shape_get_elasticity(int32_t argc, Janet *argv)  {
  janet_fixarity(argc, 1);
  cpShape *shape = cp_getshape(argv, 0);
  float elasticity = cpShapeGetElasticity(shape);
  return janet_wrap_number(elasticity);
}

static Janet cfun_shape_set_elasticity(int32_t argc, Janet *argv)  {
  janet_fixarity(argc, 2);
  cpShape *shape = cp_getshape(argv, 0);
  float value = janet_getnumber(argv, 1);
  cpShapeSetElasticity(shape, value);
  return janet_wrap_nil();
}

static Janet cfun_shape_get_friction(int32_t argc, Janet *argv)  {
  janet_fixarity(argc, 1);
  cpShape *shape = cp_getshape(argv, 0);
  float friction = cpShapeGetFriction(shape);
  return janet_wrap_number(friction);
}

static Janet cfun_shape_set_friction(int32_t argc, Janet *argv)  {
  janet_fixarity(argc, 2);
  cpShape *shape = cp_getshape(argv, 0);
  float value = janet_getnumber(argv, 1);
  cpShapeSetFriction(shape, value);
  return janet_wrap_nil();
}

static Janet cfun_shape_free(int32_t argc, Janet *argv)  {
  janet_fixarity(argc, 1);
  cpShape *shape = cp_getshape(argv, 0);
  cpShapeFree(shape);
  return janet_wrap_nil();
}

static JanetReg shapes_cfuns[] = {
  {"moment-for-circle", cfun_moment_for_circle, "(chipmunk/moment-for-circle mass r1 r2 offset)"},
  {"moment-for-box", cfun_moment_for_box, "(chipmunk/moment-for-box mass width height)"},
  {"segment-shape-new", cfun_segment_shape_new, "(chipmunk/segment-shape-new body vec-a vec-b radius)"},
  {"circle-shape-new", cfun_circle_shape_new, "(chipmunk/circle-shape-new body radius offset)"},
  {"box-shape-new", cfun_box_shape_new, "(chipmunk/box-shape-new body width height radius)"},
  {"shape-get-elasticity", cfun_shape_get_elasticity, "(chipmunk/shape-get-elasticity shape)"},
  {"shape-set-elasticity", cfun_shape_set_elasticity, "(chipmunk/shape-set-elasticity shape value)"},
  {"shape-get-friction", cfun_shape_get_friction, "(chipmunk/shape-get-friction shape)"},
  {"shape-set-friction", cfun_shape_set_friction, "(chipmunk/shape-set-friction shape value)"},
  {"shape-free", cfun_shape_free, "(chipmunk/shape-free shape)"},
  {NULL, NULL, NULL}
};
