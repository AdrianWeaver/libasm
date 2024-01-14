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

%_tester:	ft_%.o main_%.o 
			@echo "called %_tester"
			$(CC) -o $@ $^
		
test_%:		%_tester
			@echo "called test_%"
			./$<

.PHONY: all, clean, fclean, re, test, test_strlen, test_strcpy, test_strcmp, test_strdup, test_write, test_read
