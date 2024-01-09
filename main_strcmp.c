#include <stdio.h>
#include <string.h>

int		ft_strcmp(char *dst, char *src);

int	main(void)
{
	{
		char	str[2];
		str[0] = 1;
		str[1] = 0;
		char	str2[2];
		str2[0] = 2;
		str2[1] = 0;
		char	str3[2];
		str3[0] = 127;
		str3[1] = 0;
		char	str4[2];
		str4[0] = -128;
		str4[1] = 0;
		char	str5[2];
		str5[0] = -2;
		str5[1] = 0;
		printf("strcmp\n");
		printf("NULL: %d\n", strcmp(NULL, NULL));
		printf("2 - 1: %d\n", strcmp(str, str2));
		printf("127 - -128: %d\n", strcmp(str4, str3));
		printf("1 - -128: %d\n", strcmp(str4, str));
		printf("127 - -2: %d\n", strcmp(str3, str5));
		printf("jcourtoislabg - j: %d\n", strcmp("j", "jcourtoilabg"));
		printf("alors - wesh: %d\n", strcmp("wesh", "alors"));
		printf("wesh - wesh: %d\n", strcmp("wesh", "wesh"));
		printf("wesh - alors: %d\n", strcmp("alors", "wesh"));
		printf("B - A: %d\n", strcmp("A", "B"));
	}
	{
		char str[2];
		str[0] = 1;
		str[1] = 0;
		char str2[2];
		str2[0] = 2;
		str2[1] = 0;
		char	str3[2];
		str3[0] = 127;
		str3[1] = 0;
		char	str4[2];
		str4[0] = -128;
		str4[1] = 0;
		char	str5[2];
		str5[0] = -2;
		str5[1] = 0;
		printf("ft_strcmp\n");
		printf("NULL: %d\n", ft_strcmp(NULL, NULL));
		printf("2 - 1: %d\n", ft_strcmp(str, str2));
		printf("127 - -128: %d\n", ft_strcmp(str4, str3));
		printf("1 - -128: %d\n", ft_strcmp(str4, str));
		printf("127 - -2: %d\n", ft_strcmp(str3, str5));
		printf("jcourtoislabg - j: %d\n", ft_strcmp("j", "jcourtoilabg"));
		printf("alors - wesh: %d\n", ft_strcmp("wesh", "alors"));
		printf("wesh - wesh: %d\n", ft_strcmp("wesh", "wesh"));
		printf("wesh - alors: %d\n", ft_strcmp("alors", "wesh"));
		printf("B - A: %d\n", ft_strcmp("A", "B"));
	}
	return (0);
}
