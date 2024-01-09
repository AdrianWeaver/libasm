NAME	=	libasm.a

SRCS		=	ft_strlen.nasm\
			ft_strcpy.nasm\
			ft_strcmp.nasm\
			ft_write.nasm\
			ft_read.nasm

CSRCS		=	main_write.c

OBJS		=	$(SRCS:.nasm=.o)

COBJS		=	$(CSRCS:.c=.o)


AS			=	nasm
ASFLAGS		=	-felf64


CC			=	gcc

all:	$(NAME)

$(NAME):	$(OBJS)
			

main_%.o:		main_%.c
			$(CC) $< -c -o $@ 

%.o:  		%.nasm
			$(AS) $(ASFLAGS) $<

clean:		
		rm -rf $(OBJS)

fclean:		clean
			
re:			clean
			$(MAKE) all

test:	ft_write.o main_write.o
		$(CC) ft_write.o main_write.c && ./a.out