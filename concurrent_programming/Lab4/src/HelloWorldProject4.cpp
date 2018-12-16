#include <thread>
#include <iostream>
#include <thread>

int LEVEL = 7;
int N = 1024;


void calculate_area(int x_from, int x_to, int y_from, int y_to, int** arr, int level) {
	if(level > LEVEL) {
		return;
	}

	int x_1 = (x_to - x_from) / 2;
	int y_1 = (y_to - y_from) / 2;

	for(int x = x_from; x < x_from + x_1; x++){
		arr[x][y_from + y_1] = 1;
	}
	for(int y = y_from + y_1; y < y_to; y++){
		arr[x_from + x_1][y] = 1;
	}
	for(int x = x_from, y = y_from + y_1; x < x_from + x_1 && y < y_to; y++, x++){
		arr[x][y] = 1;
	}
    std::thread t[3];
    t[0] = std::thread(calculate_area, x_from, x_from + x_1, y_from, y_from + y_1, arr, level + 1); // left
    t[1] = std::thread(calculate_area, x_from, x_from + x_1, y_from + y_1, y_to, arr, level + 1);  // right
    t[2] = std::thread(calculate_area, x_from + x_1, x_to, y_from + y_1, y_to, arr, level + 1);  // down

    for (int i = 0; i < 3; i++) {
		t[i].join();
	}
}

int main() {
	int **TRIANGLE = new int*[N];

	for(int i = 0; i<N; i++) {
		TRIANGLE[i] = new int[N];
	}

	for(int i = 0; i < N; i++) {
		for(int j = 0; j < N; j++) {
			TRIANGLE[i][j] = 0;
		}
	}

	for(int i = 0; i < N; i++) {
		TRIANGLE[i][i] = 1;
		TRIANGLE[0][i] = 1;
		TRIANGLE[i][N - 1] = 1;
	}

	calculate_area(0, N, 0, N, TRIANGLE, 0);

    FILE * fp;
	char *filename="new1.ppm";
	static unsigned char color[3];
	fp= fopen(filename,"wb");
    const int iXmax = 1024;
    const int iYmax = 1024;
    const int MaxColorComponentValue=255;
    char *comment="# ";/* comment should start with # */
    fprintf(fp,"P6\n %s\n %d\n %d\n %d\n",comment,iXmax,iYmax,MaxColorComponentValue);

	for(int i = 0; i < N; i++) {
		for(int j = 0; j < N; j++) {
			color[0] = TRIANGLE[i][j] * MaxColorComponentValue;
			color[1] = TRIANGLE[i][j] * MaxColorComponentValue;
			color[2] = TRIANGLE[i][j] * MaxColorComponentValue;
			fwrite(color,1,3,fp);
		}
	}
	std::cout << "DONE" << std::endl;

    fclose(fp);
    return 0;
}
