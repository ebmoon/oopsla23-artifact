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

function method Push(st:Stack, v:int): (stout: Stack)
  ensures StackLen(stout) == StackLen(st) + 1
{
  match st
  case SList(l) => SList(Cons(v, l))
}

method Pop(st:Stack) returns (stout: Stack, v:int)
  requires !isEmptyStack(st)
  ensures StackLen(st) == StackLen(stout) + 1
{
  match st
  case SList(l) => 
    match l {
      case Nil => stout := SList(Nil); v := 0;
      case Cons(hd, tl) => stout := SList(tl); v := hd;
    }
}

method push_pop(st1: Stack, x1: int, st2: Stack) returns (stout1: Stack, stout2:Stack, x2: int)
  requires !isEmptyStack(st2)
  ensures stout1 == st2 ==> x1 == x2
  ensures stout1 == st2 ==> st1 == stout2
  ensures stout2 == st1 && x1 == x2 ==> stout1 == st2
{
  stout1 := Push(st1, x1);
  stout2, x2 := Pop(st2);
}