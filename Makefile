NAME	=	libasm.a

SRCS		=	ft_strlen.s\
			ft_strcpy.s\
			ft_strcmp.s\
			ft_write.s\
			ft_read.s

CSRCS		=	main_write.c

OBJS		=	$(SRCS:.s=.o)

COBJS		=	$(CSRCS:.c=.o)


AS			=	nasm
ASFLAGS		=	-felf64


CC			=	clang

all:	$(NAME)

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

test_write:	ft_write.o main_write.o
		$(CC) -o $@ ft_write.o main_write.o && ./$@
		
test_read:	ft_read.o main_read.o
		$(CC) -o $@ ft_read.o main_read.o && ./$@

test_strlen:	ft_strlen.o main_strlen.o
		$(CC) -o $@ ft_strlen.o main_strlen.o && ./$@

test_strcpy:	ft_strcpy.o main_strcpy.o
		$(CC) -o $@ ft_strcpy.o main_strcpy.o && ./$@

test_strcmp:	ft_strcmp.o main_strcmp.o
		$(CC) -o $@ ft_strcmp.o main_strcmp.o && ./$@

test_strdup:	ft_strdup.o main_strdup.o
		$(CC) -o $@ ft_strdup.o main_strdup.o && ./$@

.PHONY: all, clean, fclean, re, test
