#ifndef _COMMON_H_
#define _COMMON_H_

#include <stdint.h>

#ifdef DEBUG
	#define DEBUG_LOG(msg) xil_printf(msg)
#else
	#define DEBUG_LOG
#endif

#endif // _COMMON_H_
