program main
  use grid, only: set_grid
  use init, only: set_init
  implicit none

  ! Instantiate the x and size
  real, allocatable :: x(:)
  integer :: nx
  real :: dx

  ! Instantiate the u array and size
  real, allocatable :: u(:,:)
  integer :: nu

  call set_grid(x, dx, nx)
  call set_init(u, x, nx, nu)



end program main
