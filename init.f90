module init
  use constants, only: pi
  use physics, only: prims2cons
  implicit none

contains

  subroutine set_init(u, x, nx, nu)
    integer :: nu, nx
    real :: A, g
    real, allocatable :: u(:,:)
    real :: x(0:nx)
    real, allocatable :: p(:,:)

    ! TODO put in setup file
    nu = 3
    A = 1.e-1
    g = 5./3.

    allocate(u(nu,0:nx))
    allocate(p(nu,0:nx))

    ! TODO choice or setup file?
    p(1,:) = 1 + A*sin(2*pi*x) ! Density initial condition (IC)
    p(2,:) = A*sin(2*pi*x) ! velocity IC
    p(3,:) = 1./(g*(g-1)) +g*A*sin(2*pi*x) ! energy IC

    ! Converts the primitive array of p = (rho, velocity, eps)
    ! to the conserved quantities
    call prims2cons(u, p, nu, nx)

  end subroutine set_init

end module init
