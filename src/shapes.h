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
  {"segment-shape-new", cfun_segment_shape_new, "(chipmunk/segment-shape-new body vec-a vec-b radius)"},
  {"circle-shape-new", cfun_circle_shape_new, "(chipmunk/circle-shape-new body radius offset)"},
  {"shape-set-friction", cfun_shape_set_friction, "(chipmunk/shape-set-friction shape value)"},
  {"shape-free", cfun_shape_free, "(chipmunk/shape-free shape)"},
  {NULL, NULL, NULL}
};
