TARGET:		d2read i2read

OBJS =		main.o savegame.o item.o
OBJS2 =		i2read.o savegame.o item.o
LIBS =
CFLAGS +=	-ansi -pedantic -Wall
CFLAGS +=	-g
CC =		c++

d2read:		$(OBJS)
		$(CC) $(CFLAGS) -o d2read $(OBJS) $(LIBS)

i2read:		$(OBJS2)
		$(CC) $(CFLAGS) -o i2read $(OBJS2) $(LIBS)

.cc.o:
		$(CC) -c $(CFLAGS) -o $@ $<

clean:
		rm -f d2read i2read $(OBJS) $(OBJS2)
