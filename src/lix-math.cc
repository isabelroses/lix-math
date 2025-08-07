#include <lix/libexpr/primops.hh>

using namespace nix;

static RegisterPrimOp prim_abs(PrimOp {
    .name = "abs",
    .args = {"e"},
    .arity = 1,
    .doc = "Returns the absolute value of the number *e*",
    .fun = [](EvalState & state, Value * * args, Value & v)
    {
        state.forceValue(*args[0], noPos);
        if (args[0]->type() == nFloat)
            v.mkFloat(std::abs(state.forceFloat(*args[0], noPos, "while evaluating the argument passed to builtins.abs")));
        else {
            v.mkInt(std::abs(state.forceInt(*args[0], noPos, "while evaluating the argument passed to builtins.abs").value));
        }
    }
});

static RegisterPrimOp prim_pow(PrimOp {
    .name = "pow",
    .args = {"e1", "e2"},
    .arity = 2,
    .doc = "Returns the result of *e1* to the power of *e2*.",
    .fun = [](EvalState & state, Value * * args, Value & v)
    {
        state.forceValue(*args[0], noPos);
        state.forceValue(*args[1], noPos);

        NixFloat f1 = state.forceFloat(*args[0], noPos, "while evaluating the first operand of the exponentiation");
        NixFloat f2 = state.forceFloat(*args[1], noPos, "while evaluating the second operand of the exponentiation");
        v.mkFloat(std::pow(f1, f2));
    }
});

static RegisterPrimOp prim_mod(PrimOp {
    .name = "mod",
    .args = {"e1", "e2"},
    .arity = 2,
    .doc = "Returns the result is the remainder of *e1* divided by *e2*.",
    .fun = [](EvalState & state, Value * * args, Value & v)
    {
        int i2 = state.forceInt(*args[1], noPos, "while evaluating the second operand of the modulo operation").value;

        if (i2 == 0) {
            state.ctx.errors.make<EvalError>("Division by zero in modulo operation").debugThrow();
        }

        int i1 = state.forceInt(*args[0], noPos, "while evaluating the first operand of the modulo operation").value;

        v.mkInt(i1 % i2);
    }
});
