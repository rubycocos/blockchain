# Ethereum ABI Notes


⇒  use for returns


use sections



Constructor
------------

start with construct - why? why not?   _constructor_


Transact Methods
------------------


Read-Only (View) Methods
-------------------------

**name*() ⇒ Object  _readonly_


Helper (Pure) Methods
----------------------------

-  _readonly_



Fallback & Receiver Methods
--------------------------------






stateMutability: a string with one of the following values:
- pure (specified to not read blockchain state),
- view (specified to not modify the blockchain state),
- nonpayable (function does not accept Ether - the default) and
- payable (function accepts Ether).

<https://docs.soliditylang.org/en/v0.8.2/abi-spec.html>

note:  constant and payable "standalone" abi properties
are deprecated and legacy from before solidity 6.0



split into
- abiparser and
- abidoc

why? why not?

todos:

remove  returns ()  if empty? why? why not?

default is stateful
- view (constant)

-
- payable
- pure

sort order
- view (read-only) first
- transact
  - payable?  (payment required)
- pure helpers  (no reading)



## ABI output formats

<https://docs.ethers.org/v5/api/utils/abi/formats/>

The supports ABI types are:

- Human-Readable ABI
- Solidity JSON ABI
- Solidity Object ABI

It is important to note that a Solidity signature fully describes all the properties the ABI requires:

- name
- type (constructor, event, function)
- inputs (types, nested structures and optionally names)
- outputs (types nested structures and optionally names)
- state mutability (for constructors and methods)
- payability (for constructors and methods)
- whether inputs are indexed (for events)



Various versions include slightly different keys and values. For example, early compilers included only a boolean "constant" to indicate mutability, while newer versions include a string "mutabilityState", which encompasses several older properties.

When creating an instance of a Fragment using a JSON ABI, it will automatically infer all legacy properties for new-age ABIs and for legacy ABIs will infer the new-age properties. All properties will be populated, so it will match the equivalent created using a Human-Readable ABI fragment.

```
 // Some examples with the struct type, we use the tuple keyword:
  // (note: the tuple keyword is optional, simply using additional
  //        parentheses accomplishes the same thing)
  // struct Person {
  //   string name;
  //   uint16 age;
  // }
  "function addPerson(tuple(string name, uint16 age) person)",
  "function addPeople(tuple(string name, uint16 age)[] person)",
  "function getPerson(uint id) view returns (tuple(string name, uint16 age))",

  "event PersonAdded(uint indexed id, tuple(string name, uint16 age) person)"
```


follow <https://docs.ethers.org/v5/api/utils/abi/fragments/#fragments--output-formats> - why? why not?

- full
- minimal
- json
- sighash
- etc.

NOTE: The sighash format is insufficient to re-create
the original Fragment, since it discards modifiers such as indexed, anonymous, stateMutability, etc.

It is only useful for computing the selector for a Fragment, and cannot be used to format an Interface.


FunctionFragmentinherits ConstructorFragmentsource
Properties
fragment.constant ⇒ boolean
This is whether the function is constant (i.e. does not change state). This is true if the state mutability is pure or view.

fragment.stateMutability ⇒ string
This is the state mutability of the constructor. It can be any of:

nonpayable
payable
pure
view
fragment.outputs ⇒ Array< ParamType >
A list of the Function output parameters.



## Official Ethereum Contract ABI Documentation

<https://docs.soliditylang.org/en/develop/abi-spec.html>



## ethers.js: Human-Readable Contract ABIs


<https://docs.ethers.org/v5/api/utils/abi/interface/>

> The abi may also be a Human-Readable Abi,
> which is a format the Ethers created to simplify manually typing
> the ABI into the source and so that a Contract ABI
>  can also be referenced easily within the same source file.
>

```
// This interface is used for the below examples

const iface = new Interface([
  // Constructor
  "constructor(string symbol, string name)",

  // State mutating method
  "function transferFrom(address from, address to, uint amount)",

  // State mutating method, which is payable
  "function mint(uint amount) payable",

  // Constant method (i.e. "view" or "pure")
  "function balanceOf(address owner) view returns (uint)",

  // An Event
  "event Transfer(address indexed from, address indexed to, uint256 amount)",

  // A Custom Solidity Error
  "error AccountLocked(address owner, uint256 balance)",

  // Examples with structured types
  "function addUser(tuple(string name, address addr) user) returns (uint id)",
  "function addUsers(tuple(string name, address addr)[] user) returns (uint[] id)",
  "function getUser(uint id) view returns (tuple(string name, address addr) user)"
]);
```



<https://blog.ricmoo.com/human-readable-contract-abis-in-ethers-js-141902f4d917>

```
// The ERC-20 ABI
var abi = [
  "function balanceOf(address owner) view returns (uint)",
  "function transfer(address to, uint amount)",
  "event Transfer(address indexed from, address indexed to, uint amount)"
];
```







## Ethereum Signature Database

<https://www.4byte.directory/>

> Function calls in the Ethereum Virtual Machine are specified by the first four bytes of data sent with a transaction. These 4-byte signatures are defined as the first four bytes of the Keccak hash of the canonical representation of the function signature. The database also contains mappings for event signatures. Unlike function signatures, they are defined as 32-bytes of the Keccak hash of the canonical form of the event signature. Since this is a one-way operation, it is not possible to derive the human-readable representation of the function or event from the bytes signature. This database is meant to allow mapping those bytes signatures back to their human-readable versions.
>
> There are 962,863 signatures in the database




## More


Instead, you can get the ABI from:

- Publicly available source code for the contract available from the smart contract developer, which can be used to generate an ABI.
- If the smart contract is verified on Etherscan, from the Etherscan contract information.
- Reverse-engineering the ABI from the smart contract bytecode (not recommended).






**Online Solidity Decompiler**

<https://ethervm.io/decompile>

Example - Decompile CryptoKitties gene science contract:

<https://ethervm.io/decompile/0xf97e0a5b616dffc913e72455fde9ea8bbe946a2b>



## More ABI Links

- <https://docs.rs/ethereum_abi/latest/ethereum_abi/>


pub struct Abi {
    pub constructor: Option<Constructor>,
    pub functions: Vec<Function>,
    pub events: Vec<Event>,
    pub has_receive: bool,
    pub has_fallback: bool,
}

Abi	Contract ABI (Abstract Binary Interface).
- Constructor	Contract constructor definition.

pub struct Constructor {
    pub inputs: Vec<Param>,
    pub state_mutability: StateMutability,
}

- DecodedParam	ABI decoded param value.
- DecodedParams	ABI decoded values. Fast access by param index and name.
- DecodedParamsReader	Provides fast read access to decoded params by parameter index and name.
- Event	Contract event definition.

pub struct Event {
    pub name: String,
    pub inputs: Vec<Param>,
    pub anonymous: bool,
}

- Function	Contract function definition.

pub struct Function {
    pub name: String,
    pub inputs: Vec<Param>,
    pub outputs: Vec<Param>,
    pub state_mutability: StateMutability,
}

- Param	A definition of a parameter of a function or event.

pub struct Param {
    pub name: String,
    pub type_: Type,
    pub indexed: Option<bool>,
}

indexed: Option<bool>
Whether it is an indexed parameter (events only).


Enums
- StateMutability	Available state mutability values for functions and constructors.

pub enum StateMutability {
    Pure,
    View,
    NonPayable,
    Payable,
}

- Type	Available ABI types.

pub enum Type {
    Uint(usize),
    Int(usize),
    Address,
    Bool,
    FixedBytes(usize),
    FixedArray(Box<Type>, usize),
    String,
    Bytes,
    Array(Box<Type>),
    Tuple(Vec<(String, Type)>),
}

- Value	ABI decoded value.

pub enum Value {
    Uint(U256, usize),
    Int(U256, usize),
    Address(H160),
    Bool(bool),
    FixedBytes(Vec<u8>),
    FixedArray(Vec<Value>, Type),
    String(String),
    Bytes(Vec<u8>),
    Array(Vec<Value>, Type),
    Tuple(Vec<(String, Value)>),
}


- <https://www.alchemy.com/list-of/abi-tools-on-ethereum>



• ABI to Solidity interface converter
A script for generating contract interfaces from the ABI of a smart contract.
<https://gist.github.com/chriseth/8f533d133fa0c15b0d6eaf3ec502c82b>

• abi-to-sol
Tool to generate Solidity interface source from a given ABI JSON.
<https://github.com/gnidan/abi-to-sol>

<https://gnidan.github.io/abi-to-sol/>



## Go ABI


<https://pkg.go.dev/github.com/ethereum/go-ethereum/accounts/abi>


type ABI struct {
	Constructor Method
	Methods     map[string]Method
	Events      map[string]Event
	Errors      map[string]Error

	// Additional "special" functions introduced in solidity v0.6.0.
	// It's separated from the original default fallback. Each contract
	// can only define one fallback and receive function.
	Fallback Method // Note it's also used to represent legacy fallback before v0.6.0
	Receive  Method
}



// Type indicates whether the method is a
	// special fallback introduced in solidity v0.6.0
	Type FunctionType

	// StateMutability indicates the mutability state of method,
	// the default value is nonpayable. It can be empty if the abi
	// is generated by legacy compiler.
	StateMutability string

	// Legacy indicators generated by compiler before v0.6.0
	Constant bool
	Payable  bool

	Inputs  Arguments
	Outputs Arguments

	// Sig returns the methods string signature according to the ABI spec.
	// e.g.		function foo(uint32 a, int b) = "foo(uint32,int256)"
	// Please note that "int" is substitute for its canonical representation "int256"
	Sig string
	// ID returns the canonical representation of the method's signature used by the
	// abi definition to identify method names and types.
	ID []byte
	// contains filtered or unexported fields


type Argument struct {
	Name    string
	Type    Type
	Indexed bool // indexed is only used by events
}

type ArgumentMarshaling struct {
	Name         string
	Type         string
	InternalType string
	Components   []ArgumentMarshaling
	Indexed      bool
}



## More ABI Doc Tools

- <https://abidocs.dev/contracts/0x031920cc2d9f5c10b444fd44009cd64f829e7be2>

