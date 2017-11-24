program main
    implicit none
    integer :: i
    character(len = 16) :: arg
    interface
        function fib(n)
            integer, intent(in) :: n
            integer :: fib
        end function fib
    end interface

    call get_command_argument(1, arg)
    read(arg, *) i
    !print *, fib(i)
    print '(i0)', fib(i)
end program main

recursive function fib (n) result (fnum)
    integer, intent(in) :: n
    integer :: fnum
    if (n < 2) then
        fnum = n
    else
        fnum = fib(n - 2) + fib(n - 1)
    endif
end function fib
