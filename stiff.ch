#include <math.h>
#include <chplot.h>

// Versuchsparameter
#define H		0.005
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
	
	class CPlot plot, deviation;
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
	
	y_euler_impl[0] = 1;
	
	for(i=0; i<steps; i++){
		y_euler_impl[i+1] = (y_euler_impl[i] + 10*H + 5000*H*x[i+1]) / (1 + 500*H);
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
	
	// compute deviation
	array double dev_eul_expl[steps];
	array double dev_rng_ktt[steps];
	array double dev_eul_impl[steps];
	
	for(i=0;i<steps;i++){
		dev_eul_expl[i] = abs(y_euler_expl[i] - y[i]);
		dev_rng_ktt[i] = abs(y_ringel_k[i] - y[i]);
		dev_eul_impl[i] = abs(y_euler_impl[i] - y[i]);
	}
	
	deviation.data2D(x, dev_eul_expl);
	deviation.data2D(x, dev_rng_ktt);
	deviation.data2D(x, dev_eul_impl);
	deviation.legend("Abw. Euler Explizit", 0);
	deviation.legend("Abw. Ringel-Kötter", 1);
	deviation.legend("Abw. Euler Implizit",2);
	deviation.plotting();
}