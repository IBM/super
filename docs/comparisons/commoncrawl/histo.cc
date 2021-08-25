#include <algorithm>
#include <iostream>
#include <fstream>
#include <map>
#include <regex>
#include <string>
#include <vector>
 
int main() {
    using namespace std;
    regex wordRgx("\\w+");
    map<string, int> freq;
    std::string line;

    auto fp_deletor = [](std::istream* is_ptr) {
        if (is_ptr && is_ptr != &std::cin) {
            static_cast<std::ifstream*>(is_ptr)->close();
            delete is_ptr;
            std::cerr << "destroy fp.\n"; 
        }
    };
    std::unique_ptr<std::istream, decltype(fp_deletor)> is_ptr{nullptr, fp_deletor};
    is_ptr.reset(&std::cin); 
	
    while (std::getline(*is_ptr, line)) {
      auto word = line;
      if (word.size() > 0) {
	auto entry = freq.find(word);
	if (entry != freq.end()) {
	  entry->second++;
	} else {
	  freq.insert(make_pair(word, 1));
	}
      }
    }
 
    for (auto iter = freq.cbegin(); iter != freq.cend(); ++iter) {
      printf("%5d  %4s\n", iter->second, iter->first.c_str());
    }
    
    /*vector<pair<string, int>> pairs;
    for (auto iter = freq.cbegin(); iter != freq.cend(); ++iter) {
        pairs.push_back(*iter);
    }
    sort(pairs.begin(), pairs.end(), [=](pair<string, int>& a, pair<string, int>& b) {
        return a.second > b.second;
    });
 
    // cout << "Rank  Word  Frequency\n";
    // cout << "====  ====  =========\n";
    int rank = 1;
    for (auto iter = pairs.cbegin(); iter != pairs.cend() && rank <= 10; ++iter) {
      //printf("%2d   %4s   %5d\n", rank++, iter->first.c_str(), iter->second);
      printf("%5d  %4s\n", iter->second, iter->first.c_str());
      rank++;
      }*/
 
    return 0;
}
