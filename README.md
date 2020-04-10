# Generic Makefile for Epitech

## Basic commands

This section will use the ```help``` rule of this Makefile to list all the
available rules and their purpose.

```
all                            Build the main binary with libs
build_lib                      Compile the libs
build                          Build the main binary
clean_lib                      Clean the libs
fclean_lib                     Force clean the libs
clean                          Clean the project
fclean                         Force clean the project
re                             Force clean then compile
tests_run                      Launch tests
re_tests                       Force clean then launch tests
valgrind                       Launch valgrind
help                           Help for the Makefile
```

## Variables

### SHELL

The shell used for the compilation, is usefull for some people who uses some
weird shells like [fishshell](https://fishshell.com/ "Fishshell Website") which
treats the pipes differently

Default : ```bash```

### SRC

Contains all the path to your source files (.c)

Default : ```src/your-source.c	\```

### OBJ

Contains all the path to your object files (.o), **you do not need to touch that**

Default : ```$(SRC:.c=.o)```

### MAIN_SRC

Contains the path to your source file containing the main function. **This file
cannot be tested by Criterion!**

Default : ```src/main.c 	\```

### MAIN_OBJ

Contains the path to your object file containing the main function, **you do not
need to touch that**

Default : ```$(MAIN_SRC:.c=.o)```

### TEST_SRC

Contains all the path to your test source files (.c)

Default : ```tests/test_your_test.c	\```

### TEST_OBJ

Contains all the path to your test object files (.o), **you do not need to touch that**

Default : ```$(TEST_SRC:.c=.o)```

### CFLAGS

Contains all the flags for the compilation **(not the linking!)**

Default : ```-I./include -Wall -Wextra -pedantic```

### LFLAGS

Contains all the flags for the linking **(not the compilation!)**

Default : ```-L./lib -lmy```

### TEST_LFLAGS

Contains all the flags for the tests linking **(not the compilation!)**

Default : ```-lcriterion```

### Coverage

Contains all the path to the coverage files, **you do not need to touch this!**

Default :
```
$(SRC:.c=.gcda)	\
$(SRC:.c=.gcno)	\
$(MAIN_SRC:.c=.gcda)	\
$(MAIN_SRC:.c=.gcno)	\
$(TEST_SRC:.c=.gcno)	\
$(TEST_SRC:.c=.gcda)	\
```

### TARGET

Contains the name of the final binary

Default : ```your_target```

### TARGET_TEST

Contains the name of the test binary

Default : ```unit_tests```

## Notes

### General

The Makefile does not recompile when not needed and offers a nice
interface/output that you can use to compile all your project for Epitech

### For Epitech students

You should not normally take a -42 for using this Makefile as is (if it was
the case there would be a lot of problems). But take the time to read it, and
most importantly understand it. If you understand it you could make your own
version of your Makefile, and then be proud of it :).