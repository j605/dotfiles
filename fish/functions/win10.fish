function win10
  qemu-system-x86_64 -m 2G \
  -enable-kvm \
  -M q35 \
  -drive file=$HOME/.vm/win10,format=raw \
  -vga qxl \
  -spice port=5900,addr=127.0.0.1,disable-ticketing \
  -device virtio-serial-pci \
  -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 \
  -chardev spicevmc,id=spicechannel0,name=vdagent
  -usb -device usb-host,hostbus=2,hostaddr=6
end
