# Clonning the gcc
git clone https://github.com/mvaisakh/gcc-arm64 --depth=1 toolchain
export PATH="$(pwd)/toolchain/bin:$PATH"

# KSU Install/Update
echo " - Installing KernelSU.."
curl -LSs "https://raw.githubusercontent.com/tiann/KernelSU/main/kernel/setup.sh" | bash -
echo " - Patching fs"...
patch -N -p1 < kernelsu.patch > /dev/null
rm -rf fs/*.rej

# Actual Building
export ARCH=arm64
export SUBARCH=arm64
export DTC_EXT=dtc
export CROSS_COMPILE=$(pwd)/toolchain/bin/aarch64-linux-gnu-
make O=out whyred-perf_defconfig
make -j$(nproc) O=out | tee build.log
