#include <iostream>
#include <queue>

using namespace std;

int n;
int field[101][101];
int dir[5] = { 1, 0, -1, 0, 1 };
int number = 2;

void mapping(int r, int c, int num) {
    bool visited[101][101] = { false };
    queue< pair<int, int> > queue;

    queue.push(make_pair(r, c));
    while (!queue.empty()) {
        pair<int, int> coord = queue.front();
        queue.pop();

        int r = coord.first, c = coord.second;

        if (r < 0 || r >= n || c < 0 || c >= n || field[r][c] != 1 || visited[r][c]) { continue; }

        visited[r][c] = true;
        field[r][c] = num;

        for (int i = 0; i < 4; i++) {
            int nr = r + dir[i];
            int nc = c + dir[i + 1];

            queue.push(make_pair(nr, nc));
        }
    }
}

int bfs(int num) {
    queue< pair<int, int> > queue;
    bool visited[101][101] = { false };
    int result = 0;

    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            if (field[i][j] == num) {
                queue.push(make_pair(i, j));
                visited[i][j] = true;
            }
        }
    }

    while (!queue.empty()) {
        int s = queue.size();

        for (int i = 0; i < s; i++) {
            pair<int, int> coord = queue.front();
            queue.pop();

            int r = coord.first, c = coord.second;

            for (int i = 0; i < 4; i++) {
                int nr = r + dir[i];
                int nc = c + dir[i + 1];

                if (0 <= nr && nr < n && 0 <= nc && nc < n) {
                    if (field[nr][nc] != 0 && field[nr][nc] != num) {
                        return result;
                    } else if (field[nr][nc] == 0 && !visited[nr][nc]) {
                        visited[nr][nc] = true;
                        queue.push(make_pair(nr, nc));
                    }
                }
            }
        }
        result++;
    }

    return -1;
}

int solution() {
    int answer = 987654321;

    for (int i = 2; i < number; i++) {
        int res = bfs(i);

        if (res > 0) {
            answer = res < answer ? res : answer;
        }
    }

    return answer;
}

int main() {
    cin >> n;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            cin >> field[i][j];
        }
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (field[i][j] == 1) {
                mapping(i, j, number);
                number++;
            }
        }
    }

    cout << solution() << endl;
    return 0;
}