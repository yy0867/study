#include <iostream>
#include <string>

using namespace std;

int main() {
    int total = 0;

    for (int i = 0; i < 5; ++i) {
        string start = "", end = "";

        cin >> start;
        cin >> end;

        int s = int((start[0] - '0') * 10 + (start[1] - '0')) * 60 + int((start[3] - '0') * 10 + (start[4] - '0'));
        int e = int((end[0] - '0') * 10 + (end[1] - '0')) * 60 + int((end[3] - '0') * 10 + (end[4] - '0'));
        
        total += (e - s);
    }

    cout << total << endl;

    return 0;
}