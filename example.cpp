#include <cheerp/clientlib.h>

[[cheerp::genericjs]] int domOutput(const char* str)
{
    client::String* s = new client::String(str);
    client::console.log(s);
    // Also add it to the DOM for good measure
    client::document.get_body()->set_textContent(s);
    return s->get_length();
}

void webMain()
{
    int len = domOutput("Hello WASM!");
    assert(len == 11);
}