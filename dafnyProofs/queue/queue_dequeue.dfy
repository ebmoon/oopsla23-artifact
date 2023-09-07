datatype List = Nil | Cons(int, List)

datatype Queue = QList(inList: List, outList: List)

function ListLen(l:List): (v: int)
  ensures v >= 0
{
  match l
  case Nil => 0
  case Cons(hd, tl) => ListLen(tl) + 1
}

function isEmptyList(l:List): bool
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
  case Cons(hd, tl) => hd < x || Exists_lt(tl, x)
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

function Snoc(l:List, x:int): (lout: List)
  ensures ListLen(lout) == ListLen(l) + 1
  ensures Exists_eq(lout, x)
  ensures Forall_ge(l, x) || Exists_lt(lout, x)
  ensures Forall_le(l, x) || Exists_gt(lout, x)
  ensures Exists_gt(l, x) || Forall_le(lout, x)
  ensures Exists_lt(l, x) || Forall_ge(lout, x)
{
  match l
  case Nil => Cons(x, Nil)
  case Cons(hd, tl) => Cons(hd, Snoc(tl, x))
}


function Reverse(l:List): (lout:List)
  ensures ListLen(l) == ListLen(lout)
  ensures ListLen(l) > 1 || l == lout
{
  match l
  case Nil => Nil
  case Cons(hd, tl) => Snoc(Reverse(tl), hd)
}

function Append(l1:List, l2:List): (lout: List)
  ensures ListLen(l1) + ListLen(l2) == ListLen(lout)
  ensures ListLen(lout) >= ListLen(l2) + 1 || l2 == lout
  ensures isEmptyList(l2) ==> l1 == lout
{
  match l1
  case Nil => l2
  case Cons(hd, tl) => Cons(hd, Append(tl, l2))
}

function Valid(q:Queue): (b: bool)
{
  match q
  case QList(inList, outList) => 
    isEmptyList(outList) ==> isEmptyList(inList)
}

function QueueLen(q:Queue): int
{
  match q
  case QList(inList, outList) => 
    ListLen(inList) + ListLen(outList)
}

function toList(q:Queue): (l:List)
{
  match q
  case QList(inList, outList) => 
    Append(outList, Reverse(inList))
}

method Dequeue(q:Queue) returns (qout:Queue, v:int)
  requires Valid(q)
  requires QueueLen(q) > 0
  ensures Valid(qout)
  ensures toList(q) == Cons(v, toList(qout))
{
  match q
  case QList(inList, outList) => match outList {
    case Nil =>
      qout := QList(Nil, Nil);
      v := 0;
    case Cons(hd, tl) => 
      if tl == Nil {
        qout := QList(Nil, Reverse(inList));
        v := hd;
      } else {
        qout := QList(inList, tl);
        v := hd;
      }
  }
}
