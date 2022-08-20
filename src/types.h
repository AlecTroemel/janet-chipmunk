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

// Space wrapper
// Since cpSpaceNew() returns pointers to the space, we need to wrap it
// in our own struct for abstract type to work.
typedef struct {
  cpSpace *handle;
} SpaceWrapper;

int space_get(void *p, Janet key, Janet *out);
void space_put(void *p, Janet key, Janet value);

static const JanetAbstractType AT_SpaceWrapper = {
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

static cpSpace *cp_getspace(const Janet *argv, int32_t n) {
  SpaceWrapper *wrapper = janet_getabstract(argv, n, &AT_SpaceWrapper);
  return wrapper->handle;
}
