#pragma once
#pragma once


class OSAbstractor
{
public:
	OSAbstractor() {};
	~OSAbstractor() {};


public:

	virtual const char* getEnvironmentVariable(const char*) = 0;
	virtual void freeEnvironmentVariable(char*) = 0;
	virtual void setEnvironmentVarialble(const char* key, const char* value) = 0;


	void logError(const char* fmt, ...);
	void logInfo(const char* fmt, ...);
	void logSevere(const char* fmt, ...);
	void logDebug(const char* fmt, ...);
	void logFatal(const char* fmt, ...);

	void error(const char* format, ...);

};


