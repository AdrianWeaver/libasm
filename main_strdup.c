#include <string.h>
#include <stdio.h>
#include <stdlib.h>

char	*ft_strdup(const char *src);

int	main(void)
{
	//char src[] = "This is my source input";
	char src[] = "test";

	char *dest;

	{
		dest = strdup(src);
		printf("reallibc dest: %s\n", dest);
		free(dest);
		dest = NULL;
	}
	{
		dest = ft_strdup(src);
		printf("mylibasm dest: %s\n", dest);
		free(dest);
	}
	return (0);
}
