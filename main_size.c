#include <stdio.h>
#include <stdlib.h>

typedef struct s_list
{
	void			*data;
	struct s_list	*next;
}	t_list;

void	ft_list_push_front(t_list **begin, t_list *data);
int		ft_list_size(t_list *begin);

t_list	*create_random_list(unsigned int size)
{
	t_list	*begin;

	begin = NULL;
	for (unsigned int i = 0; i < size; i++){
		t_list	*tmp;
		int		*data;

		tmp = malloc(sizeof(*tmp));
		data = malloc(sizeof(*data));
		tmp->data = data;
		*data = rand() % 100;
		ft_list_push_front(&begin, tmp);
		if (i == size - 1)
			return (tmp);
	}
	return (begin);
}

void	freemium(void *data)
{
	free(data);
}

void	ft_print_list(t_list *list)
{
	for (int i = 0;;i++){
		if (list == NULL)
			return;
		if (list->data == NULL){
			printf("Node %d: %s\n", i, "empty data");
			continue;
		}
		else
			printf("Node %d: %d\n", i, *(int*)list->data);
		list = list->next;
	}
}

void	ft_clear_list(t_list *list, void (*free_function)(void*))
{
	for (;;){
		t_list	*next;

		if (!list)
			break;
		next =	list->next;
		(*free_function)(list->data);
		free(list);
		list = next;
	}
}

int	main(void)
{
	srand(0);
	t_list	*begin;
	int		nb = 42;

	begin = NULL;
	printf("Size of an empty list: %d\n", ft_list_size(begin));
	begin = create_random_list(nb);
	printf("creating a list of size %d\n", nb);
	ft_print_list(begin);
	printf("Size of list according to ft_list_size: %d\n", ft_list_size(begin));
	ft_clear_list(begin, &freemium);
	return (0);
}

