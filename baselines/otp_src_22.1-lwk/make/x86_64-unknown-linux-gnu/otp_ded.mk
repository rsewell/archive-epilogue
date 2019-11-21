#-*-makefile-*-   ; force emacs to enter makefile-mode
# ----------------------------------------------------
# %CopyrightBegin%
#
# Copyright Ericsson AB 2009-2013. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# %CopyrightEnd%

# The version.
#
# Note that it is important that the version is
# explicitly expressed here. Some applications need to
# be able to check this value *before* configure has
# been run and generated otp_ded.mk
DED_MK_VSN = 2
# ----------------------------------------------------
# Variables needed for building Dynamic Erlang Drivers
# ----------------------------------------------------
DED_CC = icc
DED_GCC = yes
DED_LD = icc
DED_LDFLAGS = -shared -Wl,-Bsymbolic
DED_BASIC_CFLAGS = -Werror=undef -Werror=implicit -Werror=return-type  -Wdeclaration-after-statement -Wall -Wstrict-prototypes -Wmissing-prototypes  -D_THREAD_SAFE -D_REENTRANT -DPOSIX_THREADS -D_POSIX_THREAD_SAFE_FUNCTIONS -g -O2  -D_GNU_SOURCE -fPIC
DED_THR_DEFS =  -D_THREAD_SAFE -D_REENTRANT -DPOSIX_THREADS -D_POSIX_THREAD_SAFE_FUNCTIONS
DED_WERRORFLAGS = -Werror=undef -Werror=implicit -Werror=return-type 
DED_WARN_FLAGS = -Wdeclaration-after-statement -Wall -Wstrict-prototypes -Wmissing-prototypes
DED_CFLAGS = -Werror=undef -Werror=implicit -Werror=return-type  -Wdeclaration-after-statement -Wall -Wstrict-prototypes -Wmissing-prototypes  -D_THREAD_SAFE -D_REENTRANT -DPOSIX_THREADS -D_POSIX_THREAD_SAFE_FUNCTIONS -g -O2  -D_GNU_SOURCE -fPIC
DED_LD_FLAG_RUNTIME_LIBRARY_PATH = -Wl,-R
DED_STATIC_CFLAGS = -Werror=undef -Werror=implicit -Werror=return-type    -D_THREAD_SAFE -D_REENTRANT -DPOSIX_THREADS -D_POSIX_THREAD_SAFE_FUNCTIONS -g -O2  -D_GNU_SOURCE -DSTATIC_ERLANG_NIF -DSTATIC_ERLANG_DRIVER
DED_LIBS = 
DED_EXT = so
DED_OSTYPE = unix
PRIVDIR = ../priv
OBJDIR = $(PRIVDIR)/obj/$(TARGET)
LIBDIR = $(PRIVDIR)/lib/$(TARGET)
DED_SYS_INCLUDE = -I/home/rsewell/Projects/Epilogue/baselines/otp_src_22.1-lwk/erts/emulator/beam -I/home/rsewell/Projects/Epilogue/baselines/otp_src_22.1-lwk/erts/include -I/home/rsewell/Projects/Epilogue/baselines/otp_src_22.1-lwk/erts/include/x86_64-unknown-linux-gnu -I/home/rsewell/Projects/Epilogue/baselines/otp_src_22.1-lwk/erts/include/internal -I/home/rsewell/Projects/Epilogue/baselines/otp_src_22.1-lwk/erts/include/internal/x86_64-unknown-linux-gnu -I/home/rsewell/Projects/Epilogue/baselines/otp_src_22.1-lwk/erts/emulator/sys/unix -I/home/rsewell/Projects/Epilogue/baselines/otp_src_22.1-lwk/erts/emulator/sys/common
DED_INCLUDES = -I/home/rsewell/Projects/Epilogue/baselines/otp_src_22.1-lwk/erts/emulator/beam -I/home/rsewell/Projects/Epilogue/baselines/otp_src_22.1-lwk/erts/include -I/home/rsewell/Projects/Epilogue/baselines/otp_src_22.1-lwk/erts/include/x86_64-unknown-linux-gnu -I/home/rsewell/Projects/Epilogue/baselines/otp_src_22.1-lwk/erts/include/internal -I/home/rsewell/Projects/Epilogue/baselines/otp_src_22.1-lwk/erts/include/internal/x86_64-unknown-linux-gnu -I/home/rsewell/Projects/Epilogue/baselines/otp_src_22.1-lwk/erts/emulator/sys/unix -I/home/rsewell/Projects/Epilogue/baselines/otp_src_22.1-lwk/erts/emulator/sys/common
