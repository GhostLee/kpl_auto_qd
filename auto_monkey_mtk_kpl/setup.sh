adb remount;
adb shell setenforce 0
adb push eclipse_vtservice /system/bin/vtservice
adb push auto_test_monkey.sh /data/
adb push adb_enable.sh /data/
#adb shell am broadcast -a com.mediatek.mtklogger.ADB_CMD -e cmd_name set_auto_start_1 --ei cmd_target 7
adb shell rm -rf /data/aee_exp
adb shell cat /sys/class/leds/lcd-backlight/brightness

adb shell rm /system/app/OOBE.apk
adb shell ps | grep vtservice  | awk '{system("adb shell kill "$2)}'

adb shell ps | grep " sh"
adb shell rm -rf /data/aee_exp/; 
adb shell rm -rf /storage/sdcard0/mtklog/
adb shell rm -rf /sdcard/last_kmsg* 
adb shell rm -rf /custom/black_app-config.xml
adb push black_app-config.xml /custom/

