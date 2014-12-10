/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <stdio.h>
#include <alt_types.h>

#define DATA_SIZE 100
#define D_STRT 40
#define D_END (D_STRT + 32)

#define pccm_ctl (volatile char*) 0x00004030
#define pccm_rsp (volatile char*) 0x00004020


int main()
{
	int i;
	alt_u16 data[DATA_SIZE] = {0x5260, 0x54A0, 0x1220, 0xA268, 0x126F, 0x126F, 0x126A, 0x14A9, 0x7440, 0x4000};
	*pccm_ctl = 1;
	volatile alt_u16* pcm_mem_base = 0x00002000;

	for(i = 0; i < 2048; i++)
	{
		pcm_mem_base[i] = 0x6666;
	}

	printf("Copying Data to PCM Memory\n");
	for(i = 0; i < DATA_SIZE; i++)
	{
		pcm_mem_base[i] = data[i];
	}
	printf("Data has been copied to PCM Memory\n");

	printf("Initializing Processor\n");

	*pccm_ctl = 5;
	for(i = 0; i < 1000; i++);
	*pccm_ctl = 0;

	while(*pccm_rsp != 5);
	*pccm_ctl = 1;
	while(*pccm_rsp != 1);
	printf("Processor Initialized\n");

	*pccm_ctl = 2;
	while(*pccm_rsp != 3);
	printf("PCM finished computation\n");

	printf("[");
	for(i = D_STRT; i < D_END; i++)
	{
		printf("%i, \n", pcm_mem_base[i]);
	}
	printf("]");

	printf("PROGRAM END\n");






  return 0;
}
