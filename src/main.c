#include <janet/janet.h>
#include <chipmunk/chipmunk.h>
#include <chipmunk/chipmunk_private.h>

#include "types.h"

#include "body.h"
#include "shapes.h"
#include "spaces.h"



JANET_MODULE_ENTRY(JanetTable *env) {
  janet_cfuns(env, "chipmunk", body_cfuns);
  janet_cfuns(env, "chipmunk", shapes_cfuns);
  janet_cfuns(env, "chipmunk", spaces_cfuns);
}
