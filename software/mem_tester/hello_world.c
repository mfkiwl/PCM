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

#define pccm_ctl (volatile char*) 0x00004030
#define pccm_rsp (volatile char*) 0x00004020


int main()
{
	*pccm_ctl = 0;
	volatile char* pcm_mem_base = 0x00002000;
	volatile alt_u16* pcm_mem_base_w = 0x00002000;

	int i;

	for(i = 0; i < 4096; i += 1)
	{
		*(pcm_mem_base + i) = 3;
	}

	for(i = 0; i < 4096; i += 1)
	{
		if( *(pcm_mem_base + i) != 3)
			printf("address: %x not initialized\n", pcm_mem_base + i);
	}

	printf("Completed mem init\n");

	*pccm_ctl = 2;
	while(*pccm_rsp != 4 && *pccm_rsp != 8);
	if(*pccm_rsp == 8)
	{
		printf("ERROR");
		return 0;
	}
	*pccm_ctl = 4;
	while(*pccm_rsp != 0);

	printf("Completed mem change\n");


	for(i = 0; i < 4096/2; i += 1)
	{
		if( *(pcm_mem_base + i) != 1)
			printf("address: %x : %x\n", pcm_mem_base + i, *(pcm_mem_base + i));
		//else
		//	printf("address: %x changed, %i\n", pcm_mem_base + i, *(pcm_mem_base + i));
	}


	for(i = 0; i < 4096/2; i += 1)
	{

		printf("address: %x : %x\n", pcm_mem_base_w + i, *(pcm_mem_base_w + i));
		//else
		//	printf("address: %x changed, %i\n", pcm_mem_base + i, *(pcm_mem_base + i));
	}

	printf("PROGRAM END\n");






  return 0;
}
