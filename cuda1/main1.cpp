// ***********************************************************************
//
// Demo program pro vyuku predmetu APPS (10/2012)
// Petr Olivka, katedra informatiky, FEI, VSB-TU Ostrava
// email:petr.olivka@vsb.cz
//
// Priklad pouziti CUDA technologie.
// Vyuziti funkce printf k identifikaci jednotlivych vlaken
//
// ***********************************************************************

#include <stdio.h>

// prototyp funkce v souboru .cu
void run_cuda();

int main()
{
	// volani funkce ze souboru .cu
	run_cuda();
	return 0;
}

