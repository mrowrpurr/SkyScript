#include "../specHelper.h"

go_bandit([](){
    describe("something", [](){
       it("does something", [&](){
           AssertThat(420, Equals(69));
       });
        it("does something else", [&](){
            AssertThat(69, Equals(69));
        });
    });
});

int main(int argc, char* argv[]) { return runBandit(argc, argv); }
