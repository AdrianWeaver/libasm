#include <stdio.h>
#include <string.h>

char	*ft_strcpy(char *dst, char *src);

int	main(void)
{
	{
		char src[] = { "i am here" };
		char dst[19];
		char *ret;

		ret = strcpy(dst, src);
		printf("saved ret = %p\n", dst);
		printf("strcpy\nsrc = %s\n", src);
		printf("dst = %s\n", dst);
		printf("ret = %p\n", dst);
	}
	{
		char src[] = { "i am here" };
		char dst[19];
		char *ret;

		printf("saved ret = %p\n", dst);
		ret = ft_strcpy(dst, src);
		printf("ft_strcpy\nsrc = %s\n", src);
		printf("dst = %s\n", dst);
		printf("ret = %p\n", dst);
	}
	return (0);
}
