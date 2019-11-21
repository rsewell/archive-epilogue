#include "Epilogue.h"

#ifndef _WIN64

//-------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------
const char* LinuxAbstractor::getEnvironmentVariable(const char* key) {
	return getenv(key);
};
//-------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------
void LinuxAbstractor::freeEnvironmentVariable(char* value) {
};

//-------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------
void LinuxAbstractor::setEnvironmentVarialble(const char* key, const char* value) {
	size_t size = strlen(key) + 1 + strlen(value) + 1;
	char* str = emalloc(size);

	sprintf(str, "%s=%s", key, value);

	if (putenv(str) != 0) {
		error("putenv(\"%s\") failed!", str);
	}
	efree(str);
}





#ifndef __DARWIN__

LinuxAbstractor os_abstractor;

OSAbstractor& getOS() {
	return os_abstractor;
}

#endif
#endif
