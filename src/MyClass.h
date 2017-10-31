// quick_example.h

#include <iostream>
#ifndef MY_CLASS_H
#define MY_CLASS_H

float lerp(float a, float b, float t);

struct myStruct {
    int x;
    int y;
};

myStruct getStruct();

class MyClass {
public:
    MyClass(int x, std::string y)
            : x(x)
            , y(y)
    {}

    void incrementX() {
        ++x;
    }

    int getX() const { return x; }
    void setX(int x_) { x = x_; }

    static std::string getStringFromInstance(const MyClass& instance) {
        return instance.y;
    }

private:
    int x;
    std::string y;
};

#endif
