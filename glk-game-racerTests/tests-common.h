#import <XCTest/XCTest.h>
#include <math.h>

#ifndef glk_game_racer_tests_common_h
#define glk_game_racer_tests_common_h


#ifndef XCTAssertFloatEquals

//#define XCTAssertFloatEquals(f1, f2, format, ...) \
//_XCTPrimitiveAssertTrue(fabsf(f1-f2)<0.00001f, [NSString stringWithFormat:@"%@ (wait:%f get:%f)", format, f2, f1], ##__VA_ARGS__)

#define XCTAssertFloatEquals(f_result, f_wait, info) \
_XCTPrimitiveAssertTrue(fabsf(f_wait-f_result)<0.00001f, @"%@ (wait:%f get:%f)", info, f_wait, f_result)

#endif


#endif
