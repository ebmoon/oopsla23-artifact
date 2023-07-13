datatype List = Nil | Cons(int, List)

function Len(l:List): (v:int)
{
  match l
  case Nil => 0
  case Cons(hd, tl) => Len(tl) + 1
}

function Exists_eq(l:List, x:int): bool
{
  match l
  case Nil => false
  case Cons(hd, tl) => hd == x || Exists_eq(tl, x)
}

function Ith(l:List, idx:int): (v: int)
  requires idx < Len(l)
  requires 0 < idx + 1
  requires Len(l) == idx + 1 || Len(l) > 1
  ensures Exists_eq(l, v)
{
  match l
  case Nil => 0
  case Cons(hd, tl) => if idx == 0 then hd else Ith(tl, idx - 1)
}
