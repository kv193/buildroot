#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/mman.h>
 
#define SIMPLE_DEVICE "/dev/simpler"
 
int main()
{
	int i, fd;
	char *p;
	fd = open(SIMPLE_DEVICE, O_RDWR);
		if (fd < 0) {
		perror("error in device");
		exit(1);
	}
	p = mmap(NULL, 1024, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
	if (p == MAP_FAILED) {
	perror("failed to mmap device");
        exit(1);
}
printf("mmap device ok p = %p\n",p);
for (i = 0; i < 1024; i++)
p[i] = 0x55;
 
for (i = 0; i < 1024; i++) {
if (p[i] != 0x55) {
printf(" memory write/read error! \n");
return -1;
}
}
printf(" memory write/read succeed\n");
close(fd);
return 0;
}
