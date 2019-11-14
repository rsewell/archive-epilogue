#pragma once
#include "OSAbstractor.h"

#ifdef _WIN64

class Win32Abstractor :
	public OSAbstractor
{
public:
	Win32Abstractor() { };
	~Win32Abstractor() { };


public:
	virtual char* getEnvironmentVariable(const char*);
	virtual void freeEnvironmentVariable(char*);
	virtual void setEnvironmentVarialble(const char* key, const char* value);


};
#endif


