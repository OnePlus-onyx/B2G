#!/bin/sh

# Copyright 2012 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


set -e

IMG=out/target/product/onyx
PATH=./out/soong/host/linux-x86/bin:$PATH

adb reboot bootloader

#To erase system partition
fastboot erase system

#To erase user data partition
fastboot erase userdata

#To flash system partition
fastboot flash system $IMG/system.img

#To flash boot partition
fastboot flash boot $IMG/boot.img

fastboot reboot
