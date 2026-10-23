module armstrong_numbers
    implicit none

contains

    logical function isArmstrongNumber(i)
        integer, intent(in) :: i
        integer :: number, digit, count, total

        number = i
        count = len_trim(toString(i))
        total = 0

        do while (number > 0)
            digit = mod(number, 10)
            total = total + digit ** count
            number = number / 10
        end do

 
        isArmstrongNumber = (total == i)

    end function isArmstrongNumber

    function toString(number) result(str)
        integer, intent(in) :: number
        character(len=20) :: str

        write(str, '(I0)') number
    end function toString

end module armstrong_numbers