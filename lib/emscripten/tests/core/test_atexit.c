#include <stdio.h>
#include <stdlib.h>

extern "C" {
extern int __cxa_thread_atexit(void (*dtor)(void *), void *obj, void *dso_symbol);
extern int __cxa_thread_atexit_impl(void (*dtor)(void *), void *obj, void *dso_symbol);
}

static void cleanA() { printf("A\n"); }
static void cleanB() { printf("B\n"); }
static void cleanCarg(void* x) { printf("C %d\n", (int)x); }

int main() {
  atexit(cleanA);
  atexit(cleanB);
  __cxa_thread_atexit(cleanCarg, (void*)100, NULL);
  __cxa_thread_atexit_impl(cleanCarg, (void*)234, NULL);
  return 0;
}
