#include <iostream>
#include <math.h>
#include <fstream>
#include <omp.h>

#define LEVEL 8
using namespace std;

char triangle[1024][1024] = {0};
const int N = 1024;

void fun(int y, int x, int level);

int main()
{
    fun(0, 0, 0);
    std::ofstream plik;
    plik.open("new.ppm", std::ofstream::out | std::ofstream::binary);
    const char *napis = "P6\n#\n1024\n1024\n255\n";
    plik.write(napis, 19);
    for (int i = 0; i < 1024; i++)
        for (int j = 0; j < 1024; j++)
        {
            plik.write(*(triangle + i) + j, 1);
            plik.write(*(triangle + i) + j, 1);
            plik.write(*(triangle + i) + j, 1);
        }
    plik.close();
    return 0;
}

void fun(int y, int x, int level)
{
    int size = N / pow(2.0, 1.0 * level);

    for (int i = 0; i < size; i++)
    {
        triangle[y + i][x] = 255;
        triangle[y + size - 1][x + i] = 255;
        triangle[y + i][x + i] = 255;
    }
    if (level + 1 < LEVEL)
    {
#pragma omp task
        fun(y, x, level + 1);
#pragma omp task
        fun(y + size / 2, x, level + 1);
#pragma omp task
        fun(y + size / 2, x + size / 2, level + 1);
#pragma omptask wait
    }
}
