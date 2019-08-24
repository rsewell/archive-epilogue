#pragma once

class EpilogueEngine {


	//---------------------------------------------------------------------------------------------
	// Needed parameters to be fetched from the environment(Unix) or the ini file(Win32).
	//---------------------------------------------------------------------------------------------
 

	char* bindir;								/* Location of executables. */
	char* rootdir;								/* Root location of Erlang installation. */
	char* emu;									/* Emulator to run. */
	char* progname;								/* Name of this program. */
	char* home;									/* Path of user's home directory. */




};

