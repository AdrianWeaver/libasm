#include <stdio.h>

int	ft_atoi_base(char *nb, char *base);

int main(void)
{
	printf("0x0A%d\n", ft_atoi_base("0A", "0123456789ABCDEF"));
	return (0);
}
