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

function Exists_eq(l:List, x:int): bool
{
  match l
  case Nil => false
  case Cons(hd, tl) => hd == x || Exists_eq(tl, x)
}

function Exists_neq(l:List, x:int): bool
{
  match l
  case Nil => false
  case Cons(hd, tl) => hd != x || Exists_neq(tl, x)
}

function Exists_lt(l:List, x:int): bool
{
  match l
  case Nil => false
  case Cons(hd, tl) => hd < x || Exists_lt(tl, x)
}

function Exists_gt(l:List, x:int): bool
{
  match l
  case Nil => false
  case Cons(hd, tl) => hd > x || Exists_gt(tl, x)
}

function Forall_eq(l:List, x:int): bool
{
  match l
  case Nil => true
  case Cons(hd, tl) => hd == x || Forall_eq(tl, x)
}

function Forall_neq(l:List, x:int): bool
{
  match l
  case Nil => true
  case Cons(hd, tl) => hd != x || Forall_neq(tl, x)
}

function Forall_le(l:List, x:int): bool
{
  match l
  case Nil => true
  case Cons(hd, tl) => hd <= x || Forall_le(tl, x)
}

function Forall_ge(l:List, x:int): bool
{
  match l
  case Nil => true
  case Cons(hd, tl) => hd >= x || Forall_ge(tl, x)
}

function Snoc(l:List, x:int): (lout: List)
  ensures Len(lout) == Len(l) + 1
  ensures Exists_eq(lout, x)
  ensures Forall_ge(l, x) || Exists_lt(lout, x)
  ensures Forall_le(l, x) || Exists_gt(lout, x)
  ensures Exists_gt(l, x) || Forall_le(lout, x)
  ensures Forall_eq(l, x) || Exists_neq(lout, x)
  ensures Exists_lt(l, x) || Forall_ge(lout, x)
{
  match l
  case Nil => Cons(x, Nil)
  case Cons(hd, tl) => Cons(hd, Snoc(tl, x))
}
