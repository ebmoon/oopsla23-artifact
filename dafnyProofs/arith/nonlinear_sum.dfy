
function sum(x:int): (o:int)
    ensures (x > 1 || 1 == o || 0 == o)
    ensures (-1 * o < -1 * x || 1 == o || x == 0)
    ensures (-1 * o == o || 1 == x || o > 1)
    ensures (2 * o == 0 || -1 * x + 2 * o - x * x == 0)
    ensures (-4 * x + 2 * o - x * x == 0 || 3 * x - 4 * o + x * x <= 0 || -1 * x + 2 * o > 4)
    ensures (3 * x + o > 4 || - 3 * o == 0 || -1 * x + 2 * o - 4 * x * x == -3)
{
    if (x > 0) then x + sum(x-1) else 0
}