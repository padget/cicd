#include <ares/ares.hpp>
#include <iostream>

int main(int argc, char **argv)
{
  std::string data(std::istreambuf_iterator<char>(std::cin),
                   std::istreambuf_iterator<char>());
  std::cout << ares::encrypt(std::string_view(data.begin(), data.end()));
  return EXIT_SUCCESS;
}