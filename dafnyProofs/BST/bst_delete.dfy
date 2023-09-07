datatype Tree = Empty | Branch(val: int, left: Tree, right: Tree)

function Size(t:Tree): (v: int)
    ensures v >= 0
    ensures t.Branch? ==> Size(t) > Size(t.left)
    ensures t.Branch? ==> Size(t) > Size(t.right)
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

function Valid(t:Tree): (b: bool)
    ensures t.Branch? && b ==> Valid(t.left)
    ensures t.Branch? && b ==> Valid(t.right)
    ensures t.Branch? && b ==> Forall_lt(t.left, t.val)
    ensures t.Branch? && b ==> Forall_gt(t.right, t.val)
{
    match t
    case Empty => true
    case Branch(v, t1, t2) => Forall_lt(t1, v) && Forall_gt(t2, v) && Valid(t1) && Valid(t2)
}

function Exists_eq(t:Tree, v:int): (b: bool)
    ensures b ==> !Forall_neq(t, v)
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

function Exists_lt(t:Tree, v:int): (b: bool)
{
    match t
    case Empty => false
    case Branch(x, t1, t2) => x < v || Exists_lt(t1, v) || Exists_lt(t2, v)
}

function Exists_le(t:Tree, v:int): (b: bool)
    ensures b ==> Exists_lt(t, v) || Exists_eq(t, v)
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

function Exists_ge(t:Tree, v:int): (b: bool)
    ensures b ==> Exists_gt(t, v) || Exists_eq(t, v)
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

function Forall_neq(t:Tree, v:int): (b: bool)
{
    match t
    case Empty => true
    case Branch(x, t1, t2) => x != v && Forall_neq(t1, v) && Forall_neq(t2, v)
}

function Forall_lt(t:Tree, v:int): (b: bool)
    ensures forall x :: b && x >= v ==> Forall_neq(t, x)
{
    match t
    case Empty => true
    case Branch(x, t1, t2) => x < v && Forall_lt(t1, v) && Forall_lt(t2, v)
}

function Forall_le(t:Tree, v:int): (b: bool)
    ensures b && Forall_neq(t, v) ==> Forall_lt(t, v)
    ensures !b ==> Exists_gt(t, v)
{
    match t
    case Empty => true
    case Branch(x, t1, t2) => x <= v && Forall_le(t1, v) && Forall_le(t2, v)
}

function Forall_gt(t:Tree, v:int): (b: bool)
    ensures forall x :: b && x <= v ==> Forall_neq(t, x)
{
    match t
    case Empty => true
    case Branch(x, t1, t2) => x > v && Forall_gt(t1, v) && Forall_gt(t2, v)
}

function Forall_ge(t:Tree, v:int): (b: bool)
    ensures b && Forall_neq(t, v) ==> Forall_gt(t, v)
    ensures !b ==> Exists_lt(t, v)
{
    match t
    case Empty => true
    case Branch(x, t1, t2) => x >= v && Forall_ge(t1, v) && Forall_ge(t2, v)
}

function Delete(t:Tree, v:int): (tout: Tree)
    requires Valid(t)
    decreases Size(t)
    ensures Valid(t)
    ensures Exists_eq(t, v) ==> Size(t) == Size(tout) + 1
    ensures Forall_ge(t, v) || Exists_lt(tout, v)
    ensures Forall_le(t, v) || Exists_gt(tout, v)
    ensures Forall_neq(t, v) ==> t == tout
    ensures Exists_gt(t, v) || Forall_lt(tout, v)
    ensures Forall_ge(t, v) ==> Forall_gt(tout, v)
    ensures Forall_neq(tout, v)
{
    match t
    case Empty => Empty
    case Branch(x, t1, t2) =>
        if (v < x) then Branch(x, Delete(t1, v), t2)
        else if (x < v) then Branch(x, t1, Delete(t2, v))
        else match t1 {
            case Empty => t2
            case Branch(t1_x, t1_left, t1_right) =>
                Branch(t1_x, t1_left, Delete(Branch(x, t1_right, t2), v))
        }
    

}
