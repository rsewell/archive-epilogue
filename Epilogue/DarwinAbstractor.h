#pragma once

#ifdef __DARWIN__
#include "LinuxAbstractor.h"
class DarwinAbstractor :
	public LinuxAbstractor
{
};
#endif

