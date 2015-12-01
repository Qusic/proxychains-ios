#include <dlfcn.h>
#include <substrate.h>

__attribute__((constructor))
static void constructor(void) {
    void *proxychains = dlopen(LIB_DIR "/" DLL_NAME, RTLD_LAZY | RTLD_LOCAL | RTLD_FIRST);
#define _hook(handle, symbol) MSHookFunction(dlsym(handle, #symbol), dlsym(proxychains, #symbol), (void **)dlsym(proxychains, "true_" #symbol))
#define hook(handle) ({ \
    _hook(handle, connect); \
    _hook(handle, sendto); \
    _hook(handle, gethostbyname); \
    _hook(handle, getaddrinfo); \
    _hook(handle, freeaddrinfo); \
    _hook(handle, gethostbyaddr); \
    _hook(handle, getnameinfo); \
    _hook(handle, close); \
})
    hook(RTLD_DEFAULT);
}
