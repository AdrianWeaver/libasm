#include <stdio.h>
#include <string.h>

int		ft_strcmp(char *dst, char *src);

int	main(void)
{
	{
		char str[2];
		str[0] = 1;
		str[1] = 0;
		char str2[2];
		str2[0] = 2;
		str2[1] = 0;
		printf("strcmp\n");
		printf("%d\n", strcmp(str, str2));
		printf("%d\n", strcmp("wesh", "alors"));
		printf("%d\n", strcmp("wesh", "wesh"));
		printf("%d\n", strcmp("alors", "wesh"));
		printf("%d\n", strcmp("A", "B"));
	}
	{
		char str[2];
		str[0] = 1;
		str[1] = 0;
		char str2[2];
		str2[0] = 2;
		str2[1] = 0;
		printf("ft_strcmp\n");
		printf("%d\n", ft_strcmp(str, str2));
		printf("%d\n", ft_strcmp("wesh", "alors"));
		printf("%d\n", ft_strcmp("wesh", "wesh"));
		printf("%d\n", ft_strcmp("alors", "wesh"));
		printf("%d\n", ft_strcmp("A", "B"));
	}

	return (0);
}
