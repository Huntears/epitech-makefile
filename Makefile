##
## EPITECH PROJECT, 2019
## my_runner
## File description:
## The Makefile for my_runner
##

SRC 	=	src/runner/my_runner.c	\
			src/runner/init/init_window.c 	\
			src/runner/handle_events.c 	\
			src/runner/physics/apply_gravity.c	\
			src/runner/handle_key_pressed.c	\
			src/runner/init/init_game_objects.c 	\
			src/runner/init/init_player.c	\
			src/runner/init/init_parralax.c	\
			src/runner/destroy/destroy_game_objects.c 	\
			src/runner/destroy/destroy_player.c 	\
			src/runner/destroy/destroy_parralax.c 	\
			src/runner/display/display_objects.c	\
			src/runner/display/display_player.c	\
			src/runner/display/display_parralax.c	\
			src/runner/physics/is_sprite_colliding.c	\
			src/runner/init/init_map.c	\
			src/runner/display/display_map.c	\
			src/runner/utility/get_next_line.c	\
			src/runner/physics/check_collisions.c	\
			src/runner/destroy/destroy_map.c	\
			src/runner/wait_for_input.c	\
			src/runner/helper.c	\
			src/runner/is_won.c	\
			src/runner/sound/sound_jump.c	\
			src/runner/init/init_sound.c	\
			src/runner/destroy/destroy_sound.c	\
			src/runner/init/init_score.c	\
			src/runner/display/display_score.c	\
			src/runner/destroy/destroy_score.c	\
			src/runner/utility/int_to_string.c	\
			src/runner/final_screen.c	\

OBJ 	=	$(SRC:.c=.o)

MAIN_SRC	=	src/main.c 	\

MAIN_OBJ	=	$(MAIN_SRC:.c=.o)

CFLAGS	=	-I./include -Wall -Wextra -Werror

LFLAGS	=	-L./lib -lcorn -lmy -lcsfml-graphics -lcsfml-system -lcsfml-window -lcsfml-audio

COVERAGE	=	$(SRC:.c=.gcda)	\
				$(SRC:.c=.gcno)	\
				$(MAIN_SRC:.c=.gcno)	\
				$(MAIN_SRC:.c=.gcno)	\

TARGET	=	my_runner

all:	$(TARGET)

$(TARGET): build_lib build

build_lib:
	@cd ./lib/libcorn/ && $(MAKE) --silent
	@cd ./lib/libmy/ && $(MAKE) --silent
	@cp ./lib/libcorn/libcorn.a ./lib/libcorn.a
	@cp ./lib/libmy/libmy.a ./lib/libmy.a
	@cp ./lib/libcorn/include/corn.h ./include/corn.h
	@cp ./lib/libmy/include/my.h ./include/my.h

%.o : %.c
	@$(CC) $(CFLAGS) -c $< -o $@
	@printf "[\e[1;34mCompiled\e[0m] % 41s\n" $@ | tr ' ' '.'

build: $(OBJ) $(MAIN_OBJ)
	@printf "\e[1;32mFinished compiling sources\e[0m\n"
	@$(CC) $(OBJ) $(MAIN_OBJ) -o $(TARGET) $(LFLAGS)
	@printf "[\e[1;33mLinked\e[0m] % 43s\n" $(OBJ) | tr ' ' '.'
	@printf "[\e[1;33mLinked\e[0m] % 43s\n" $(MAIN_OBJ) | tr ' ' '.'
	@printf "\e[1;32mLinked all object files\e[0m\n"

clean_lib:
	@cd lib/libcorn/ && $(MAKE) --silent clean
	@cd lib/libmy/ && $(MAKE) --silent clean

fclean_lib:
	@cd lib/libcorn/ && $(MAKE) --silent fclean
	@cd lib/libmy/ && $(MAKE) --silent fclean

clean: clean_lib
	@rm -f $(OBJ) $(MAIN_OBJ) $(COVERAGE)
	@printf "[\e[1;31mRemoved\e[0m] % 42s\n" $(OBJ) | tr ' ' '.'
	@printf "\e[1;32mFinished removing objects\e[0m\n"

fclean: fclean_lib clean
	@rm -f $(TARGET)
	@printf "[\e[1;31mRemoved\e[0m] % 42s\n" $(TARGET) | tr ' ' '.'
	@printf "\e[1;32mFinished removing linked binaries\e[0m\n"

re:	fclean all

valgrind: all
	@valgrind --suppressions=valgrind.supp --leak-check=full --show-leak-kinds=all ./my_runner a

.PHONY:	re fclean clean fclean_lib clean_lib build build_lib all