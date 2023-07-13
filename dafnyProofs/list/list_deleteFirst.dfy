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

function DeleteFirst(l:List, v:int): (lout: List)
  ensures l == lout || Len(l) == Len(lout) + 1
  ensures Exists_eq(l, v) || l == lout
  ensures Forall_neq(l, v) || Len(l) == Len(lout) + 1
  ensures Forall_le(l, v) || Exists_gt(lout, v)
  ensures Forall_ge(l, v) || Exists_lt(lout, v)
  ensures Exists_gt(l, v) || Forall_le(lout, v)
  ensures Exists_lt(l, v) || Forall_ge(lout, v)  
  ensures Exists_lt(l, v) || Len(l) == Len(lout) + 1 || Forall_neq(lout, v)
{
  match l
  case Nil => Nil
  case Cons(hd, tl) =>
    if (hd == v) then tl else Cons(hd, DeleteFirst(tl, v))
}
