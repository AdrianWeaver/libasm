#include <stdio.h>

typedef struct s_list
{
	void			*data;
	struct s_list	*next;
}	t_list;

void	ft_list_push_front(t_list **begin, t_list *data);

int	main(void)
{
	t_list	*begin;
	t_list	myList;
	t_list	myNewNode;
	int		nb = 42;
	int		nb2 = 44;

	begin = &myList;
	myList.data = &nb;
	myList.next = NULL;
	myNewNode.data = &nb2;
	myNewNode.next = NULL;

	//Testing add_front
	printf("list size before add_front: %d\n", ft_list_size(begin));
	printf("Before push_front:\nbegin.data = %d, next = %p\n", *((int *)(begin->data)), begin->next);
	ft_list_push_front(&begin, &myNewNode);

	printf("After push_front:\nbegin->data = %d, next = %p\n", *((int *)(begin->data)), begin->next);

	//Testing size
	printf("list size after push_front: %d\n", ft_list_size(begin));
	printf("list_size a NULL: %d\n", ft_list_size(NULL));

	return (0);
}
