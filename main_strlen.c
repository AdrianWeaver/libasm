#include <stdio.h>
#include <string.h>

size_t	ft_strlen(char *str);

int main(int argv, char **argc)
{
	char str[] = { "wesh alors" };

	printf("strlen %ld\n", strlen(str));
	printf("ft_strlen %ld \n", ft_strlen(str));

	printf("strlen %ld\n", strlen("huhuhuhuhuhuhuhuhuhuhuhuhuhuhuuhuhuh"));
	printf("ft_strlen %ld \n", ft_strlen("huhuhuhuhuhuhuhuhuhuhuhuhuhuhuuhuhuh"));
	return (0);
}
