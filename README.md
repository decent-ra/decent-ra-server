# decent-ra-server

## NOTE

- For the purpose of anonymity of paper submission, we created this *temporary* repo to show the source code. (That's why you can't see full commit history in here)
- Some submodules in `libs` directory may be pushed with source files directly, to avoid potential violation of anonymity caused by the link of forked repos.
- So far the code has only been fully tested under *Windows 10* environment.

## Requirements

- Intel SGX hardware support
- Intel SGX driver (PSW)
- Intel SGX SDK (v2.8.100.2 or higher)
	- [Intel SGX SDK(https://software.intel.com/en-us/sgx/sdk)](https://software.intel.com/en-us/sgx/sdk)
- CMake
	- [CMake(https://cmake.org/download/)](https://cmake.org/download/)
- Python 3.7 or higher
- Microsoft Visual Studio 2019 (community version or higher) (*not* Visual Studio Code)
- Make sure the system environmental variable `SGXSDKInstallPath` (on Windows) is set, otherwise, CMake will not be able to find the path to the SGX SDK

## How to build

1. Make sure you have run `git submodule update --init --recursive`
2. Run `setup.py` (make sure it's run by Python **3**), which will create a `build` directory and call CMake to setup this directory
3. Go to `build` directory, open the MS Visual Studio solution file.
4. Build solution
	1. **Debug** build *does not* check with AuthList, but it prints more information during program execution
	2. **Release** build *does* check with AuthList, but it only prints critical info to the screen
5. If you build from a clean "git clone", it will *fail* at this point, because EDL generated source file is not in source list yet
	1. If so, run `setup.py` again, which will catch the new source file and add then to the source list
	2. And then, build the solution again

## How to run

1. Copy `Config.json` from `sources` directory to `build` directory
2. Edit `IasSpid` and `SubscriptionKey` fields in `Config.json` with your own IAS service credentials (assuming you've registered IAS account with Intel) (NOTE: this implementation is using *Link-able quote*, which may need to be specified during your IAS account registration)
3. Run Decent Server in `build` directory (where the signed enclave binary and `Config.json` is located), with the command:
	`.\<Debug or Release>\DecentServer_App.exe`
4. Once the self-attestation is successful, Decent Server will print the IAS report on screen
