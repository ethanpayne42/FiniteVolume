module physics

  implicit none

contains

  ! Subroutine to determine the flux in the cell
  subroutine get_f(nu,u,f)
    integer :: nu
    real :: u(nu), f(nu), p(nu)
    real :: g = 5./3. ! TODO setup file
    real :: pr

    call cons2prims_single(u,p,nu)

    pr = (g-1)*p(1)*p(3) ! The pressure

    f(1) = p(1)*p(2)
    f(2) = p(1)*p(2)**2 + pr
    f(3) = (0.5*p(1)*p(2)**2 + pr + p(1)*p(3))*p(2)
  end subroutine get_f

  ! Determine the sound speed in the cell adjacent
  subroutine get_cs(nu, cs, u)
    integer :: nu
    real :: cs, g
    real :: u(nu), p(nu)

    ! TODO set gamma in setup file
    g = 5./3.

    call cons2prims_single(u, p, nu)

    cs = abs(g*(g-1)*p(3)) ! cs = gamma*P/rho, P=(g-1)rho*e
  end subroutine get_cs

  ! ======= CONVERSIONS BETWEEN CONSERVED & PRIMITIVES =========

  ! Determine the conserved quantities given the primitives
  subroutine prims2cons(u, p, nu, nx)
    integer :: nu, nx
    real, intent(in) :: p(nu,0:nx)
    real, intent(out) :: u(nu,0:nx)

    ! Conversion functions to the conserved quantities in u
    u(1,:) = p(1,:)
    u(2,:) = p(1,:)*p(2,:)
    u(3,:) = 0.5*p(1,:)*(p(2,:))**2 + p(1,:)*p(3,:)
  end subroutine prims2cons

  ! Determine the primitive quantities due to the conserved
  subroutine cons2prims(u, p, nu, nx)
    integer :: nu, nx
    real, intent(out) :: p(nu,0:nx)
    real, intent(in) :: u(nu,0:nx)

    ! Functions for conversion back to primitive quantities
    p(1,:) = u(1,:)
    p(2,:) = u(2,:)/u(1,:)
    p(3,:) = (1./u(1,:))*(u(3,:) - 0.5*(u(2,:))**2/u(1,:))

  end subroutine cons2prims

  ! Determine the primitive quantities due to the conserved
  subroutine cons2prims_single(u, p, nu)
    integer :: nu
    real, intent(out) :: p(nu)
    real, intent(in) :: u(nu)

    ! Functions for conversion back to primitive quantities
    p(1) = u(1)
    p(2) = u(2)/u(1)
    p(3) = (1./u(1))*(u(3) - 0.5*(u(2))**2/u(1))

  end subroutine cons2prims_single

end module physics
