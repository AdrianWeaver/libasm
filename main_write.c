#include <unistd.h>
#include <stdio.h>

size_t	ft_write(int fd, char *str, int len);

int main(void)
{
	printf("write\n");
	printf(" - write returned %ld \n", write(1, "test", 5));
	printf(" - write returned %ld \n", write(1, "", 5));
	printf(" - write returned %ld \n", write(3, "", 5));
	printf("ft_write\n");
	printf(" - write returned %ld \n", ft_write(0, "test", 5));
	printf(" - write returned %ld \n", ft_write(1, "", 5));
	printf(" - write returned %ld \n", ft_write(2, "", 5));
	return (0);
}
