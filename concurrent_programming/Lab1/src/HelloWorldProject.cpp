#include <iostream>
#include <thread>

//This function will be called from a thread


void calculate_matrix_pos(int i, int j, float** X, float** Y, float** A) {
	A[i][j] = 0;
	for(int k = 0; k < 3; k++) {
		A[i][j] += X[i][k] * Y[k][j];
	}
}

void display(float** X, int n, int m) {
	for(int i = 0; i < n; i++) {
		for(int j = 0; j < m; j++) {
			std::cout << X[i][j] << " ";
		}
		std::cout << std::endl;
	}
}

float** multiply(float** A, float** B, int n, int m) {
	int num_threads = n * m;
    std::thread t[num_threads];
	float** X = new float*[n];
	for(int i = 0; i<m; i++) {
		X[i] = new float[m];
	}
	display(X, n, m);
	//Launch a group of threads
	for (int i = 0; i < n; i++) {
		for(int j = 0; j < m; j++) {
			t[i * 3 + j] = std::thread(calculate_matrix_pos, i, j, A, B, X);
		}
	}

	//Join the threads with the main thread
	for (int i = 0; i < num_threads; i++) {
		t[i].join();
	}
	display(X, n, m);
	return X;
}

int main() {
	int n = 20;
	int m = 20;

	float** A = new float*[n];
	float** B = new float*[n];
	float** C = new float*[n];
	float** T = new float*[n];
	float** D = new float*[n];
	for(int i = 0; i<m; i++) {
		A[i] = new float[m];
		B[i] = new float[m];
		C[i] = new float[m];
		T[i] = new float[m];
		D[i] = new float[m];
	}

	// initialize
	for(int i = 0; i < n*m; i++) {
		A[i/3][i%3] = (float) i;
		B[i/3][i%3] = (float) i;
		C[i/3][i%3] = (float) i;
	}

    T = multiply(A, B, n, m);
    D = multiply(T, C, n, m);

    return 0;
}
