#include <stdio.h>
#include <math.h>
#include <thread>
#include <vector>

const int iXmax = 800;
const int iYmax = 800;
const double CxMin=-2.5;
const double CxMax=1.5;
const double CyMin=-2.0;
const double CyMax=2.0;
const int MaxColorComponentValue=255;
double PixelWidth=(CxMax-CxMin)/iXmax;
double PixelHeight=(CyMax-CyMin)/iYmax;
const int IterationMax=200;
const double EscapeRadius=2;
static unsigned char color [iYmax][iXmax][3];

void writeColor(int Ymin, int Ymax){

	int iX;
	int iY;
	double Cx,Cy;
    double Zx, Zy;
    double Zx2, Zy2; /* Zx2=Zx*Zx;  Zy2=Zy*Zy  */
   	int Iteration;
	double ER2=EscapeRadius*EscapeRadius;

	for(iY=Ymin; iY < Ymax; iY++)
	        {
	             Cy=CyMin + iY*PixelHeight;
	             if (fabs(Cy)< PixelHeight/2) Cy=0.0; /* Main antenna */
	             for(iX=0;iX<iXmax;iX++)
	             {
	                        Cx=CxMin + iX*PixelWidth;
	                        /* initial value of orbit = critical point Z= 0 */
	                        Zx=0.0;
	                        Zy=0.0;
	                        Zx2=Zx*Zx;
	                        Zy2=Zy*Zy;
	                        /* */
	                        for (Iteration=0;Iteration<IterationMax && ((Zx2+Zy2)<ER2);Iteration++)
	                        {
	                            Zy=2*Zx*Zy + Cy;
	                            Zx=Zx2-Zy2 +Cx;
	                            Zx2=Zx*Zx;
	                            Zy2=Zy*Zy;
	                        };
	                        /* compute  pixel color (24 bit = 3 bytes) */
	                        if (Iteration==IterationMax)
	                        { /*  interior of Mandelbrot set = black */
	                           color[iY][iX][0]=0;
	                           color[iY][iX][1]=0;
	                           color[iY][iX][2]=0;
	                        }
	                     else
	                        { /* exterior of Mandelbrot set = white */
	                             color[iY][iX][0]=255; /* Red*/
	                             color[iY][iX][1]=255;  /* Green */
	                             color[iY][iX][2]=255;/* Blue */
	                        };
	                        /*write color to the file*/

	                }
	        }
}

 int main(){

        FILE * fp;
        char* filename="new1.ppm";
        char* comment="# ";/* comment should start with # */

        fp= fopen(filename,"wb"); /* b -  binary mode */
        /*write ASCII header to the file*/
        fprintf(fp,"P6\n %s\n %d\n %d\n %d\n",comment,iXmax,iYmax,MaxColorComponentValue);
        std::vector<std::thread>vt;

        for(int i=0; i<8; i++){
        	vt.push_back(std::thread(writeColor, i*100, (i+1)*100));
        }
        for(auto &thread : vt){
        	if(thread.joinable())
        	{
        		thread.join();
        	}
        }

        fwrite(color,800*800*3,1,fp);
        fclose(fp);
        return 0;
 }
