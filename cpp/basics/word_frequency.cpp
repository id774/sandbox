// Count the words of a fixed text, most frequent first and alphabetically within a tie.
// Build: c++ -std=c++20 -o word_frequency word_frequency.cpp

#include <algorithm>
#include <iostream>
#include <sstream>
#include <string>
#include <unordered_map>
#include <utility>
#include <vector>

int main()
{
    const std::string text = "the quick brown fox jumps over the lazy dog the fox barks";

    std::unordered_map<std::string, int> counts;
    std::istringstream words(text);
    for (std::string word; words >> word;) {
        ++counts[word];
    }

    std::vector<std::pair<std::string, int>> ranked(counts.begin(), counts.end());
    std::sort(ranked.begin(), ranked.end(), [](const auto& a, const auto& b) {
        return a.second != b.second ? a.second > b.second : a.first < b.first;
    });

    for (const auto& [word, count] : ranked) {
        std::cout << word << ' ' << count << '\n';
    }
}
