#include <stdio.h>
#include <string.h>

int		ft_strcmp(char *dst, char *src);

int	main(void)
{
	{
		printf("%d\n", strcmp("wesh", "alors"));
		printf("%d\n", strcmp("wesh", "wesh"));
		printf("%d\n", strcmp("alors", "wesh"));
	}
	{
		printf("%d\n", ft_strcmp("wesh", "alors"));
		printf("%d\n", ft_strcmp("wesh", "wesh"));
		printf("%d\n", ft_strcmp("alors", "wesh"));
	}

	return (0);
}
