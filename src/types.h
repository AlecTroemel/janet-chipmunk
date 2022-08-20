// NOTE: Most chipmunk creation functions return pointers to the actual struct,
//       so we need to wrap them in our own struct to get abstract class niceties.

static float idx_getfloat(JanetView idx, int index) {
  if (index >= idx.len) {
    janet_panicf("index %d outside of range [0, %d)", idx.len);
  }
  if (!janet_checktype(idx.items[index], JANET_NUMBER)) {
    janet_panicf("expected number, got %v", idx.items[index]);
  }
  return (float) janet_unwrap_number(idx.items[index]);
}

static cpVect cp_getvec2(const Janet *argv, int32_t n) {
  JanetView idx = janet_getindexed(argv, n);
  return cpv(idx_getfloat(idx, 0), idx_getfloat(idx, 1));
}

static Janet cp_wrap_vec2(cpVect x) {
  Janet *tup = janet_tuple_begin(2);
  tup[0] = janet_wrap_number(x.x);
  tup[1] = janet_wrap_number(x.y);
  return janet_wrap_tuple(janet_tuple_end(tup));
}

static cpVect physac_unwrap_vec2(const Janet val) {
  const Janet *tup = janet_unwrap_tuple(val);
  float x = janet_unwrap_number(tup[0]);
  float y = janet_unwrap_number(tup[1]);
  return cpv(x, y);
}

// wrapper structs
typedef struct { cpSpace *handle; } SpaceWrapper;
typedef struct { cpBody *handle; } BodyWrapper;
typedef struct { cpShape *handle; } ShapeWrapper;

// Abstract type implementations

// Space
int space_get(void *p, Janet key, Janet *out);
void space_put(void *p, Janet key, Janet value);

static const JanetAbstractType AT_Space = {
  "chipmunk/space",
  NULL,
  NULL,
  space_get,
  space_put,
  JANET_ATEND_PUT
};

int space_get(void *p, Janet key, Janet *out) {
  return 0;
}

void space_put(void *p, Janet key, Janet value) {

}

static Janet cp_wrap_space(cpSpace *space) {
  SpaceWrapper *wrapper = janet_abstract(&AT_Space, sizeof(SpaceWrapper));
  wrapper->handle = space;
  return janet_wrap_abstract(wrapper);
}

static cpSpace *cp_getspace(const Janet *argv, int32_t n) {
  SpaceWrapper *wrapper = janet_getabstract(argv, n, &AT_Space);
  return wrapper->handle;
}

// Body
int body_get(void *p, Janet key, Janet *out);
void body_put(void *p, Janet key, Janet value);

static const JanetAbstractType AT_Body = {
  "chipmunk/body",
  NULL,
  NULL,
  body_get,
  body_put,
  JANET_ATEND_PUT
};

int body_get(void *p, Janet key, Janet *out) {
  return 0;
}

void body_put(void *p, Janet key, Janet value) {

}

static Janet cp_wrap_body(cpBody *body) {
  BodyWrapper *wrapper = janet_abstract(&AT_Body, sizeof(BodyWrapper));
  wrapper->handle = body;
  return janet_wrap_abstract(wrapper);
}

static cpBody *cp_getbody(const Janet *argv, int32_t n) {
  BodyWrapper *wrapper = janet_getabstract(argv, n, &AT_Body);
  return wrapper->handle;
}

// Shape
int shape_get(void *p, Janet key, Janet *out);
void shape_put(void *p, Janet key, Janet value);

static const JanetAbstractType AT_Shape = {
  "chipmunk/shape",
  NULL,
  NULL,
  shape_get,
  shape_put,
  JANET_ATEND_PUT
};

int shape_get(void *p, Janet key, Janet *out) {
  return 0;
}

void shape_put(void *p, Janet key, Janet value) {

}

static Janet cp_wrap_shape(cpShape *shape) {
  ShapeWrapper *wrapper = janet_abstract(&AT_Shape, sizeof(ShapeWrapper));
  wrapper->handle = shape;
  return janet_wrap_abstract(wrapper);
}

static cpShape *cp_getshape(const Janet *argv, int32_t n) {
  ShapeWrapper *wrapper = janet_getabstract(argv, n, &AT_Shape);
  return wrapper->handle;
}
