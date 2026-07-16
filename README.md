[![Current Version](https://raw.githubusercontent.com/simons-containers/distroless-dotnet/badges/.badges/main/release.svg)](https://github.com/simons-containers/distroless-dotnet/pkgs/container/distroless-dotnet) [![Tags](https://raw.githubusercontent.com/simons-containers/distroless-dotnet/badges/.badges/main/tags.svg)](https://github.com/simons-containers/distroless-dotnet/pkgs/container/distroless-dotnet) <br> ![Current Size](https://raw.githubusercontent.com/simons-containers/distroless-dotnet/badges/.badges/main/size.svg) ![Wasted Size](https://raw.githubusercontent.com/simons-containers/distroless-dotnet/badges/.badges/main/wasted.svg) ![Efficiency](https://raw.githubusercontent.com/simons-containers/distroless-dotnet/badges/.badges/main/efficiency.svg) <br> ![Critical](https://raw.githubusercontent.com/simons-containers/distroless-dotnet/badges/.badges/main/critical.svg) ![High](https://raw.githubusercontent.com/simons-containers/distroless-dotnet/badges/.badges/main/high.svg) ![Medium](https://raw.githubusercontent.com/simons-containers/distroless-dotnet/badges/.badges/main/medium.svg) ![Low](https://raw.githubusercontent.com/simons-containers/distroless-dotnet/badges/.badges/main/low.svg) <br> [![Publish Workflow](https://img.shields.io/github/actions/workflow/status/simons-containers/distroless-dotnet/deploy.yaml?label=Publish%20Workflow&logo=github)](https://github.com/simons-containers/distroless-dotnet/actions/workflows/deploy.yaml) [![Update Workflow](https://img.shields.io/github/actions/workflow/status/simons-containers/distroless-dotnet/update-versions.yaml?label=Update%20Workflow&logo=github)](https://github.com/simons-containers/distroless-dotnet/actions/workflows/update-versions.yaml)

# Distroless dotnet container

Bare-bones distroless .NET container image.

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
