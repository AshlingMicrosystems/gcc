! { dg-do compile }
! Checks the fix for PR33542, in which the ambiguity in the specific
! interfaces of foo was missed.
!
! Contributed by Tobias Burnus <burnus@gcc.gnu.org>
!
MODULE M1
   INTERFACE FOO
     MODULE PROCEDURE FOO2
   END INTERFACE
CONTAINS
   SUBROUTINE FOO2(I)
     INTEGER, INTENT(IN) :: I
     WRITE(*,*) 'INTEGER'
   END SUBROUTINE FOO2
END MODULE M1

MODULE M2
   INTERFACE FOO
     MODULE PROCEDURE FOO2
   END INTERFACE
CONTAINS
   SUBROUTINE FOO2(R)
     REAL, INTENT(IN) :: R
     WRITE(*,*) 'REAL'
   END SUBROUTINE FOO2
END MODULE M2

PROGRAM P
   USE M1  ! { dg-error "Ambiguous interfaces" }
   USE M2
   implicit none
   external bar
   CALL FOO(10)
   CALL FOO(10.)
END PROGRAM P
! { dg-final { cleanup-modules "m1 m2" } }
