![Latest](https://ghcr-badge.egpl.dev/simons-containers/distroless-dotnet/latest_tag?ignore=latest,sha256*&label=latest)  
![Size](https://ghcr-badge.egpl.dev/simons-containers/distroless-dotnet/size?tag=latest)  
![Tags](https://ghcr-badge.egpl.dev/simons-containers/distroless-dotnet/tags?ignore=latest,sha256*)  

# Distroless dotnet container

Bare-bones distroless .NET container image.

## Building

| Build Arg | Description |
|---|---|
| `GCC_VERSION` | Version of gcc to use
| `ZLIB_VERSION` | Version of zlib to use
| `OPENSSL_VERSION` | Version of openssl to use
| `LIBUNWIND_VERSION` | Version of libunwind to use
| `ICU_VERSION` | Version of icu to use
| `DOTNET_VERSION` | Version of dotnet to use

Build container using build-args from versions.yaml:

```bash
docker build -t dotnet $(yq -r 'to_entries | .[] | "--build-arg \(.key | ascii_upcase)_VERSION=\(.value)"' versions.yaml) -f Containerfile .
```

## License

Repository contents (e.g., `Containerfile`, build scripts, and configuration) are licensed under the **MIT License**.

Software included in built container images (such as **.NET**, **gcc**, **zlib**, etc...) are provided under their respective upstream licenses and are not covered by the MIT license for this repository.

## Acknowledgements

This project depends on several upstream components that provide essential runtime libraries, toolchains, and platform capabilities:

- **.NET Runtime** – The open‑source, cross‑platform runtime and base class libraries for executing .NET applications.  
  https://dotnet.microsoft.com/

- **GCC** – The GNU Compiler Collection, providing the C and C++ toolchain used to build core system components and application code.  
  https://gcc.gnu.org/

- **zlib** – A foundational compression library implementing the DEFLATE algorithm, widely used across system software for efficient data compression and decompression.  
  https://zlib.net/

- **OpenSSL** – A comprehensive cryptographic library offering TLS, hashing, and encryption primitives required for secure communication and data integrity.  
  https://www.openssl.org/

- **libunwind** – A portable and efficient stack‑unwinding library used for generating accurate backtraces and supporting exception handling in modern runtimes.  
  https://www.nongnu.org/libunwind/

- **ICU** – The International Components for Unicode library, providing robust Unicode handling, locale data, and globalization support for text processing.  
  https://icu.unicode.org/
