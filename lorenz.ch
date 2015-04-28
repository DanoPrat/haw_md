#include <math.h>
#include <chplot.h>

// Versuchsparameter
#define H		0.002
#define T_END	120 //0.4

// ---- Funktionsdeklarationen ----
double Abl_X(double t){
	return -10*t ;
}

double Abl_Y(double t){
	return 6*y1 - 6 * Abl_V1(y1) * Abl_V1(y1) * y1 - Abl_V1(y1);
}

double Abl_Z(double t){
	return 
}


int main(){
	int steps = T_END/H;
	array double x[steps];
	
	class CPlot plot;
	int i;
	double h;

	x[0] = 0;

	for (i=0; i<steps; i++){
		x[i+1] = x[i] + H;
	}
	
	// RK2
	array double y1_rk[steps], y2_rk[steps];
	double l1, l2, k1, k2;
	y1_rk[0] = 1;
	y2_rk[0] = 0;
	
	for (i=0; i<steps; i++){
		k1 = H*Abl_V1(y2_rk[i]);
		l1 = H*Abl_V2(y1_rk[i]);
		
		k2 = H*Abl_V1(y2_rk[i] + l1/2);
		l2 = H*Abl_V2(y1_rk[i] + k1/2);
		
		y1_rk[i+1] = y1_rk[i] + k2;
		y2_rk[i+1] = y2_rk[i] + l2;
	}
	
	// ---- Funktionen zeichnen ----
	plot.data2D(x,y2);
	plot.data2D(x,y2_rk);
	plot.legend("Euler", 0);
	plot.legend("Ringel-Kötter", 1);
	plot.plotting();
}