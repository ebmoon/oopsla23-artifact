datatype List = Nil | Cons(int, List)

function Len(l:List): (v: int)
  ensures v >= 0
{
  match l
  case Nil => 0
  case Cons(hd, tl) => Len(tl) + 1
}

function isEmpty(l:List): (b: bool)
  ensures b || Len(l) > 0
  ensures !b || Len(l) == 0
{
    match l
    case Nil => true
    case Cons(hd, tl) => false
}

function Take(l:List, n:int): (lout: List)
  requires 0 <= n <= Len(l)
  ensures n == Len(lout)
  ensures n == Len(l) || Len(l) >= Len(lout) + 1
  ensures l == lout || Len(l) == n + 1 || Len(l) > Len(lout) + 1
{
  if n > 0 then (
    match l
    case Nil => Nil
    case Cons(hd, tl) => Cons(hd, Take(tl, n-1))
  ) else Nil
}
