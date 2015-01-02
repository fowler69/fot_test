// ***********************************************************************
//
// Demo program pro vyuku predmetu APPS (10/2012)
// Petr Olivka, katedra informatiky, FEI, VSB-TU Ostrava
// email:petr.olivka@vsb.cz
//
// Priklad pouziti CUDA technologie.
// Ukazka organizace vlaken v blocich. 
// Kazde vlakno vypise informaci o sve pozici v bloku, 
// a polohu bloku v gridu.
//
// ***********************************************************************

#include <cuda.h>
#include <cuda_runtime.h>
#include <stdio.h>

// Demo kernel pro zobrazeni hierarchie vlaken
// POZOR! Funkce printf je dostupna od verze compute capability 2.x
__global__ void thread_hierarchy()
{
    // globalni promenne identifikujici vlakno
    // rozmery gridu -			gridDim
	// pozice bloku v gridu -	blockIdx
	// rozmery bloku -			blockDim
	// pozice vlakna v bloku -	threadIdx
    printf( "Block{%d,%d}[%d,%d] Thread{%d,%d}[%d,%d]\n",
	    gridDim.x, gridDim.y, blockIdx.x, blockIdx.y,
		blockDim.x, blockDim.y, threadIdx.x, threadIdx.y );
}

void run_cuda()
{
	cudaError_t cerr;
    // nasledujicim prikazem je mozno zvetsit vnitrni buffer pro printf
	/*cerr = cudaDeviceSetLimit( cudaLimitPrintfFifoSize, required_size );
	if ( err != cudaSuccess )
		printf( "CUDA Error [%d] - '%s'\n", __LINE__, cudaGetErrorString( cerr ) );
    */

	// vytvoreni vlaken se zvolenym kernelem
	// prvni parametr dim3 urcuje rozmer gridu
	// druhy parametr dim3 urcuje rozmer bloku
    thread_hierarchy<<< dim3( 2, 2 ), dim3( 3, 3 )>>>();

	if ( ( cerr = cudaGetLastError() ) != cudaSuccess )
		printf( "CUDA Error [%d] - '%s'\n", __LINE__, cudaGetErrorString( cerr ) );

	// vystupy funkce printf jsou ulozeny v pameti graficke karty,
	// nutno provest synchronizeci, aby se zobrazily
	cudaDeviceSynchronize();
}