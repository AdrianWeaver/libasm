#include <stdio.h>

int	ft_atoi_base(char *nb, char *base);

int main(void)
{
	//printf("0x0A atoi_base: %d\n", ft_atoi_base("0A", "0123456789ABCDEF"));
	//printf("0xB atoi_base: %d\n", ft_atoi_base("B", "0123456789ABCDEF"));
	//printf("-0xB atoi_base: %d\n", ft_atoi_base("-B", "0123456789ABCDEF"));
	//printf("0x8 atoi_base: %d\n", ft_atoi_base("8", "0123456789ABCDEF"));
	printf("-0x1 atoi_base: %d\n", ft_atoi_base("-1", "-123456789ABCDEF"));
	printf("-++-----+-++++-+--------+++1 atoi:base %d\n", ft_atoi_base("-++-----+-++++-+--------+++1", "0123456789ABCDEF"));
	return (0);
}
