program main
  use grid, only: set_grid, set_dt
  use init, only: set_init
  implicit none

  ! Instantiate the x and size
  real, allocatable :: x(:)
  integer :: nx
  real :: dx

  ! Set up iteration parameters and time and step data
  real :: dt, dtnew
  real :: t = 0.
  real :: tmax = 2.0
  integer :: istep = 0

  ! Set courant factor
  ! TODO put in setup
  real :: cou = 0.5

  ! Instantiate the u array and size
  real, allocatable :: u(:,:)
  integer :: nu

  call set_grid(x, dx, nx)
  call set_init(u, x, nx, nu)

  call set_dt(dt, dx, u, cou, nx, nu)

  !call write_output(istep,nx ,x, u, t, nu)

  print*,dt


end program main
