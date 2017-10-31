#include "MyClass.h"

float lerp(float a, float b, float t) {
    return (1 - t) * a + t * b;
}

myStruct getStruct() {
    myStruct s;
    s.x = 1;
    s.y = 2;
    return s;
}