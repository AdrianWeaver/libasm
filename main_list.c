#include <stdio.h>
#include <stdlib.h>

typedef struct s_list
{
	void			*data;
	struct s_list	*next;
}	t_list;

void	ft_list_push_front(t_list **begin, t_list *data);

int	ft_remove_if(t_list **begin, void *data_ref, int (*cmp)(), void (*free_fct)(void*));

int lower(void *data, int value)
{
	return (!(*(int*)data < value));
}

void	freemium(int	*data)
{
	free(data);
}

int	main(void)
{
	{
		t_list	*begin;
		t_list	myList;
		t_list	myNewNode;
		int		nb = 42;
		int		nb2 = 44;

		begin = &myList;
		myList.data = &nb; myList.next = NULL;
		myNewNode.data = &nb2;
		myNewNode.next = NULL;

		//Testing add_front
		printf("list size before add_front: %d\n", ft_list_size(begin));
		printf("Before push_front:\nbegin.data = %d, next = %p\n", *((int *)(begin->data)), begin->next);
		ft_list_push_front(&begin, &myNewNode);

		printf("After push_front:\nbegin->data = %d, next = %p\n", *((int *)(begin->data)), begin->next);

		//TESTING SIZE
		printf("list size after push_front: %d\n", ft_list_size(begin));
		printf("list_size a NULL: %d\n", ft_list_size(NULL));

		//TESTING REMOVE IF
		ft_remove_if(&begin, 42, &lower, &freemium);
		for (;;){
			printf("Node: %d\n", *(int*)begin->data);
			begin = begin->next;
			if (!begin)
				break;
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
	}


	return (0);
}
