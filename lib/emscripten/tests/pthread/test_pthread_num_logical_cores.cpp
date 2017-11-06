// Also test issue #5343
#include <threads.h>

#include <emscripten/threading.h>
#include <stdio.h>

int main()
{
	printf("emscripten_num_logical_cores returns %d.\n", (int)emscripten_num_logical_cores());
#ifdef REPORT_RESULT
	REPORT_RESULT(0);
#endif
}
