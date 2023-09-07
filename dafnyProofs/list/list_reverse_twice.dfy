datatype List = Nil | Cons(int, List)

function Len(l:List): int
  ensures Len(l) >= 0
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

function Exists_lt(l:List, x:int): bool
{
  match l
  case Nil => false
  case Cons(hd, tl) => hd > x || Exists_lt(tl, x)
}

function Exists_gt(l:List, x:int): bool
{
  match l
  case Nil => false
  case Cons(hd, tl) => hd > x || Exists_gt(tl, x)
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

method Snoc(l:List, x:int) returns (lout: List)
  ensures Len(lout) == Len(l) + 1
  ensures Exists_eq(lout, x)
  ensures Exists_lt(l, x) ==> Exists_lt(lout, x)
  ensures Exists_gt(l, x) ==> Exists_gt(lout, x)
  ensures Forall_le(l, x) ==> Forall_le(lout, x)
  ensures Forall_ge(l, x) ==> Forall_ge(lout, x)
{
  match l
  case Nil => lout := Cons(x, Nil);
  case Cons(hd, tl) => 
    lout := Snoc(tl, x);
    lout := Cons(hd, lout);
}

method Reverse(l:List) returns (lout: List)
  ensures Len(l) == Len(lout)
  ensures Len(l) >= 1 || l == lout
{
  match l
  case Nil => lout := Nil;
  case Cons(hd, tl) => 
    lout := Reverse(tl);
    lout := Snoc(lout, hd);
}

method Reverse_twice(l1:List, l2:List) returns (lout1:List, lout2:List)
  ensures l2 == lout1 ==> l1 == lout2
  ensures l1 == lout2 ==> l2 == lout1
  ensures lout1 == lout2 ==> l1 == l2
  ensures l1 == l2 ==> lout1 == lout2
{
  lout1 := Reverse(l1);
  lout2 := Reverse(l2);
}