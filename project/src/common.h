#ifndef _COMMON_H_
#define _COMMON_H_

#include <stdint.h>
#include "xil_assert.h"

#define UINT_3_VALUE_MAX  7
#define UINT_4_VALUE_MAX  15
#define UINT_5_VALUE_MAX  31
#define UINT_6_VALUE_MAX  63
#define UINT_7_VALUE_MAX  127
#define UINT_10_VALUE_MAX 1023

#ifdef DEBUG
	#define DEBUG_LOG(msg) xil_printf(msg)
#else
	#define DEBUG_LOG
#endif

#endif // _COMMON_H_
