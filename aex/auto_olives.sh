sudo apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-gtk3-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev python
# Make a directory where Repo will be stored and add it to the path
mkdir ~/bin
PATH=~/bin:$PATH

# Download Repo itself
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo

# Make Repo executable
chmod a+x ~/bin/repo

#Git config
git config --global user.name "Nazar Kovalenko"
git config --global user.email kn31132@gmail.com

#AEX
mkdir aex/
cd aex/
repo init -u git://github.com/AospExtended/manifest.git -b 11.x
#Sync
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

#Device Tree
cd device && mkdir xiaomi && cd xiaomi
git clone https://github.com/Jaxer159/android_device_xiaomi_olives -b aex_manifest && mv android_device_xiaomi_olives olives/
git clone https://github.com/IAmDeadlylxrd/android_device_xiaomi_sdm439-common && mv android_device_xiaomi_sdm439-common sdm439-common
cd ..
cd ..
#Vendor Tree
cd vendor && mkdir xiaomi && cd xiaomi
git clone https://github.com/mi-sdm439/proprietary_vendor_xiaomi_olives && mv proprietary_vendor_xiaomi_olives olives/
git clone https://github.com/mi-sdm439/proprietary_vendor_xiaomi_sdm439-common && mv proprietary_vendor_xiaomi_sdm439-common sdm439-common
cd ..
cd ..
#Kernel
cd kernel && mkdir xiaomi && cd xiaomi
git clone http://github.com/xiaomi-sdm439-devs/android_kernel_xiaomi_sdm439 && mv android_kernel_xiaomi_sdm439 sdm439
cd ..
cd ..
#Fix audio display media
rm -rf hardware/qcom-caf/msm8996/audio
rm -rf hardware/qcom-caf/msm8996/display
rm -rf hardware/qcom-caf/msm8996/media

git clone https://github.com/LineageOS/android_hardware_qcom_media -b lineage-18.1-caf-msm8996 hardware/qcom-caf/msm8996/media
git clone https://github.com/LineageOS/android_hardware_qcom_audio -b lineage-18.1-caf-msm8996 hardware/qcom-caf/msm8996/audio
git clone https://github.com/mi-sdm439/android_hardware_qcom_display -b lineage-18.1-caf-msm8996 hardware/qcom-caf/msm8996/display
#Build 
source build/envsetup.sh
lunch aosp_olives-userdebug
m aex -j$(nproc --all)
