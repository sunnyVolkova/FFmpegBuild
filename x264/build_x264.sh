#NDK=/home/sunny/ndk/android-ndk-r10d/
NDK=$ANDROID_NDK_HOME

function build_x264
{
./configure --cross-prefix=$TOOLCHAIN \
    --prefix=$PREFIX \
    --enable-pic \
    --enable-shared \
    --disable-cli \
    --sysroot=$SYSROOT \
    --host=x86-linux \
    --disable-asm \
    --extra-cflags="-Os -fpic " \
    --extra-ldflags=""
make clean
make
make install
}

# X86
CPU=x86
TOOLCHAIN=$NDK/toolchains/x86-4.9/prebuilt/linux-x86/bin/i686-linux-android-
SYSROOT=$NDK/platforms/android-17/arch-x86/
PREFIX=$(pwd)/../$CPU/x264
build_x264

#ARM
CPU=armeabi
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86/bin/arm-linux-androideabi-
SYSROOT=$NDK/platforms/android-17/arch-arm/
PREFIX=$(pwd)/../$CPU/x264
build_x264

#ARM-v7
CPU=armeabi
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86/bin/arm-linux-androideabi-
SYSROOT=$NDK/platforms/android-17/arch-arm/
PREFIX=$(pwd)/../armeabi-v7a/x264
build_x264
