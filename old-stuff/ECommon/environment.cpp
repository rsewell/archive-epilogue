#include "pch.h"


//-------------------------------------------------------------------------------------------------
// Free the memory associated with an environment varialble
//-------------------------------------------------------------------------------------------------
void free_env_val(char* value) {

#ifdef __WIN32__
	if (value) {
		free(value);
	}
#endif

}