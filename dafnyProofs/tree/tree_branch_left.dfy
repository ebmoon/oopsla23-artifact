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

function Exists_eq(t:Tree, v:int): bool
{
    match t
    case Empty => false
    case Branch(x, t1, t2) => x == v || Exists_eq(t1, v) || Exists_eq(t2, v)
}

function Exists_neq(t:Tree, v:int): bool
{
    match t
    case Empty => false
    case Branch(x, t1, t2) => x != v || Exists_neq(t1, v) || Exists_neq(t2, v)
}

function Exists_lt(t:Tree, v:int): bool
{
    match t
    case Empty => false
    case Branch(x, t1, t2) => x < v || Exists_lt(t1, v) || Exists_lt(t2, v)
}

function Exists_le(t:Tree, v:int): bool
{
    match t
    case Empty => false
    case Branch(x, t1, t2) => x <= v || Exists_le(t1, v) || Exists_le(t2, v)
}

function Exists_gt(t:Tree, v:int): bool
{
    match t
    case Empty => false
    case Branch(x, t1, t2) => x > v || Exists_gt(t1, v) || Exists_gt(t2, v)
}

function Exists_ge(t:Tree, v:int): bool
{
    match t
    case Empty => false
    case Branch(x, t1, t2) => x >= v || Exists_ge(t1, v) || Exists_ge(t2, v)
}

function Forall_eq(t:Tree, v:int): bool
{
    match t
    case Empty => true
    case Branch(x, t1, t2) => x == v && Forall_eq(t1, v) && Forall_eq(t2, v)
}

function Forall_neq(t:Tree, v:int): bool
{
    match t
    case Empty => true
    case Branch(x, t1, t2) => x != v && Forall_neq(t1, v) && Forall_neq(t2, v)
}

function Forall_lt(t:Tree, v:int): bool
{
    match t
    case Empty => true
    case Branch(x, t1, t2) => x < v && Forall_lt(t1, v) && Forall_lt(t2, v)
}

function Forall_le(t:Tree, v:int): bool
{
    match t
    case Empty => true
    case Branch(x, t1, t2) => x <= v && Forall_le(t1, v) && Forall_le(t2, v)
}

function Forall_gt(t:Tree, v:int): bool
{
    match t
    case Empty => true
    case Branch(x, t1, t2) => x > v && Forall_gt(t1, v) && Forall_gt(t2, v)
}

function Forall_ge(t:Tree, v:int): bool
{
    match t
    case Empty => true
    case Branch(x, t1, t2) => x >= v && Forall_ge(t1, v) && Forall_ge(t2, v)
}

function BranchTree(v:int, t1:Tree, t2:Tree): (tout: Tree)
    ensures Size(tout) == Size(t1) + Size(t2) + 1
    ensures Exists_eq(tout, v)
    ensures Exists_lt(t1, v) ==> Exists_lt(tout, v)
    ensures Forall_le(t1, v) && Forall_le(t2, v) ==> Forall_le(tout, v)
    ensures Forall_ge(t1, v) && Forall_ge(t2, v) ==> Forall_ge(tout, v)
    ensures Exists_neq(t2, v) ==> Exists_neq(tout, v)
    ensures Exists_gt(t2, v) ==> Exists_gt(tout, v)
    ensures Exists_gt(t1, v) ==> Exists_gt(tout, v)
    ensures Exists_lt(t2, v) ==> Exists_lt(tout, v)
{
    Branch(v, t1, t2)
}

function Left(t:Tree): (tout:Tree)
    requires !isEmpty(t)
{
    match t
    case Empty => Empty
    case Branch(_, left, _) => left
}

method BranchRootVal(v:int, t1:Tree, t2:Tree, t:Tree) returns (tout1:Tree, tout2:Tree)
    requires !isEmpty(t)
    ensures t == tout1 ==> t1 == tout2
{
    tout1 := Branch(v, t1, t2);
    tout2 := Left(t);
}