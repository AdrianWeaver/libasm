NAME	=	libasm.a

SRCS		=	ft_strlen.s\
			ft_strcpy.s\
			ft_strcmp.s\
			ft_write.s\
			ft_read.s\
			ft_strdup.s\
			ft_atoi_base.s

CSRCS		=	main_write.c

OBJS		=	$(SRCS:.s=.o)

COBJS		=	$(CSRCS:.c=.o)


AS			=	nasm
ASFLAGS		=	-felf64 -g


CC			=	clang

all:		$(NAME)

bonus:		all

$(NAME):	$(OBJS)


main_%.o:		main_%.c
			$(CC) $(CFLAGS) $< -c -o $@ 

%.o:  		%.s
			$(AS) $(ASFLAGS) $<

clean:
			rm -rf $(OBJS)

fclean:		clean
			
re:			clean
			$(MAKE) all

test:		test_strlen test_strcpy test_strcmp test_strdup test_write test_read

%_tester:	$(OBJS) main_%.o
			$(CC) -o $@ $^

test_%:		%_tester
			./$<

sandbox:	sandbox.o
			ld -o $@ $<
			gdb $@

.PHONY: all, clean, fclean, re, test, test_strlen, test_strcpy, test_strcmp, test_strdup, test_write, test_read
.SECONDARY:
