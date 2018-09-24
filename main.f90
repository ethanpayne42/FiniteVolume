program main
  use grid, only: set_grid, set_dt
  use init, only: set_init
  use output, only: write_output
  use step, only: step_one
  implicit none

  ! Instantiate the x and size
  real, allocatable :: x(:)
  integer :: nx, choice
  real :: dx

  ! Set up iteration parameters and time and step data
  real :: dt
  real :: t = 0.
  real :: tmax = 0.
  integer :: istep = 0

  ! Set courant factor
  ! TODO put in setup
  real :: cou = 0.5

  ! Instantiate the u array and size
  real, allocatable :: u(:,:), up(:,:)
  integer :: nu

  print*,'Select the problem to be solved:'
  print*,'Density wave to shock    (1)'
  print*,'Sod shock tube           (2)'
  read*,choice

  select case (choice)
    case(1)
      tmax = 2.
    case(2)
      tmax = 0.2
  end select

  call set_grid(x, dx, nx, choice)
  call set_init(u, up, x, nx, nu, choice)

  call set_dt(dt, dx, u, cou, nx, nu)

  ! Write the output of the initial conditions
  call write_output(istep, nu, nx ,x, u, t)

  ! Loop over the scheme
  do while(t < tmax)
    t = t+dt
    istep = istep +1
    call step_one(u, up, dx, dt, nx, nu)
    call write_output(istep, nu, nx ,x, u, t)
    call set_dt(dt, dx, u, cou, nx, nu)
  end do

end program main
