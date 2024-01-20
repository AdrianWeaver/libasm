NAME	=	libasm.a

SRCS		=	ft_strlen.s\
			ft_strcpy.s\
			ft_strcmp.s\
			ft_write.s\
			ft_read.s\
			ft_strdup.s\
			ft_atoi_base.s\
			ft_list_push_front.s\
			ft_list_size.s\
			ft_list_sort.s\
			ft_list_remove_if.s

CSRCS		=	main_write.c\
				main_read.c\
				main_atoi_base.c\
				main_size.c\
				main_remove_if.c\
				main_sort.c\
				main_strcmp.c\
				main_strcpy.c\
				main_strdup.c\
				main_strlen.c

OBJS		=	$(SRCS:.s=.o)

COBJS		=	$(CSRCS:.c=.o)


AS			=	nasm
ASFLAGS		=	-felf64 -g


CC			=	clang
CFLAGS	=	-g3

all:		$(NAME)

bonus:		all

$(NAME):	$(OBJS)
			ar -rcs $@ $(OBJS)

main_%.o:	main_%.c
			$(CC) $(CFLAGS) $< -c -o $@ 

%.o:  		%.s
			$(AS) $(ASFLAGS) $<

clean:
			rm -rf $(OBJS)
			rm -rf $(COBJS)

fclean:		clean
			rm -rf $(NAME)
			rm -rf *_tester
			
re:			clean
			$(MAKE) all

test:		test_strlen test_strcpy test_strcmp test_strdup test_write test_remove_if test_sort

%_tester:	main_%.o $(NAME) 
			$(CC) $(CFLAGS) -o $@ $^

test_%:		%_tester
			./$<

vtest_%:	%_tester
			valgrind ./$<

.PHONY: all, clean, fclean, re, test*
.SECONDARY:
