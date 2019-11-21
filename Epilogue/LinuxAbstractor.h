#pragma once
#include "OSAbstractor.h"

#ifndef _WIN64

#pragma message ("__WIN64 not defined")

class LinuxAbstractor :
	public OSAbstractor
{

public:
	virtual const char* getEnvironmentVariable(const char*);
	virtual void freeEnvironmentVariable(char*);
	virtual void setEnvironmentVarialble(const char* key, const char* value);

};
#endif


