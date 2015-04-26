#include <math.h>
#include <chplot.h>

// Versuchsparameter
#define H		0.001
#define X_END	0.2 //0.4

// ---- Funktionsdeklarationen ----
double Abl_Y(double x, double y){
	return 10-500*y+5000*x;
}

/*
double Fkt_B(double t, double x, double y){
	return sin(2*M_PI*3*(t-0.25));
}
*/

int main(){
	int steps = X_END/H;
	array double x[steps], y[steps];
	
	class CPlot plot, lissajous;
	int i;
	double h;
		
	// Analytisch
	x[0] = 0;
	y[0] = 1;

	for (i=0; i<steps; i++){
		x[i+1] = x[i] + H;
		y[i+1] = 10*x[i+1] + exp(-500*x[i+1]);
	}
	
	// Euler explizit
	array double y_euler_expl[steps];
	y_euler_expl[0] = 1;
	
	for (i=0; i<steps; i++){
		y_euler_expl[i+1] = y_euler_expl[i]+H*Abl_Y(x[i], y_euler_expl[i]);
		//x[i+1] = x[i] + H;
	}
	
	// RK2
	array double y_ringel_k[steps];
	double k1, k2;
	y_ringel_k[0] = 1;
	
	for (i=0; i<steps; i++){
		k1 = H*Abl_Y(x[i], y_ringel_k[i]);
		k2 = H*Abl_Y(x[i]+H/2, y_ringel_k[i]+k1/2);
		y_ringel_k[i+1] = y_ringel_k[i] + k2;
	}
	
	// Euler implizit
	array double y_euler_impl[steps];
	
	// Analytische Lösung am Zielpunkt
	y_euler_impl[steps-1] = 10*x[steps-1] + exp(-500*x[steps-1]);
	
	for (i=steps-2; i>=0; i--){
		y_euler_impl[i+1] = y_euler_impl[i] + H*Abl_Y(x[i+1],y_euler_impl[i+1]);
	}
		
	// ---- Funktionen zeichnen ----
	plot.data2D(x,y);
	plot.data2D(x,y_euler_expl);
	plot.data2D(x,y_ringel_k);
	plot.data2D(x,y_euler_impl);
	//plot.data2D(t,y);
	plot.legend("Analytisch", 0);
	plot.legend("Euler Explizit", 1);
	plot.legend("Ringel-Kötter",2);
	plot.legend("Euler Implizit",3);
	plot.plotting();
	
	//lissajous.data2D(x, y);
	//lissajous.plotting();
}