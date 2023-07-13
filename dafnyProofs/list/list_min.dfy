datatype List = Nil | Cons(int, List)

function Len(l:List): (v:int)
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

function Exists_eq(l:List, x:int): bool
{
  match l
  case Nil => false
  case Cons(hd, tl) => hd == x || Exists_eq(tl, x)
}

function Forall_ge(l:List, x:int): bool
{
  match l
  case Nil => true
  case Cons(hd, tl) => hd >= x || Forall_ge(tl, x)
}

function Min(l:List): (v: int)
  requires !isEmpty(l)
  ensures Exists_eq(l, v)
  ensures Forall_ge(l, v)
{
  match l
  case Nil => 0
  case Cons(hd, tl) => (
    match tl
    case Nil => hd
    case Cons(_, _) => 
      if Min(tl) < hd then Min(tl) else hd
  )
}
