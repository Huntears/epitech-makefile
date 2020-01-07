##
## EPITECH PROJECT, 2020
## Project name
## File description:
## Makefile
##

SRC     =       src/source.c  \

TEST_SRC        =       tests/test_source.c \

OBJ     =       $(SRC:.c=.o)

MAIN_SRC        =       src/main.c       \

MAIN_OBJ        =       $(MAIN_SRC:.c=.o)

TEST_OBJ        =       $(TEST_SRC:.c=.o)

$(COVERAGE)		=		$(SRC:.c=.gcda)	\
						

CFLAGS  =       -I./include -Wall -Wextra -Werror

TEST_CFLAGS     =       -lcriterion

TARGET  =       target

TARGET_TEST     =       unit_tests

all:    $(TARGET)

$(TARGET): $(OBJ) $(MAIN_OBJ)
        $(CC) $(CFLAGS) $(OBJ) $(MAIN_OBJ) -o $(TARGET) $(LIB_FLAGS)

clean:
        rm -f $(OBJ) $(TEST_OBJ) $(MAIN_OBJ) *.gcda *.gcno

tests_run: CFLAGS += --coverage
tests_run: $(OBJ) $(TEST_OBJ)
        $(CC) $(CFLAGS) $(TEST_CFLAGS) $(OBJ) $(TEST_OBJ) -o $(TARGET_TEST)
        ./$(TARGET_TEST)

fclean: clean
        rm -f $(TARGET) $(TARGET_TEST)

re:     fclean all

re_tests: re tests_run

.PHONY:	re_tests re fclean tests_run add_coverage clean all