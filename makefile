FC=gfortran
FFLAGS=-O3 -Wall -Wextra -fdefault-real-8 -fcheck=all

SRC= constants.f90 physics.f90 \
flux.f90 grid.f90 init.f90 main.f90

OBJ=${SRC:.f90=.o}

%.o: %.f90
	$(FC) $(FFLAGS) -o $@ -c $<

fdefault:euler data

data:
	mkdir $@

euler: $(OBJ)
	$(FC) $(FFLAGS) -o $@ $(OBJ)

clean: $(OBJ)
	rm *.o *.mod euler
