#include <stdio.h>

int	ft_atoi_base(char *nb, char *base);

int main(void)
{
	printf("base 10: 10 : %d\n", ft_atoi_base("10", "0123456789"));
	printf("base 10: -10 : %d\n", ft_atoi_base("-10", "0123456789"));
	printf("base 10: 0 : %d\n", ft_atoi_base("0", "0123456789"));
	printf("base 10: 1 : %d\n", ft_atoi_base("1", "0123456789"));
	printf("base 10: -1 : %d\n", ft_atoi_base("-1", "0123456789"));
	printf("INT_MAX 2147483647: %d\n", ft_atoi_base("2147483647", "0123456789"));
	printf("INT_MIN -2147483648: %d\n", ft_atoi_base("-2147483648", "0123456789"));
	printf("0x0A atoi_base: %d\n", ft_atoi_base("0A", "0123456789ABCDEF"));
	printf("0xB atoi_base: %d\n", ft_atoi_base("B", "0123456789ABCDEF"));
	printf("-0xB atoi_base: %d\n", ft_atoi_base("-B", "0123456789ABCDEF"));
	printf("0x8 atoi_base: %d\n", ft_atoi_base("8", "0123456789ABCDEF"));
	printf("-0x1 atoi_base: %d\n", ft_atoi_base("-1", "-123456789ABCDEF"));
	printf("-++-----+-++++-+--------+++1 atoi:base %d\n", ft_atoi_base("-++-----+-++++-+--------+++1", "0123456789ABCDEF"));
	return (0);
}
