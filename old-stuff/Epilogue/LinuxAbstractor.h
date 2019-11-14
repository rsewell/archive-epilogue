#pragma once

#ifndef _WIN64

#pragma message ("__WIN32__ not defined")
#include "OSAbstractor.h"
class LinuxAbstractor :
	public OSAbstractor
{
	
public:
	virtual char* getEnvironmentVariable(const char*);
	virtual void freeEnvironmentVariable(char*);
	virtual void setEnvironmentVarialble(const char* key, const char* value);

};
#endif

