#include "Epilogue.h"


#ifdef __DARWIN__










DarwinAbstractor os_abstractor;

OSAbstractor& getOS() {
	return os_abstractor;
}

#endif