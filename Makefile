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

write_tester:	ft_write.o main_write.o 
		$(CC) -o $@ ft_write.o main_write.o && ./$@
		
read_tester:	ft_read.o main_read.o
		$(CC) -o $@ ft_read.o main_read.o && ./$@

strlen_tester:	ft_strlen.o main_strlen.o
		$(CC) -o $@ ft_strlen.o main_strlen.o && ./$@

strcpy_tester:	ft_strcpy.o main_strcpy.o
		$(CC) -o $@ ft_strcpy.o main_strcpy.o && ./$@

strcmp_tester:	ft_strcmp.o main_strcmp.o
		$(CC) -o $@ ft_strcmp.o main_strcmp.o && ./$@

strdup_tester:	ft_strdup.o main_strdup.o
		$(CC) -o $@ ft_strdup.o main_strdup.o && ./$@

test_%:		%_tester
				./$<


.PHONY: all, clean, fclean, re, test, test_strlen, test_strcpy, test_strcmp, test_strdup, test_write, test_read
