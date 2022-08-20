static Janet cfun_space_new(int32_t argc, Janet *argv) {
  janet_fixarity(argc, 0);
  (void) argv;
  cpSpace *space = cpSpaceNew();
  return cp_wrap_space(space);
}

static Janet cfun_space_set_gravity(int32_t argc, Janet *argv) {
  janet_fixarity(argc, 2);
  cpSpace *space = cp_getspace(argv, 0);
  cpVect gravity = cp_getvec2(argv, 1);
  cpSpaceSetGravity(space, gravity);
  return janet_wrap_nil();
}

static Janet cfun_space_get_static_body(int32_t argc, Janet *argv) {
  janet_fixarity(argc, 1);
  cpSpace *space = cp_getspace(argv, 0);
  cpBody *body = cpSpaceGetStaticBody(space);
  return cp_wrap_body(body);
}

static Janet cfun_space_add_shape(int32_t argc, Janet *argv) {
  janet_fixarity(argc, 2);
  cpSpace *space = cp_getspace(argv, 0);
  cpShape *shape = cp_getshape(argv, 1);

  cpSpaceAddShape(space, shape);

  ShapeWrapper *wrapper = janet_getabstract(argv, 1, &AT_Shape);
  janet_wrap_abstract(wrapper);
}

static Janet cfun_space_add_body(int32_t argc, Janet *argv) {
  janet_fixarity(argc, 2);
  cpSpace *space = cp_getspace(argv, 0);
  cpBody *body = cp_getbody(argv, 1);

  cpSpaceAddBody(space, body);

  BodyWrapper *wrapper = janet_getabstract(argv, 1, &AT_Body);
  janet_wrap_abstract(wrapper);
}

static Janet cfun_space_step(int32_t argc, Janet *argv) {
  janet_fixarity(argc, 2);
  cpSpace *space = cp_getspace(argv, 0);
  float dt = janet_getnumber(argv, 1);
  cpSpaceStep(space, dt);
  return janet_wrap_nil();
}

static Janet cfun_space_free(int32_t argc, Janet *argv) {
  janet_fixarity(argc, 1);
  cpSpace *space = cp_getspace(argv, 0);
  cpSpaceFree(space);
  return janet_wrap_nil();
}

static JanetReg spaces_cfuns[] = {
  {"space-new", cfun_space_new, "(chipmunk/space-new)"},
  {"space-set-gravity", cfun_space_set_gravity, "(chipmunk/space-set-gravity [0 -10])"},
  {"space-get-static-body", cfun_space_get_static_body, "(chipmunk/space-get-static-body space)"},
  {"space-add-shape", cfun_space_add_shape, "(chipmunk/space-add-shape space shape)"},
  {"space-add-body", cfun_space_add_body, "(chipmunk/space-add-body space body)"},
  {"space-step", cfun_space_step, "(chipmunk/space-step space dt)"},
  {"space-free", cfun_space_free, "(chipmunk/space-free)"},
  {NULL, NULL, NULL}
};
