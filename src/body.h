static Janet cfun_moment_for_circle(int32_t argc, Janet *argv) {
  janet_fixarity(argc, 4);

  float mass = janet_getnumber(argv, 0);
  float r1 = janet_getnumber(argv, 1);
  float r2 = janet_getnumber(argv, 2);
  cpVect offset = cp_getvec2(argv, 3);

  float moment = cpMomentForCircle(mass, r1, r2, offset);
  return janet_wrap_number(moment);
}

static Janet cfun_body_new(int32_t argc, Janet *argv) {
  janet_fixarity(argc, 2);
  float mass = janet_getnumber(argv, 0);
  float inertia = janet_getnumber(argv, 1);
  cpBody *body = cpBodyNew(mass, inertia);
  return cp_wrap_body(body);
}

static Janet cfun_body_set_position(int32_t argc, Janet *argv) {
  janet_fixarity(argc, 2);
  cpBody *body = cp_getbody(argv, 0);
  cpVect position = cp_getvec2(argv, 1);
  cpBodySetPosition(body, position);
  return janet_wrap_nil();
}
static Janet cfun_body_set_velocity(int32_t argc, Janet *argv) {
  janet_fixarity(argc, 2);
  cpBody *body = cp_getbody(argv, 0);
  cpVect velocity = cp_getvec2(argv, 1);
  cpBodySetVelocity(body, velocity);
  return janet_wrap_nil();
}

static Janet cfun_body_get_position(int32_t argc, Janet *argv) {
  janet_fixarity(argc, 1);
  cpBody *body = cp_getbody(argv, 0);
  cpVect position = cpBodyGetPosition(body);
  return cp_wrap_vec2(position);
}

static Janet cfun_body_get_velocity(int32_t argc, Janet *argv) {
  janet_fixarity(argc, 1);
  cpBody *body = cp_getbody(argv, 0);
  cpVect velocity = cpBodyGetVelocity(body);
  return cp_wrap_vec2(velocity);
}

static Janet cfun_body_free(int32_t argc, Janet *argv) {
  janet_fixarity(argc, 1);
  cpBody *body = cp_getbody(argv, 0);
  cpBodyFree(body);
  return janet_wrap_nil();
}
static JanetReg body_cfuns[] = {
  {"moment-for-circle", cfun_moment_for_circle, "(chipmunk/moment-for-circle mass r1 r2 offset)"},
  {"body-new", cfun_body_new, "(chipmunk/body-new mass inertia)"},
  {"body-set-position", cfun_body_set_position, "(chipmunk/body-set-position body [1 2])"},
  {"body-set-velocity", cfun_body_set_velocity, "(chipmunk/body-set-velocity body [1 2])"},
  {"body-get-position", cfun_body_get_position, "(chipmunk/body-get-position body)"},
  {"body-get-velocity", cfun_body_get_velocity, "(chipmunk/body-get-velocity body)"},
  {"body-free", cfun_body_free, "(chipmunk/body-free body)"},
  {NULL, NULL, NULL}
};
