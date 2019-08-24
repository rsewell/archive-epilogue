#include "Epilogue.h"
#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>



//-------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------
void OSAbstractor::logError(const char* fmt, ...) {
	char message[1024];

	va_list arglist;
	va_start(arglist, fmt);
	vsprintf(message, fmt, arglist);
	fprintf(stderr, "ERROR: %s\r\n", message);
	va_end(arglist);
}
//-------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------
void OSAbstractor::logInfo(const char* fmt, ...) {
	char message[1024];

	va_list arglist;
	va_start(arglist, fmt);
	vsprintf(message, fmt, arglist);
	fprintf(stderr, "INFO: %s\r\n", message);
	va_end(arglist);
}
//-------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------
void OSAbstractor::logSevere(const char* fmt, ...) {
	char message[1024];

	va_list arglist;
	va_start(arglist, fmt);
	vsprintf(message, fmt, arglist);
	fprintf(stderr, "SEVERE: %s\r\n", message);
	va_end(arglist);
}
//-------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------
void OSAbstractor::logDebug(const char* fmt, ...) {
	char message[1024];

	va_list arglist;
	va_start(arglist, fmt);
	vsprintf(message, fmt, arglist);
	fprintf(stderr, "DEBUG: %s\r\n", message);
	va_end(arglist);
}
//-------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------
void OSAbstractor::logFatal(const char* fmt, ...) {
	char message[1024];

	va_list arglist;
	va_start(arglist, fmt);
	vsprintf(message, fmt, arglist);
	fprintf(stderr, "FATAL: %s\r\n", message);
	va_end(arglist);
	abort();
}
	
