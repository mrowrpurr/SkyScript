// #include "foo.h"
// #include "SkyScriptTests.h"

#include <gtest/gtest.h>
#include <SkyScript.h>

TEST(HelloTest, BasicAssertions) {
  auto something = new SkyScript::Whatever();
  auto text = something->ReturnSomethingFromSomewhere();
  EXPECT_STREQ(text.data(), "world");
  EXPECT_EQ(7 * 6, 42);
}














// using ::testing::Return;

// FooTest::FooTest() {
//     // Have qux return true by default
//     ON_CALL(m_bar,qux()).WillByDefault(Return(true));
//     // Have norf return false by default
//     ON_CALL(m_bar,norf()).WillByDefault(Return(false));
// }

// FooTest::~FooTest() {};

// void FooTest::SetUp() {};

// void FooTest::TearDown() {};

// TEST_F(FooTest, ByDefaultBazTrueIsTrue) {
//     Foo foo(m_bar);
//     EXPECT_EQ(foo.baz(true), true);
// }

// TEST_F(FooTest, ByDefaultBazFalseIsFalse) {
//     Foo foo(m_bar);
//     EXPECT_EQ(foo.baz(false), false);
// }

// TEST_F(FooTest, SometimesBazFalseIsTrue) {
//     Foo foo(m_bar);
//     // Have norf return true for once
//     EXPECT_CALL(m_bar,norf()).WillOnce(Return(true));
//     EXPECT_EQ(foo.baz(false), true);
// }