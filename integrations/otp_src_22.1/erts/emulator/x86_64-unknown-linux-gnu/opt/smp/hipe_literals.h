/* File: hipe_literals.h, generated by /home/rsewell/Projects/Epilogue/integrations/otp_src_22.1/bin/x86_64-unknown-linux-gnu/hipe_mkliterals.smp */
#ifndef __HIPE_LITERALS_H__
#define __HIPE_LITERALS_H__

#define F_TIMO 4
#define FREASON_TRAP 512
#define EFE_NATIVE_ADDRESS 56
#define EFE_REFC 80
#define EFT_THING 0
#define BSF_ALIGNED 1
#define PB_ACTIVE_WRITER 2
#define PB_IS_WRITABLE 1
#define MB_ORIG 0
#define MB_BASE 8
#define MB_OFFSET 16
#define MB_SIZE 24
#define PROC_BIN_THING_WORD 0
#define PROC_BIN_BINSIZE 8
#define PROC_BIN_NEXT 16
#define PROC_BIN_VAL 24
#define PROC_BIN_BYTES 32
#define PROC_BIN_FLAGS 40
#define PROC_BIN_WORDSIZE 6
#define SUB_BIN_THING_WORD 0
#define SUB_BIN_BINSIZE 8
#define SUB_BIN_BITSIZE 24
#define SUB_BIN_OFFS 16
#define SUB_BIN_BITOFFS 25
#define SUB_BIN_WRITABLE 26
#define SUB_BIN_ORIG 32
#define SUB_BIN_WORDSIZE 5
#define HEAP_BIN_THING_WORD 0
#define HEAP_BIN_SIZE 8
#define HEAP_BIN_DATA 16
#define BINARY_ORIG_SIZE 16
#define BINARY_ORIG_BYTES 24
#define MAX_HEAP_BIN_SIZE 64
#define MS_THING_WORD 0
#define MS_MATCHBUFFER 8
#define MS_SAVEOFFSET 40
#define MS_MIN_SIZE 5
#define MB_ORIG_SIZE 8
#define MB_BASE_SIZE 8
#define MB_OFFSET_SIZE 8
#define MB_SIZE_SIZE 8
#define PROC_BIN_THING_WORD_SIZE 8
#define PROC_BIN_BINSIZE_SIZE 8
#define PROC_BIN_NEXT_SIZE 8
#define PROC_BIN_VAL_SIZE 8
#define PROC_BIN_BYTES_SIZE 8
#define PROC_BIN_FLAGS_SIZE 8
#define SUB_BIN_THING_WORD_SIZE 8
#define SUB_BIN_BINSIZE_SIZE 8
#define SUB_BIN_BITSIZE_SIZE 1
#define SUB_BIN_OFFS_SIZE 8
#define SUB_BIN_BITOFFS_SIZE 1
#define SUB_BIN_WRITABLE_SIZE 1
#define SUB_BIN_ORIG_SIZE 8
#define HEAP_BIN_THING_WORD_SIZE 8
#define HEAP_BIN_SIZE_SIZE 8
#define HEAP_BIN_DATA_SIZE 8
#define BINARY_ORIG_SIZE_SIZE 8
#define BINARY_ORIG_BYTES_SIZE 1
#define MS_THING_WORD_SIZE 8
#define MS_SAVEOFFSET_SIZE 8
#define MSG_NEXT 0
#define ARM_LEAF_WORDS 16
#define ARM_NR_ARG_REGS 3
#define ARM_IS_BIG_ENDIAN 0
#define PPC_LEAF_WORDS 16
#define PPC_NR_ARG_REGS 4
#define AMD64_LEAF_WORDS 24
#define AMD64_NR_ARG_REGS 4
#define AMD64_HP_IN_REGISTER 1
#define AMD64_HEAP_POINTER 15
#define X86_LEAF_WORDS 24
#define X86_NR_ARG_REGS 3
#define X86_NR_RET_REGS 3
#define X86_HP_IN_ESI 1
#define SPARC_LEAF_WORDS 16
#define SPARC_NR_ARG_REGS 4
#define P_OFF_HEAP_FUNS 608
#define EFT_NEXT 16
#define EFT_CREATOR 40
#define EFT_FE 8
#define EFT_ARITY 24
#define EFT_NUM_FREE 32
#define EFT_ENV 48
#define ERL_FUN_SIZE 6
#define P_SCHED_DATA 808
#define P_FP_EXCEPTION 152
#define ERTS_IS_SMP 1
#define ERTS_NO_FPE_SIGNALS 1
#define ERTS_USE_LITERAL_TAG 0
#define MSG_MESSAGE 16
#define P_HP 80
#define P_HP_LIMIT 88
#define P_OFF_HEAP_FIRST 608
#define P_MBUF 624
#define P_ID 0
#define P_FLAGS 368
#define P_FVALUE 376
#define P_FREASON 384
#define P_FTRACE 392
#define P_FCALLS 336
#define P_BEAM_IP 320
#define P_ARITY 240
#define P_ARG0 264
#define P_ARG1 272
#define P_ARG2 280
#define P_ARG3 288
#define P_ARG4 296
#define P_ARG5 304
#define P_NSP 160
#define P_NCALLEE 184
#define P_CLOSURE 184
#define P_NSP_LIMIT 168
#define P_CSP 216
#define P_NARITY 224
#define P_FLOAT_RESULT 232
#define P_MSG_FIRST 408
#define P_MSG_SAVE 424
#define P_CALLEE_EXP 184
#define THE_NON_VALUE 0
#define P_MSG_LAST 416
#define P_MSG_SAVED_LAST 464
#define HIPE_LITERALS_CRC 71374907U
#define HIPE_SYSTEM_CRC 35282319U
#define HIPE_ERTS_CHECKSUM (HIPE_LITERALS_CRC ^ HIPE_SYSTEM_CRC)

#define RTS_PARAMS_CASES \
	case 1: value = 608; break; \
	case 4: value = 16; break; \
	case 5: value = 40; break; \
	case 6: value = 8; break; \
	case 8: value = 24; break; \
	case 9: value = 32; break; \
	case 10: value = 48; break; \
	case 11: value = 6; break; \
	case 12: value = 808; break; \
	case 14: value = 152; break; \
	case 15: value = 1; break; \
	case 16: value = 1; break; \
	case 17: value = 0; break; \
	case 19: value = 16; break; \
	case 22: value = 80; break; \
	case 23: value = 88; break; \
	case 24: value = 608; break; \
	case 25: value = 624; break; \
	case 26: value = 0; break; \
	case 27: value = 368; break; \
	case 28: value = 376; break; \
	case 29: value = 384; break; \
	case 30: value = 392; break; \
	case 31: value = 336; break; \
	case 32: value = 320; break; \
	case 33: value = 240; break; \
	case 34: value = 264; break; \
	case 35: value = 272; break; \
	case 36: value = 280; break; \
	case 37: value = 288; break; \
	case 38: value = 296; break; \
	case 39: value = 304; break; \
	case 40: value = 160; break; \
	case 41: value = 184; break; \
	case 42: value = 184; break; \
	case 43: value = 168; break; \
	case 44: value = 216; break; \
	case 45: is_defined = 0; break; \
	case 46: value = 224; break; \
	case 47: value = 232; break; \
	case 48: is_defined = 0; break; \
	case 49: value = 408; break; \
	case 50: value = 424; break; \
	case 51: value = 184; break; \
	case 52: value = 0; break; \
	case 53: is_defined = 0; break; \
	case 54: value = 416; break; \
	case 55: value = 464; break;
#endif
