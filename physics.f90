module physics

  implicit none

contains

  ! Subroutine to determine the flux in the cell
  subroutine get_f(nu,u,f)
    integer :: nu
    real :: u(nu), f(nu)

  end subroutine get_f

  ! Determine the velocity (convert from conserved to v)
  subroutine get_v(nu, v, u)
    integer :: nu
    real :: v
    real :: u(nu)

  end subroutine get_v

  ! Determine the sound speed in the cell adjacent
  subroutine get_cs(nu, cs, u)
    integer :: nu
    real :: cs
    real :: u(nu)

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

end module physics
