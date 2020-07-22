##
## EPITECH PROJECT, 2019
## epitech-makefile
## File description:
## Generic Makefile for Epitech
##

SHELL	=	bash

SRC 	=	src/your-source.c	\

OBJ 	=	$(SRC:.c=.o)

MAIN_SRC	=	src/main.c 	\

MAIN_OBJ	=	$(MAIN_SRC:.c=.o)

TEST_SRC	=	tests/test_your_test.c	\

TEST_OBJ	=	$(TEST_SRC:.c=.o)

CFLAGS	=	-I./include -Wall -Wextra -pedantic

LFLAGS	=	-L./lib -lmy

TEST_LFLAGS	=	-lcriterion

COVERAGE	=	$(SRC:.c=.gcda)	\
				$(SRC:.c=.gcno)	\
				$(MAIN_SRC:.c=.gcda)	\
				$(MAIN_SRC:.c=.gcno)	\
				$(TEST_SRC:.c=.gcno)	\
				$(TEST_SRC:.c=.gcda)	\

TARGET	=	your_target

TARGET_TEST	=	unit_tests

#-------------------------------------------------------------------------------

all:	$(TARGET) ## Build the main binary with libs

$(TARGET) : build_lib build

build_lib: ## Compile the libs
	$(MAKE) -C ./lib/libmy/ --silent
	cp ./lib/libmy/libmy.a ./lib/libmy.a
	cp ./lib/libmy/include/my.h ./include/my.h

build: $(OBJ) $(MAIN_OBJ) ## Build the main binary
	$(CC) $(OBJ) $(MAIN_OBJ) -o $(TARGET) $(LFLAGS)

clean_lib: ## Clean the libs
	$(MAKE) -C ./lib/libmy/ --silent clean

fclean_lib: ## Force clean the libs
	$(MAKE) -C ./lib/libmy/ --silent fclean
	rm -f lib/libmy.a

clean: clean_lib ## Clean the project
	rm -f $(OBJ) $(MAIN_OBJ) $(TEST_OBJ)
	rm -f $(COVERAGE)

fclean: fclean_lib clean ## Force clean the project
	rm -f $(TARGET) $(TARGET_TEST)

re:	fclean all ## Force clean then compile

tests_run: CFLAGS += --coverage ## Launch tests
tests_run: build_lib $(OBJ) $(TEST_OBJ)
	$(CC) $(CFLAGS) $(OBJ) $(TEST_OBJ) -o $(TARGET_TEST) $(LFLAGS) $(TEST_LFLAGS)
	./$(TARGET_TEST)
	gcovr --exclude tests/

re_tests: fclean tests_run ## Force clean then launch tests

valgrind: all ## Launch valgrind
	valgrind --leak-check=full ./$(TARGET)

help: ## Help for the Makefile
	@cat $(MAKEFILE_LIST) | sed -En 's/^([a-zA-Z_-]+)\s*:.*##\s?(.*)/\1 "\2"/p' | xargs printf "\033[36m%-30s\033[0m %s\n"

.PHONY:	re fclean clean fclean_lib clean_lib build build_lib all tests_run re_tests help valgrind