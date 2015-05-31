# Makefile for the GSL examples comign from the manual
CC=gcc
FLAGS=-Wall -g
INCDIRS=/usr/local/include
LIBDIRS=/usr/local/lib
LIBSYMBS=-lgsl -latlas -lcblas -lm
LIBSYMBS1=-lgsl -lgoto2 -lgfortran -lm
LIBSYMBS2=-lgsl -lgslcblas -lm
LIBSIMP=-lgsl -lm # you may be thinking this will work. But most often it will not.
EXES= allperms rnperm matv vecv2 comb1 comb2 p0 p1 p2 ms1 ms2 qrex p0a spli_1

allperms: allperms.c
	$(CC) $(FLAGS) -o $@ $^ -I$(INCDIRS) -L$(LIBDIRS) $(LIBSYMBS)

rnperm: rnperm.c
	# $(CC) $(FLAGS) -o $@ $^ -I$(INCDIRS) -L$(LIBDIRS) $(LIBSYMBS)
	$(CC) $(FLAGS) -o $@ $^ $(LIBSYMBS2)

# spli_1, spline demonstration, takes 10 points and generate some 1000 pts from the derived spline.
# feed output to text file and then "graph -T ps <in >out" (i.e. plotutils program)
# to see its graph 
spli_1: spli_1.c
	$(CC) $(FLAGS) -o $@ $^ $(LIBSYMBS2)

# Used to be called vecv.c, but it's really about matrix views, so changed.
matv: matv.c
	$(CC) -o $@ $^ -I$(INCDIRS) -L$(LIBDIRS) $(LIBSYMBS1)

vecv2: vecv2.c
	$(CC) $(FLAGS) -o $@ $^ -I$(INCDIRS) -L$(LIBDIRS) $(LIBSYMBS)

# Following prog takes an integer argument and lists all its subsets. All the possible combinations of each subset
# are given. But the man full set: only the orginal is given
comb1: comb1.c
	$(CC) $(FLAGS) -o $@ $^ -I$(INCDIRS) -L$(LIBDIRS) $(LIBSYMBS)

comb2: comb2.c
	$(CC) $(FLAGS) -o $@ $^ -I$(INCDIRS) -L$(LIBDIRS) $(LIBSYMBS)


# Taking up from the comb programs: what about focssing on pairs.
c0: c0.c
	$(CC) $(FLAGS) -o $@ $^ -I$(INCDIRS) -L$(LIBDIRS) $(LIBSYMBS)

# Pair combos: My own way: and it seems to have worked.
oc0: oc0.c
	$(CC) $(FLAGS) -o $@ $^ -I$(INCDIRS) -L$(LIBDIRS) $(LIBSYMBS)

# try and elaborate
# OK, for n=20, there's still only 190 pairs. Small compared to the number of permutations at 20, that is.
# You can store these as  char's because you won't bother going over 255. So a struct of 2 chars could do it.
oc1: oc1.c
	$(CC) $(FLAGS) -o $@ $^ -I$(INCDIRS) -L$(LIBDIRS) $(LIBSYMBS)

# Simple permu
p0: p0.c
	$(CC) $(FLAGS) -o $@ $^ -I$(INCDIRS) -L$(LIBDIRS) $(LIBSYMBS2)

# As is, the gsl permu is quit emonolithic, to pull out the individual symbols you've gotta do this:
p0a: p0a.c
	$(CC) $(FLAGS) -o $@ $^ -I$(INCDIRS) -L$(LIBDIRS) $(LIBSYMBS2)

p1: p1.c
	$(CC) $(FLAGS) -o $@ $^ -I$(INCDIRS) -L$(LIBDIRS) $(LIBSYMBS)

p2: p2.c
	$(CC) $(FLAGS) -o $@ $^ $(LIBSYMBS2)

# multisets is relatively new ... you need gsl-1-14 at least.
ms1: ms1.c
	$(CC) $(FLAGS) -o $@ $^ -I$(INCDIRS) -L$(LIBDIRS) $(LIBSYMBS2)

# Multiset example
ms2: ms2.c
	$(CC) $(FLAGS) -o $@ $^ -I$(INCDIRS) -L$(LIBDIRS) -L${LL} $(LIBSYMBS)

qrex: qrex.c
	$(CC) $(FLAGS) -o $@ $^ -I$(INCDIRS) -L$(LIBDIRS) -L${LL} $(LIBSYMBS)

.PHONY: clean

clean:
	rm -f ${EXES}
