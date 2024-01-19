#include <stdio.h>
#include <stdlib.h>

typedef struct s_list
{
	void			*data;
	struct s_list	*next;
}	t_list;

void	ft_list_push_front(t_list **begin, t_list *data);

int	ft_remove_if(t_list **begin, void *data_ref, int (*cmp)(), void (*free_fct)(void*));

int lower(void *data, void *data_ref)
{
	return (!(*(int*)data < *(int*)data_ref));
}

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

int	main(void)
{
	srand(0);
	{
		t_list	*begin;
		int		nb = 42;

		begin = create_random_list(42);
		ft_print_list(begin);
		//TESTING REMOVE IF
		ft_remove_if(&begin, &nb, &lower, &freemium);
		printf("%s\n", "AFTER REMOVE IF");
		ft_print_list(begin);
		for (;;){
			t_list	*next;

			if (!begin)
				break;
			next =	begin->next;
			free(begin->data);
			free(begin);
			begin = next;
		}
	}

	//TESTING SORT
	printf("%s\n", "\n\n\nTESTING SORT\n\n");
	{
		t_list *begin;

		begin = NULL;
		for (int i = 0; i < 10; i++){
			t_list	*node;
			int		*tmp;

			node = malloc(sizeof(*node) * 1);
			tmp = malloc(sizeof(*tmp) * 1);
			*tmp = i;
			node->data = tmp;
			ft_list_push_front(&begin, node);
		}
		for (int i = 0; i < 10; i++){
			t_list	*tmp;
			printf("list node %d value: %d next: %p\n",
					i,
					*((int*)(begin->data)),
					begin->next);
			tmp = begin;
			free(begin->data);
			begin = begin->next;
			free(tmp);
		}
		//ft_list_sort(&begin);
		for (;;){
			t_list	*next;

			if (!begin)
				break;
			next =	begin->next;
			free(begin->data);
			free(begin);
			begin = next;
		}
	}


	return (0);
}
