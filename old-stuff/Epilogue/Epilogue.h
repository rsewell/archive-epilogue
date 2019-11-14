#pragma once

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "EUtilities.h"

#include "OSAbstractor.h"
#include "Win32Abstractor.h"
#include "LinuxAbstractor.h"
#include "DarwinAbstractor.h"


#include "EpilogueEngine.h"


OSAbstractor& getOS(void);