module grid
  use physics, only: cons2prims, get_cs
  implicit none

contains

  ! Creates the grid of the x coordinates
  subroutine set_grid(x, dx, nx, choice)
    real, allocatable :: x(:)
    real :: dx, lx
    integer :: nx, i, choice

    ! Set up spacing parameters
    select case (choice)
      case(1)
        nx = 100
        lx = 1.
      case(2)
        nx = 1000
        lx = 2.0
    end select
    dx = lx/(nx+1)

    allocate(x(0:nx))

    ! Create the array of x values for the grid of evaluation
    select case (choice)
      case(1)
        x = (/(i*dx, i=0,nx)/)
      case(2)
        x = (/(i*dx, i=0,nx)/)
        x = x - lx/2
    end select

  end subroutine set_grid

  ! Subroutine for the calculation of the timestep
  subroutine set_dt(dt, dx, u, cou, nx, nu)
    integer :: nx, nu, j
    real :: dt, dx, cou
    real :: u(nu,0:nx), p(nu,0:nx)
    real :: cs
    real :: lambda = 0.
    real :: lambda_j
    real :: max_v = 0.

    call cons2prims(u, p, nu, nx)

    ! Loop over every value of u and get the speed for it
    ! Then compute the eigenvalue, and if it is larger
    ! than the previous larger value, make it the new one
    do j = 0,nx
        call get_cs(nu, cs, u(:,j))
        lambda_j = abs(p(2,j)) + abs(cs) !TODO put eigenstuff together
        if (lambda_j > lambda ) then
          lambda = lambda_j
        end if
        if (abs(p(2,j)) > max_v) then
          max_v = abs(p(2,j))
        end if
    end do

    dt = cou*dx/lambda
  end subroutine set_dt


end module grid
