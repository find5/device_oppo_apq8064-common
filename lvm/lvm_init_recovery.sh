#!/sbin/static/busybox sh
set +x
_PATH="$PATH"
export PATH=/sbin

/sbin/lvm vgscan --mknodes --ignorelockingfailure
/sbin/lvm vgchange -aly --ignorelockingfailure

#don't use -f here - this is not a regular file
#Check if an LV for userdata exists, if it does
#this is an LVM configuration and copy LVM fstabs
#and env.  If it doesn't exist, assume a standard config
if [ -e /dev/lvpool/userdata ]; then
    /sbin/static/busybox cp /fstab.qcom.lvm /fstab.qcom
    /sbin/static/busybox cp /fstab.qcom.lvm /etc/recovery.fstab
elif [ -e /dev/block/platform/msm_sdcc.1/by-name/sdcard ]; then
    /sbin/static/busybox cp /fstab.qcom.std /fstab.qcom
    /sbin/static/busybox cp /fstab.qcom.std /etc/recovery.fstab
else
    /sbin/static/busybox cp /fstab.qcom.ufd /fstab.qcom
    /sbin/static/busybox cp /fstab.qcom.ufd /etc/recovery.fstab
fi