module init
  use constants, only: pi
  use physics, only: prims2cons
  implicit none

contains

  subroutine set_init(u, up, x, nx, nu, choice)
    integer :: nu, nx, j, choice
    real :: A, g
    real, allocatable :: u(:,:), up(:,:)
    real :: x(0:nx), vec(2)
    real, allocatable :: p(:,:)

    ! open setup file to retrieve nu and A
    open(1,file='config.txt')
    read(1,*), nu, A

    print*,vec
    g = 5./3.

    allocate(u(nu,0:nx))
    allocate(up(nu,0:nx))
    allocate(p(nu,0:nx))

    ! Wave initial conditions
    select case (choice)
      case(1)
        p(1,:) = 1 + A*sin(2*pi*x) ! Density initial condition (IC)
        p(2,:) = A*sin(2*pi*x) ! velocity IC
        p(3,:) = 1./(g*(g-1)) +A/g*sin(2*pi*x) ! energy IC

      ! Sod shock initial conditions
      case(2)
        do j=0,nx
          if ( x(j)<0.5 .and. x(j)>-0.5) then
            p(:,j) = [1.,0.,1./(g-1)]
          else
            p(:,j) = [0.125, 0.0, 0.1/(0.125*(g-1))]
          end if
        end do
    end select

    ! Converts the primitive array of p = (rho, velocity, eps)
    ! to the conserved quantities
    call prims2cons(u, p, nu, nx)

  end subroutine set_init

end module init
