#include <math.h>
#include <chplot.h>

// Versuchsparameter
#define H		0.01
#define T_END	1.1

// ---- Funktionsdeklarationen ----
double Fkt_A(double t, double x, double y){
	return sin(2*M_PI*1*t);
}

double Fkt_B(double t, double x, double y){
	return sin(2*M_PI*3*(t-0.25));
}

int main(){
	int steps = T_END/H;
	array double t[steps], x[steps], y[steps];
	
	class CPlot plot, lissajous;
	int i;
	
	// Initialisieren
	x[0] = 0;
	y[0] = 1;
	t[0] = 0;
	
	// Funktionswerte berechnen
	for (i=0; i<steps; i++){
		x[i+1] = Fkt_A(t[i], x[i], y[i]);
		y[i+1] = Fkt_B(t[i], x[i], y[i]);
		t[i+1] = t[i] + H;
	}
	
	// Funktionen zeichnen
	plot.data2D(t,x);
	plot.data2D(t,y);
	plot.legend("Funktion A", 0);
	plot.legend("Funktion B", 1);
	plot.plotting();
	
	//lissajous.data2D(x, y);
	//lissajous.plotting();
}