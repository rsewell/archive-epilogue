#pragma once
#include "OSAbstractor.h"

#ifdef __DARWIN__

class DarwinAbstractor :
	public LinuxAbstractor
{
};

#endif

