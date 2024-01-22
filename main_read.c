#include <unistd.h>

size_t	ft_read(int fd, char *str, size_t len);

int main()
{
	char str[1];
	for (;;) {
		if (ft_read(0, str, 1) == 0)
			break;
		write(1, str, 1);
	}
	return (0);
}
