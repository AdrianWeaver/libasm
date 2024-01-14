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

test_write:	ft_write.o main_write.o
		$(CC) ft_write.o main_write.c && ./a.out
		
test_read:	ft_read.o main_read.o
		$(CC) ft_read.o main_read.c && ./a.out

test_strlen:	ft_strlen.o main_strlen.o
		$(CC) ft_strlen.o main_strlen.c && ./a.out
