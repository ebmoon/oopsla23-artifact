datatype List = Nil | Cons(int, List)

datatype Stack = SList(list: List)

function ListLen(l:List): int
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

function StackLen(st:Stack): int
{
  match st
  case SList(l) => ListLen(l)
}

function isEmptyStack(st:Stack): bool
{
  match st
  case SList(l) => isEmptyList(l)
}

function Push(st:Stack, v:int): (stout: Stack)
  ensures StackLen(stout) == StackLen(st) + 1
{
  match st
  case SList(l) => SList(Cons(v, l))
}

function Pop(st:Stack) : (out: (Stack, int))
  requires !isEmptyStack(st)
  ensures StackLen(st) == StackLen(out.0) + 1
{
  match st
  case SList(l) => 
    match l {
      case Nil => (SList(Nil), 0)
      case Cons(hd, tl) => (SList(tl), hd)
    }
}

method push_pop(st1: Stack, x: int, st2: Stack) returns (stout1: Stack, stout2:Stack, xout: int)
  requires !isEmptyStack(st2)
  ensures stout1 == st2 ==> x == xout
  ensures stout1 == st2 ==> st1 == stout2
  ensures stout2 == st1 && x == xout ==> stout1 == st2
{
  stout1 := Push(st1, x);
  match Pop(st2)
    case (st, v) => stout2 := st; xout := v;
}