#include <janet/janet.h>
#include <chipmunk/chipmunk.h>
#include <chipmunk/chipmunk_private.h>

#include "types.h"

JANET_FN(cfun_space_new,
         "(chipmunk/space-new)",
         "Create an empty space.") {
  janet_fixarity(argc, 0);
  (void) argv;

  SpaceWrapper *wrapper = janet_abstract(&AT_SpaceWrapper, sizeof(SpaceWrapper));
  cpSpace *space = cpSpaceNew();
  wrapper->handle = space;
  return janet_wrap_abstract(wrapper);
}

JANET_FN(cfun_space_set_gravity,
         "(chipmunk/space-set-gravity)",
         "Set the gravity of the new space") {
  janet_fixarity(argc, 2);
  cpSpace *space = cp_getspace(argv, 0);
  cpVect gravity = cp_getvec2(argv, 1);

  cpSpaceSetGravity(space, gravity);

  return janet_wrap_nil();
}

JANET_MODULE_ENTRY(JanetTable *env) {
  JanetRegExt cfuns[] = {
    JANET_REG("space-new", cfun_space_new),
    JANET_REG("space-set-gravity", cfun_space_set_gravity),
    JANET_REG_END
  };
  janet_cfuns_ext(env, "chipmunk", cfuns);
}
