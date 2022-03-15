#pragma once

#include "specHelper.h"

go_bandit([](){
    describe("Function invocation", [](){
        xit("can invoke a void native function with no parameters", [&](){});
        xit("invoking native function causes runtime exception if native function not registered", [&](){});
        xit("invoking function with parameters not matching type signature causes runtime exception", [&](){});
        xit("function returning type not matching type signature causes runtime exception", [&](){});
    });
});
