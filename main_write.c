#include <unistd.h>
#include <stdio.h>

int main(void)
{
	printf(" - printed %ld characters\n", write(1, "test", 5));
	printf(" - printed %ld characters\n", write(1, "", 5));
	return (0);
}
