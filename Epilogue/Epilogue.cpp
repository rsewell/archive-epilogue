// Epilogue.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include "Epilogue.h"

#include <stdarg.h>

typedef struct {
	char** argv;
	int argc;
	int size;
							} argv_buf;


//-------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------
static void initial_argv_massage(int* argc, char*** argv) {
	argv_buf ab = { 0 }, 
	argv_buf xab = { 0 };

	int ix, vix, ac;
	char** av;

	struct {
		int argc;
		char** argv;
							} avv[] = { {INT_MAX, NULL}, {INT_MAX, NULL}, {INT_MAX, NULL}, {INT_MAX, NULL}, {INT_MAX, NULL}, {INT_MAX, NULL} };

	//---------------------------------------------------------------------------------------------
	// The environment flag containing OTP release is intentionally
	// undocumented and intended for OTP internal use only.
	//---------------------------------------------------------------------------------------------

	vix = 0;

	av = build_args_from_env("ERL_OTP" OTP_SYSTEM_VERSION "_FLAGS");
	if (av) {
		avv[vix++].argv = av;
	}
	av = build_args_from_env("ERL_AFLAGS");
	if (av) {
		avv[vix++].argv = av;
	}

	//---------------------------------------------------------------------------------------------
	// command line 
	//---------------------------------------------------------------------------------------------
	if (*argc > 1) {
		avv[vix].argc = *argc - 1;
		avv[vix++].argv = &(*argv)[1];
	}

	av = build_args_from_env("ERL_FLAGS");
	if (av)
		avv[vix++].argv = av;

	av = build_args_from_env("ERL_ZFLAGS");
	if (av)
		avv[vix++].argv = av;

	if (vix == (*argc > 1 ? 1 : 0)) {
		/* Only command line argv; check if we can use argv as it is... */
		ac = *argc;
		av = *argv;
		for (ix = 1; ix < ac; ix++) {
			if (strcmp(av[ix], "-args_file") == 0) {
				/* ... no; we need to expand arguments from
				   file into argument list */
				goto build_new_argv;
			}
			if (strcmp(av[ix], "-extra") == 0) {
				break;
			}
		}

		/* ... yes; we can use argv as it is. */
		return;
	}

build_new_argv:

	save_arg(&ab, (*argv)[0]);

	vix = 0;
	while (avv[vix].argv) {
		ac = avv[vix].argc;
		av = avv[vix].argv;

		ix = 0;
		while (ix < ac && av[ix]) {
			if (strcmp(av[ix], "-args_file") == 0) {
				if (++ix == ac)
					usage("-args_file");
				get_file_args(av[ix++], &ab, &xab);
			}
			else {
				if (strcmp(av[ix], "-extra") == 0) {
					ix++;
					while (ix < ac && av[ix])
						save_arg(&xab, av[ix++]);
					break;
				}
				save_arg(&ab, av[ix++]);
			}
		}

		vix++;
	}

	vix = 0;
	while (avv[vix].argv) {
		if (avv[vix].argc == INT_MAX) /* not command line */
			efree(avv[vix].argv);
		vix++;
	}

	if (xab.argc) {
		save_arg(&ab, "-extra");
		for (ix = 0; ix < xab.argc; ix++)
			save_arg(&ab, xab.argv[ix]);
		efree(xab.argv);
	}

	save_arg(&ab, NULL);
	trim_argv_buf(&ab);
	*argv = ab.argv;
	*argc = ab.argc - 1;
}



int main() {
	int haltAfterwards = 0;					/* If true, put 's erlang halt' at the end * of the arguments. */
	int isdistributed = 0;
	int no_epmd = 0;
	int i;
	char* s;
	char* epmd_prog = NULL;
	char* malloc_lib;
	int process_args = 1;
	int print_args_exit = 0;
	int print_qouted_cmd_exit = 0;
	char* emu_name;

	OSAbstractor &os = getOS();

	EpilogueEngine *ep_engine = new EpilogueEngine();

	int reset_cerl_detached = 0;

//	s = os.getEnvironmentVariable("CERL_DETACHED_PROG");
//	if (!isStringEmpty(s)) {
//		emu = s;
//		start_detached = 1;
//		reset_cerl_detached = 1;
//		ensure_EargsSz(argc + 1);
//		memcpy((void*)Eargsp, (void*)argv, argc * sizeof(char*));
//		Eargsp[argc] = emu;
//		Eargsp[argc] = NULL;
//		goto skip_arg_massage;
//	}
//	free_env_val(s);




    std::cout << "Hello World!\n";
}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
