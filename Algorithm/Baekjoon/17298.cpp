#include <iostream>
#include <stack>
#define MAX 1000001

using namespace std;

int n;
int seq[MAX];
int answer[MAX];

void solution() {
    stack<int> stack;

    for (int i = n - 1; i >= 0; --i) {
        while (!stack.empty() && stack.top() <= seq[i]) {
            stack.pop();
        }

        if (stack.empty()) {
            answer[i] = -1;
        } else {
            answer[i] = stack.top();
        }

        stack.push(seq[i]);
    }

    for (int i = 0; i < n; ++i) {
        cout << answer[i] << " ";
    }
}

int main() {
    cin >> n;
    for (int i = 0; i < n; ++i) {
        cin >> seq[i];
    }

    solution();

    return 0;
}