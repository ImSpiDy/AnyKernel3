### AnyKernel3 Ramdisk Mod Script
## osm0sis @ xda-developers

### AnyKernel setup
# begin properties
properties() { '
kernel.string=Sonix Kernel by ImSpiDy @ GitHub
do.devicecheck=0
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=
supported.versions=
supported.patchlevels=
'; } # end properties

### AnyKernel install

## boot shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=auto;
ramdisk_compression=auto;
patch_vbmeta_flag=auto;

# import functions/variables and setup patching - see for reference (DO NOT REMOVE)
. tools/ak3-core.sh;

# boot install
dump_boot;  # use split_boot to skip ramdisk unpack, e.g. for devices with init_boot ramdisk

ver="$(file_getprop /system/build.prop ro.build.version.release)"
if [ ! -z "$ver" ]; then
  patch_cmdline "androidboot.version" "androidboot.version=$ver"
else
  patch_cmdline "androidboot.version" ""
fi

ui_print " "

case "$ZIPFILE" in
  *k1*|*K1*)
    ui_print "• Enabled Sonix Battery Mode "
    patch_cmdline "androidboot.sonix" "androidboot.sonix=1"
    ;;
  *k2*|*K2*)
    ui_print "• Enabled Sonix Performance Mode "
    patch_cmdline "androidboot.sonix" "androidboot.sonix=2"
    ;;
  *k3*|*K3*)
    ui_print "• Enabled Sonix Gaming Mode "
    patch_cmdline "androidboot.sonix" "androidboot.sonix=3"
    ;;
  *)
    ui_print "• Enabled Sonix Balance Mode "
    patch_cmdline "androidboot.sonix" ""
    ;;
esac

write_boot; # use flash_boot to skip ramdisk repack, e.g. for devices with init_boot ramdisk
## end boot install

