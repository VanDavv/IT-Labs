#include <iostream>
#include <thread>
#include <stdio.h>

//This function will be called from a thread


int calculate_pos(int i, int j, int** A, int n, int m) {
	int alive = 0;
	int start_x = i - 1, end_x = i + 1, start_y = j - 1, end_y = j + 1;
	if(i == 0) {
		start_x = i;
	}
	if(i == m - 1) {
		end_x = j;
	}
	if(j == 0) {
		start_y = j;
	}
	if(j == n - 1) {
		end_y = j;
	}
	for(int x = start_x; x <= end_x; x++) {
		for(int y = start_y; y <= end_y; y++) {
			if(x == i && y == j) {
				continue;
			}
			if(A[x][y] == 1) {
				alive++;
			}
		}
	}

	if(alive == 3) {
		return 1;
	}
	if(alive == 2 && A[i][j] == 1) {
		return 1;
	}
	return 0;
}

void calculate_area(int x_from, int x_to, int y_from, int y_to, int** source, int** dest, int n, int m) {
	for(int x = x_from; x <= x_to; x++){
		for(int y = y_from; y <= y_to; y++){
			dest[x][y] = calculate_pos(x, y, source, n, m);
		}
	}
}

void display(int** X, int n, int m) {
	for(int i = 0; i < n; i++) {
		for(int j = 0; j < m; j++) {
			if(X[i][j] == 1) {
				std::cout << '+';
			} else {
				std::cout << '-';
			}
		}
		std::cout << std::endl;
	}
	std::cout << std::endl;
}

int main() {
	int n = 20;
	int m = 20;

	int **game[2] = {new int*[n], new int*[n]};

	for(int i = 0; i<m; i++) {
		game[0][i] = new int[m];
		game[1][i] = new int[m];
	}

	game[0][1][2] = 1;
	game[0][2][2] = 1;
	game[0][3][2] = 1;
	display(game[0], n, m);

	int threads_x = 2;
	int threads_y = 2;
	int num_threads = threads_x * threads_y;
    std::thread t[num_threads];

    int cnt = 0;

    while(cnt < 10) {
    	cnt++;
		//Launch a group of threads
		for (int i = 0; i < threads_x; i++) {
			for(int j = 0; j < threads_y; j++) {
				int start_x = i * (n / threads_x);
				int end_x = (i + 1) * (n / threads_x) - 1;
				int start_y = j * (m / threads_y);
				int end_y = (j+1) * (m / threads_y) - 1;
				t[i * threads_y + j] = std::thread(calculate_area, start_x, end_x, start_y, end_y, game[0], game[1], n, m);
			}
		}

		//Join the threads with the main thread
		for (int i = 0; i < num_threads; i++) {
			t[i].join();
		}
		display(game[1], n, m);
		for(int a = 0; a<m; a++) {
			for(int b = 0; b<m; b++) {
				game[0][a][b] = game[1][a][b];
				game[1][a][b] = 0;
			}
		}
	}

    return 0;
}
