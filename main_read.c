#include <unistd.h>

size_t	ft_read(int fd, char *str, size_t len);

int main()
{
	char str[1];
	for (;;) {
		ft_read(0, str, 1);
		write(1, str, 1);
	}
	return (0);
}
