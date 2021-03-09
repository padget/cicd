#include <clon/clon.hpp>
#include <iostream>
#include <vector>
#include <string_view>
#include <string>
#include <fstream>
#include <iterator>

std::vector<std::string_view>
args_views(int argc, char **argv)
{
  std::vector<std::string_view> views;
  views.reserve(argc);

  for (int i = 0; i < argc; i++)
    views.push_back(std::string_view(argv[i]));

  return views;
}

int main(int argc, char **argv)
{
  auto &&args = args_views(argc, argv);

  if (args.size() >= 4)
  {
    auto &&file = args[1];
    auto &&pth = args[2];
    auto &&action = args[3];

    std::fstream f(file.data());
    std::string s = std::string(std::istreambuf_iterator<char>(f),
                                std::istreambuf_iterator<char>());
    clon::clon c(std::string_view(s.begin(), s.end()));

    if (action == "name")
      std::cout << c[pth].name() << std::endl;

    if (action == "value")
      std::cout << c[pth].value() << std::endl;

    if (action == "set")
    {
      if (args.size() == 5)
      {
        auto &&value = args[4];
        c[pth].update<clon::string<char>>(value);
        std::cout << c.to_string();
      }
    }
  }

  return EXIT_SUCCESS;
}