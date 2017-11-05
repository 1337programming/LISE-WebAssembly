#include <emscripten/html5.h>
#include <emscripten/bind.h>

#include "MyClass.h"

#ifndef APPLICATION_H
#define APPLICATION_H


using namespace emscripten;

class Application {
public:
    void Initialize();
    void SayHello();
};

int getX(const myStruct& s) { return s.x; }
void setX(myStruct& s, int newX) { s.x = newX; }

EMSCRIPTEN_BINDINGS(my_module) {
        function("lerp", &lerp);

        class_<Application>("Application")
                .constructor()
                .function("Initialize", &Application::Initialize)
                .function("SayHello", &Application::SayHello);

        //value_struct<myStruct>("myStruct")
        //    .field("x", &myStruct::x)
        //    .field("y", &myStruct::y)
        //    ;

        class_<myStruct>("myStruct")
                .constructor<>()
                .function("getX", &getX)
                .function("setX", &setX)
                .property("x", &getX, &setX);

        function("getStruct", &getStruct);

        class_<MyClass>("MyClass")
                .constructor<int, std::string>()
                .function("incrementX", &MyClass::incrementX)
                .property("x", &MyClass::getX, &MyClass::setX)
                .class_function("getStringFromInstance", &MyClass::getStringFromInstance);
}

#endif
