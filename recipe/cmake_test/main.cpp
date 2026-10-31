#include <thrift/Thrift.h>
#include <thrift/TOutput.h>

int main() {
    apache::thrift::TOutput::instance().setOutputFunction([](const char*) {});
    apache::thrift::TOutput::instance()("test");
    return 0;
}
