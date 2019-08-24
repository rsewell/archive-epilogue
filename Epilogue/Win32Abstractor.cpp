#include "Epilogue.h"

#ifdef _WIN64

#include "windows.h"

//-------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------
char* Win32Abstractor::getEnvironmentVariable(const char* key) {
	char* pValue;
	size_t len;

	if (_dupenv_s(&pValue, &len, "pathext")) {
		return NULL;
	}
	return (pValue);
};

//-------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------
void Win32Abstractor::freeEnvironmentVariable(char* value) {
	if (value) {
		free(value);
	}
};

//-------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------
void Win32Abstractor::setEnvironmentVarialble(const char* key, const char* value) {
	if (_putenv_s(key, value)) {
		error("putenv(\"%s = %s\") failed!", key, value);
	}
}








Win32Abstractor os_abstractor;

OSAbstractor& getOS() {
	return os_abstractor;
}

#endif
