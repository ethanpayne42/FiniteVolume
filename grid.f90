module grid
  use physics, only: cons2prims, get_cs
  implicit none

contains

  ! Creates the grid of the x coordinates
  subroutine set_grid(x, dx, nx)
    real, allocatable :: x(:)
    real :: dx, lx
    integer :: nx, i

    ! TODO dont have to change here, set config file?
    ! Set up spacing parameters
    nx = 100
    lx = 1.
    dx = 1./(nx+1)

    allocate(x(0:nx))

    ! Create the array of x values for the grid of evaluation
    x = (/(i*dx, i=0,nx)/)
  end subroutine set_grid

  ! Subroutine for the calculation of the timestep
  subroutine set_dt(dt, dx, u, cou, nx, nu)
    integer :: nx, nu, j
    real :: dt, dx, cou
    real :: u(nu,0:nx), p(nu,0:nx)
    real :: cs
    real :: lambda = 0.
    real :: lambda_j

    call cons2prims(u, p, nu, nx)

    ! Loop over every value of u and get the speed for it
    ! Then compute the eigenvalue, and if it is larger
    ! than the previous larger value, make it the new one
    do j = 0,nx
        call get_cs(nu, cs, u(:,j))
        lambda_j = abs(p(2,j)) + cs
        if (lambda_j > lambda ) then
          lambda = lambda_j
        end if
    end do

    dt = cou*dx/lambda
  end subroutine set_dt


end module grid
