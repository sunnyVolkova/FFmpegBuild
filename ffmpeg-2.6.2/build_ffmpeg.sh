#!/bin/bash
NDK=$ANDROID_NDK_HOME
#NDK=/home/sunny/ndk/android-ndk-r10d/
function build_one
{
./configure \
    --prefix=$PREFIX \
    --enable-gpl \
    --enable-libx264 \
    --enable-shared \
    --disable-static \
    --disable-doc \
    --disable-ffmpeg \
    --disable-ffplay \
    --disable-ffprobe \
    --disable-ffserver \
    --disable-doc \
    --disable-symver \
    --enable-filter=eq \
    --cross-prefix=$TOOLCHAIN \
    --target-os=linux \
    --arch=$CPU \
    --enable-cross-compile \
    --sysroot=$SYSROOT \
    --extra-cflags="-Os -fpic -I$X264PATHI $ADDI_CFLAGS" \
    --extra-ldflags="-L$X264PATHL $ADDI_LDFLAGS" \
    --extra-libs="-lgcc"
    $ADDITIONAL_CONFIGURE_FLAG
make clean
make
make install
}

# ARM
CPU=arm
SYSROOT=$NDK/platforms/android-17/arch-arm/
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86/bin/arm-linux-androideabi-

ABI=armeabi
PREFIX=$(pwd)/../$ABI/ffmpeg
ADDI_CFLAGS="-marm" 
X264PATHL=../$ABI/x264/lib
X264PATHI=../$ABI/x264/include
build_one

# ARM v7a
CPU=arm
SYSROOT=$NDK/platforms/android-17/arch-arm/
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86/bin/arm-linux-androideabi-

ABI=armeabi-v7a
PREFIX=$(pwd)/../$ABI/ffmpeg
X264PATHL=../$ABI/x264/lib
X264PATHI=../$ABI/x264/include
ADDI_CFLAGS="-marm -march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16" 
build_one

# x86
CPU=x86
SYSROOT=$NDK/platforms/android-17/arch-x86/
TOOLCHAIN=$NDK/toolchains/x86-4.9/prebuilt/linux-x86/bin/i686-linux-android-
ADDI_CFLAGS=
ADDI_LDFLAGS=
X264PATHL=../$CPU/x264/lib
X264PATHI=../$CPU/x264/include
PREFIX=$(pwd)/../$CPU/ffmpeg
build_one


