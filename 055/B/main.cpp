#include <iostream>
#include <string>
#include <algorithm>
using namespace std;

int main() {
    int n;
    cin >> n;

    long long cur = 1;
    for(int i = 1; i <= n; i++) {
        cur *= i;
        cur %= 1000000007;
    }
    
    cout << cur << endl;
    return 0;
}