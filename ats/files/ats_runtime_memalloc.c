/* Minimal ATS runtime memalloc stubs for linking with -latslib.
 * Provides the symbols expected by libatslib when using listize_argc_argv,
 * streamize_fileref_line, etc. (libc-backed allocation).
 */
#include <stddef.h>
#include <stdlib.h>

void atsruntime_mfree_undef(void *ptr) {
  free(ptr);
}

void *atsruntime_malloc_undef(size_t bsz) {
  return malloc(bsz);
}

void *atsruntime_calloc_undef(size_t asz, size_t tsz) {
  return calloc(asz, tsz);
}

void *atsruntime_realloc_undef(void *ptr, size_t bsz) {
  return realloc(ptr, bsz);
}
