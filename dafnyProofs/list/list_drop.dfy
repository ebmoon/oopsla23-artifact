datatype List = Nil | Cons(int, List)

function Len(l:List): int
{
  match l
  case Nil => 0
  case Cons(hd, tl) => Len(tl) + 1
}

function isEmpty(l:List): bool
{
    match l
    case Nil => true
    case Cons(hd, tl) => false
}

function Drop(l:List, n:int): (lout: List)
  requires Len(l) >= n >= 0
  ensures Len(l) == Len(lout) + n
  ensures Len(lout) == n + Len(l) || n > 1 || Len(l) == Len(lout) + 1
  ensures l == lout || n == 1 || Len(l) > Len(lout) + 1
{
  match l
  case Nil => Nil
  case Cons(hd, tl) => 
    if n > 0 then Drop(tl, n-1) else l 
}
