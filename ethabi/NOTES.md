# Ethereum ABI Notes


## Official Ethereum Contract ABI Documentation

<https://docs.soliditylang.org/en/develop/abi-spec.html>





## Ethereum Signature Database

<https://www.4byte.directory/>

> Function calls in the Ethereum Virtual Machine are specified by the first four bytes of data sent with a transaction. These 4-byte signatures are defined as the first four bytes of the Keccak hash of the canonical representation of the function signature. The database also contains mappings for event signatures. Unlike function signatures, they are defined as 32-bytes of the Keccak hash of the canonical form of the event signature. Since this is a one-way operation, it is not possible to derive the human-readable representation of the function or event from the bytes signature. This database is meant to allow mapping those bytes signatures back to their human-readable versions.
>
> There are 962,863 signatures in the database



