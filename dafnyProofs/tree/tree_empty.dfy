datatype Tree = Empty | Branch(int, Tree, Tree)

function Size(t:Tree): int
{
  match t
  case Empty => 0
  case Branch(_, t1, t2) => 1 + Size(t1) + Size(t2)
}

function isEmpty(t:Tree): bool
{
    match t
    case Empty => true
    case Branch(_, _, _) => false
}

function emptyTree(): (tout: Tree)
    ensures isEmpty(tout)
{
    Empty
}
