#include <base64/base64.hpp>
#include <iostream>
#include <vector>
#include <string_view>

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
try
{
  auto &&args = args_views(argc, argv);

  if (args.size() >= 2)
  {
    auto &&action = args[1];

    std::string data = (args.size() == 2)
                           ? std::string(std::istreambuf_iterator<char>(std::cin),
                                         std::istreambuf_iterator<char>())
                           : std::string(args[2]);

    std::string_view v(data.begin(), (data.ends_with('\n') ? data.end() - 1 : data.end()));

    if (action == "encode")
      std::cout << base64::encode<std::string>(v);
    if (action == "decode")
      std::cout << base64::decode<std::string>(v);
  }
}
catch (const char *e)
{
  std::cout << e << std::endl;
}