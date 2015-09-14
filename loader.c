#include <dlfcn.h>
#include <substrate.h>

__attribute__((constructor))
static void constructor(void) {
    void *handle = dlopen(LIB_DIR "/" DLL_NAME, RTLD_LAZY | RTLD_LOCAL | RTLD_FIRST);
#define hook(symbol) MSHookFunction(dlsym(RTLD_DEFAULT, #symbol), dlsym(handle, #symbol), (void **)dlsym(handle, "true_" #symbol))
    hook(connect);
    hook(sendto);
    hook(gethostbyname);
    hook(getaddrinfo);
    hook(freeaddrinfo);
    hook(gethostbyaddr);
    hook(getnameinfo);
    hook(close);
#undef hook
}
