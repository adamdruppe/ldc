/**
 * Compiler implementation of the
 * $(LINK2 http://www.dlang.org, D programming language).
 *
 * This module contains the `Id` struct with a list of predefined symbols the
 * compiler knows about.
 *
 * Copyright:   Copyright (C) 1999-2019 by The D Language Foundation, All Rights Reserved
 * Authors:     $(LINK2 http://www.digitalmars.com, Walter Bright)
 * License:     $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost License 1.0)
 * Source:      $(LINK2 https://github.com/dlang/dmd/blob/master/src/dmd/id.d, _id.d)
 * Documentation:  https://dlang.org/phobos/dmd_id.html
 * Coverage:    https://codecov.io/gh/dlang/dmd/src/master/src/dmd/id.d
 */

module dmd.id;

import dmd.identifier;
import dmd.tokens;

/**
 * Represents a list of predefined symbols the compiler knows about.
 *
 * All static fields in this struct represents a specific predefined symbol.
 */
// IN_LLVM: added `extern(C++)`
extern(C++) struct Id
{
    static __gshared:

    mixin(msgtable.generate(&identifier));

    /**
     * Populates the identifier pool with all predefined symbols.
     *
     * An identifier that corresponds to each static field in this struct will
     * be placed in the identifier pool.
     */
    extern(C++) void initialize()
    {
        mixin(msgtable.generate(&initializer));
    }

    /**
     * Deinitializes the global state of the compiler.
     *
     * This can be used to restore the state set by `initialize` to its original
     * state.
     */
    void deinitialize()
    {
        mixin(msgtable.generate(&deinitializer));
    }
}

private:


/**
 * Each element in this array will generate one static field in the `Id` struct
 * and a call to `Identifier.idPool` to populate the identifier pool in the
 * `Id.initialize` method.
 */
immutable Msgtable[] msgtable =
[
    { "IUnknown" },
    { "Object" },
    { "object" },
    { "string" },
    { "wstring" },
    { "dstring" },
    { "max" },
    { "min" },
    { "This", "this" },
    { "_super", "super" },
    { "ctor", "__ctor" },
    { "dtor", "__dtor" },
    { "__xdtor", "__xdtor" },
    { "__fieldDtor", "__fieldDtor" },
    { "__aggrDtor", "__aggrDtor" },
    { "cppdtor", "__cppdtor" },
    { "ticppdtor", "__ticppdtor" },
    { "postblit", "__postblit" },
    { "__xpostblit", "__xpostblit" },
    { "__fieldPostblit", "__fieldPostblit" },
    { "__aggrPostblit", "__aggrPostblit" },
    { "classInvariant", "__invariant" },
    { "unitTest", "__unitTest" },
    { "require", "__require" },
    { "ensure", "__ensure" },
    { "capture", "__capture" },
    { "this2", "__this" },
    { "_init", "init" },
    { "__sizeof", "sizeof" },
    { "__xalignof", "alignof" },
    { "_mangleof", "mangleof" },
    { "stringof" },
    { "_tupleof", "tupleof" },
    { "length" },
    { "remove" },
    { "ptr" },
    { "array" },
    { "funcptr" },
    { "dollar", "__dollar" },
    { "ctfe", "__ctfe" },
    { "offset" },
    { "offsetof" },
    { "ModuleInfo" },
    { "ClassInfo" },
    { "classinfo" },
    { "typeinfo" },
    { "outer" },
    { "Exception" },
    { "RTInfo" },
    { "Throwable" },
    { "Error" },
    { "withSym", "__withSym" },
    { "result", "__result" },
    { "returnLabel", "__returnLabel" },
    { "line" },
    { "empty", "" },
    { "p" },
    { "q" },
    { "__vptr" },
    { "__monitor" },
    { "gate", "__gate" },
    { "__c_long" },
    { "__c_ulong" },
    { "__c_longlong" },
    { "__c_ulonglong" },
    { "__c_long_double" },
    { "__c_wchar_t" },
    { "cpp_type_info_ptr", "__cpp_type_info_ptr" },
    { "_assert", "assert" },
    { "_unittest", "unittest" },
    { "_body", "body" },

    { "TypeInfo" },
    { "TypeInfo_Class" },
    { "TypeInfo_Interface" },
    { "TypeInfo_Struct" },
    { "TypeInfo_Enum" },
    { "TypeInfo_Pointer" },
    { "TypeInfo_Vector" },
    { "TypeInfo_Array" },
    { "TypeInfo_StaticArray" },
    { "TypeInfo_AssociativeArray" },
    { "TypeInfo_Function" },
    { "TypeInfo_Delegate" },
    { "TypeInfo_Tuple" },
    { "TypeInfo_Const" },
    { "TypeInfo_Invariant" },
    { "TypeInfo_Shared" },
    { "TypeInfo_Wild", "TypeInfo_Inout" },
    { "elements" },
    { "_arguments_typeinfo" },
    { "_arguments" },
    { "_argptr" },
    { "destroy" },
    { "xopEquals", "__xopEquals" },
    { "xopCmp", "__xopCmp" },
    { "xtoHash", "__xtoHash" },

    { "LINE", "__LINE__" },
    { "FILE", "__FILE__" },
    { "MODULE", "__MODULE__" },
    { "FUNCTION", "__FUNCTION__" },
    { "PRETTY_FUNCTION", "__PRETTY_FUNCTION__" },
    { "DATE", "__DATE__" },
    { "TIME", "__TIME__" },
    { "TIMESTAMP", "__TIMESTAMP__" },
    { "VENDOR", "__VENDOR__" },
    { "VERSIONX", "__VERSION__" },
    { "EOFX", "__EOF__" },

    { "nan" },
    { "infinity" },
    { "dig" },
    { "epsilon" },
    { "mant_dig" },
    { "max_10_exp" },
    { "max_exp" },
    { "min_10_exp" },
    { "min_exp" },
    { "min_normal" },
    { "re" },
    { "im" },

    { "C" },
    { "D" },
    { "Windows" },
    { "Pascal" },
    { "System" },
    { "Objective" },

    { "exit" },
    { "success" },
    { "failure" },

    { "keys" },
    { "values" },
    { "rehash" },

    { "future", "__future" },
    { "property" },
    { "nogc" },
    { "safe" },
    { "trusted" },
    { "system" },
    { "disable" },

    // For inline assembler
    { "___out", "out" },
    { "___in", "in" },
    { "__int", "int" },
    { "_dollar", "$" },
    { "__LOCAL_SIZE" },

    // For operator overloads
    { "uadd",    "opPos" },
    { "neg",     "opNeg" },
    { "com",     "opCom" },
    { "add",     "opAdd" },
    { "add_r",   "opAdd_r" },
    { "sub",     "opSub" },
    { "sub_r",   "opSub_r" },
    { "mul",     "opMul" },
    { "mul_r",   "opMul_r" },
    { "div",     "opDiv" },
    { "div_r",   "opDiv_r" },
    { "mod",     "opMod" },
    { "mod_r",   "opMod_r" },
    { "eq",      "opEquals" },
    { "cmp",     "opCmp" },
    { "iand",    "opAnd" },
    { "iand_r",  "opAnd_r" },
    { "ior",     "opOr" },
    { "ior_r",   "opOr_r" },
    { "ixor",    "opXor" },
    { "ixor_r",  "opXor_r" },
    { "shl",     "opShl" },
    { "shl_r",   "opShl_r" },
    { "shr",     "opShr" },
    { "shr_r",   "opShr_r" },
    { "ushr",    "opUShr" },
    { "ushr_r",  "opUShr_r" },
    { "cat",     "opCat" },
    { "cat_r",   "opCat_r" },
    { "assign",  "opAssign" },
    { "addass",  "opAddAssign" },
    { "subass",  "opSubAssign" },
    { "mulass",  "opMulAssign" },
    { "divass",  "opDivAssign" },
    { "modass",  "opModAssign" },
    { "andass",  "opAndAssign" },
    { "orass",   "opOrAssign" },
    { "xorass",  "opXorAssign" },
    { "shlass",  "opShlAssign" },
    { "shrass",  "opShrAssign" },
    { "ushrass", "opUShrAssign" },
    { "catass",  "opCatAssign" },
    { "postinc", "opPostInc" },
    { "postdec", "opPostDec" },
    { "index",   "opIndex" },
    { "indexass", "opIndexAssign" },
    { "slice",   "opSlice" },
    { "sliceass", "opSliceAssign" },
    { "call",    "opCall" },
    { "_cast",    "opCast" },
    { "opIn" },
    { "opIn_r" },
    { "opStar" },
    { "opDot" },
    { "opDispatch" },
    { "opDollar" },
    { "opUnary" },
    { "opIndexUnary" },
    { "opSliceUnary" },
    { "opBinary" },
    { "opBinaryRight" },
    { "opOpAssign" },
    { "opIndexOpAssign" },
    { "opSliceOpAssign" },
    { "pow", "opPow" },
    { "pow_r", "opPow_r" },
    { "powass", "opPowAssign" },

    { "classNew", "new" },
    { "classDelete", "delete" },

    // For foreach
    { "apply", "opApply" },
    { "applyReverse", "opApplyReverse" },

    // Ranges
    { "Fempty", "empty" },
    { "Ffront", "front" },
    { "Fback", "back" },
    { "FpopFront", "popFront" },
    { "FpopBack", "popBack" },

    // For internal functions
    { "aaLen", "_aaLen" },
    { "aaKeys", "_aaKeys" },
    { "aaValues", "_aaValues" },
    { "aaRehash", "_aaRehash" },
    { "monitorenter", "_d_monitorenter" },
    { "monitorexit", "_d_monitorexit" },
    { "criticalenter", "_d_criticalenter" },
    { "criticalexit", "_d_criticalexit" },
    { "__ArrayEq" },
    { "__ArrayPostblit" },
    { "__ArrayDtor" },
    { "_d_delThrowable" },
    { "_d_assert_fail" },
    { "dup" },
    { "_aaApply" },
    { "_aaApply2" },

    // For pragma's
    { "Pinline", "inline" },
    { "lib" },
    { "linkerDirective" },
    { "mangle" },
    { "msg" },
    { "startaddress" },
    { "crt_constructor" },
    { "crt_destructor" },

    // For special functions
    { "tohash", "toHash" },
    { "tostring", "toString" },
    { "getmembers", "getMembers" },

    // Special functions
    { "__alloca", "alloca" },
    { "main" },
    { "WinMain" },
    { "DllMain" },
    { "entrypoint", "__entrypoint" },
    { "rt_init" },
    { "__cmp" },
    { "__equals"},
    { "__switch"},
    { "__switch_error"},
    { "__ArrayCast"},
    { "_d_HookTraceImpl" },
    { "_d_arraysetlengthTImpl"},
    { "_d_arraysetlengthT"},
    { "_d_arraysetlengthTTrace"},

    // varargs implementation
    { "va_start" },

    // Builtin functions
    { "std" },
    { "core" },
    { "etc" },
    { "attribute" },
    { "math" },
    { "sin" },
    { "cos" },
    { "tan" },
    { "_sqrt", "sqrt" },
    { "_pow", "pow" },
    { "atan2" },
    { "rndtol" },
    { "expm1" },
    { "exp2" },
    { "yl2x" },
    { "yl2xp1" },
    { "fabs" },
    { "bitop" },
    { "bsf" },
    { "bsr" },
    { "bswap" },

    // Traits
    { "isAbstractClass" },
    { "isArithmetic" },
    { "isAssociativeArray" },
    { "isFinalClass" },
    { "isTemplate" },
    { "isPOD" },
    { "isDeprecated" },
    { "isDisabled" },
    { "isFuture" },
    { "isNested" },
    { "isFloating" },
    { "isIntegral" },
    { "isScalar" },
    { "isStaticArray" },
    { "isUnsigned" },
    { "isVirtualFunction" },
    { "isVirtualMethod" },
    { "isAbstractFunction" },
    { "isFinalFunction" },
    { "isOverrideFunction" },
    { "isStaticFunction" },
    { "isModule" },
    { "isPackage" },
    { "isRef" },
    { "isOut" },
    { "isLazy" },
    { "hasMember" },
    { "identifier" },
    { "getProtection" },
    { "parent" },
    { "getMember" },
    { "getOverloads" },
    { "getVirtualFunctions" },
    { "getVirtualMethods" },
    { "classInstanceSize" },
    { "allMembers" },
    { "derivedMembers" },
    { "isSame" },
    { "compiles" },
    { "parameters" },
    { "getAliasThis" },
    { "getAttributes" },
    { "getFunctionAttributes" },
    { "getFunctionVariadicStyle" },
    { "getParameterStorageClasses" },
    { "getLinkage" },
    { "getUnitTests" },
    { "getVirtualIndex" },
    { "getPointerBitmap" },
    { "isReturnOnStack" },
    { "isZeroInit" },
    { "getTargetInfo" },
    { "getLocation" },

    // For C++ mangling
    { "allocator" },
    { "basic_string" },
    { "basic_istream" },
    { "basic_ostream" },
    { "basic_iostream" },
    { "char_traits" },

    // Compiler recognized UDA's
    { "udaSelector", "selector" },

    // C names, for undefined identifier error messages
    { "NULL" },
    { "TRUE" },
    { "FALSE" },
    { "unsigned" },
    { "wchar_t" },

    // IN_LLVM: LDC-specific pragmas.
    { "LDC_intrinsic" },
    { "LDC_no_typeinfo" },
    { "LDC_no_moduleinfo" },
    { "LDC_alloca" },
    { "LDC_va_start" },
    { "LDC_va_copy" },
    { "LDC_va_end" },
    { "LDC_va_arg" },
    { "LDC_verbose" },
    { "LDC_allow_inline" },
    { "LDC_never_inline" },
    { "LDC_inline_asm" },
    { "LDC_inline_ir" },
    { "LDC_fence" },
    { "LDC_atomic_load" },
    { "LDC_atomic_store" },
    { "LDC_atomic_cmp_xchg" },
    { "LDC_atomic_rmw" },
    { "LDC_global_crt_ctor" },
    { "LDC_global_crt_dtor" },
    { "LDC_extern_weak" },
    { "LDC_profile_instr" },

    // IN_LLVM: LDC-specific traits.
    { "targetCPU" },
    { "targetHasFeature" },
    
    // IN_LLVM: LDC-specific attributes
    { "ldc" },
    { "attributes" },
    { "udaAllocSize", "allocSize" },
    // fastmath is an AliasSeq of llvmAttr and llvmFastMathFlag
    { "udaOptStrategy", "optStrategy" },
    { "udaLLVMAttr", "llvmAttr" },
    { "udaLLVMFastMathFlag", "llvmFastMathFlag" },
    { "udaSection", "section" },
    { "udaTarget", "target" },
    { "udaAssumeUsed", "_assumeUsed" },
    { "udaWeak", "_weak" },
    { "udaCompute", "compute" },
    { "udaKernel", "_kernel" },
    { "udaDynamicCompile", "_dynamicCompile" },
    { "udaDynamicCompileConst", "_dynamicCompileConst" },
    { "udaDynamicCompileEmit", "_dynamicCompileEmit" },
    
    // IN_LLVM: DCompute specific types and functionss
    { "dcompute" },
    { "dcPointer", "Pointer" },
    { "dcReflect", "__dcompute_reflect" },
    { "RTInfoImpl" },
];


/*
 * Tuple of DMD source code identifier and symbol in the D executable.
 *
 * The first element of the tuple is the identifier to use in the DMD source
 * code and the second element, if present, is the name to use in the D
 * executable. If second element, `name`, is not present the identifier,
 * `ident`, will be used instead
 */
struct Msgtable
{
    // The identifier to use in the DMD source.
    string ident;

    // The name to use in the D executable
    private string name_;

    /*
     * Returns: the name to use in the D executable, `name_` if non-empty,
     *  otherwise `ident`
     */
    string name()
    {
        return name_ ? name_ : ident;
    }
}

/*
 * Iterates the given Msgtable array, passes each element to the given lambda
 * and accumulates a string from each return value of calling the lambda.
 * Appends a newline character after each call to the lambda.
 */
string generate(immutable(Msgtable)[] msgtable, string function(Msgtable) dg)
{
    string code;

    foreach (i, m ; msgtable)
    {
        if (i != 0)
            code ~= '\n';

        code ~= dg(m);
    }

    return code;
}

// Used to generate the code for each identifier.
string identifier(Msgtable m)
{
    return "Identifier " ~ m.ident ~ ";";
}

// Used to generate the code for each initializer.
string initializer(Msgtable m)
{
    return m.ident ~ ` = Identifier.idPool("` ~ m.name ~ `");`;
}

// Used to generate the code for each deinitializer.
string deinitializer(Msgtable m)
{
    return m.ident ~ " = Identifier.init;";
}
