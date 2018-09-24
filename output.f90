module output
  use physics, only: cons2prims
  implicit none
  real :: g = 5./3
contains

! A subroutine to write output to a file
subroutine write_output(istep,nu, nx, x, u, time)
  integer, intent(in) :: istep, nx, nu
  real, intent(in) :: x(0:nx), u(nu,0:nx), time
  character(len=40) :: filename
  real :: p(nu,0:nx)
  integer :: iunit,i

  call cons2prims(u, p, nu, nx)

  write(filename,"(a,i5.5,a)") 'data/output_',istep,'.dat' !TODO This is a bit scrappy
  print*,'writing to file ',trim(filename),' at time ',time
  open(newunit=iunit,file=filename,status='replace')
  write(iunit,*),time
  do i=1,nx
    write(iunit,*) x(i),p(:,i), (g-1)*p(1,i)*p(3,i), g*(g-1)*p(3,i)
  enddo
  close(iunit)
end subroutine write_output
end module output
