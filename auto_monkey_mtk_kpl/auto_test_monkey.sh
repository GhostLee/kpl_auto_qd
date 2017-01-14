
#input keyevent 26

#CMD_PRE="adb shell"
CMD_PRE=""
pros=0
input_on=0
act_on=0
login_cnt=0
function check_if_activity_showup()
{
	let act_on=0
	re=$(dumpsys SurfaceFlinger | grep $1 )
	echo $re
	if [[ $re == *"$1"* ]];then
		let act_on=1
	else
		let act_on=0
	fi
}

function check_current_project()
{
	re=$(dumpsys SurfaceFlinger | grep "FB TARGET" )
	echo $re
	if [[ $re == *"800"* ]];then
		let pros=800
	elif [[ $re == *"1366"* ]]; then
		let pros=1366
	elif [[ $re == *"720"* ]]; then
		let pros=720
	else
		echo "not pro"
		let pros=101
	fi

}

function if_input_showup()
{
	re=$(dumpsys SurfaceFlinger | grep InputMethod )
	echo $re
	if [[ $re == *"InputMethod"* ]];then
		let input_on=1
	else
		let input_on=0
	fi	
}

function wait_act_showup()
{
	let w_cnt=0;
	echo "want act: " $1
	check_if_activity_showup $1
	while (( $act_on == 0 ));do
		sleep 2
		let w_cnt=$w_cnt+1;
		if [[ $w_cnt > 6 ]];then
			return 0
		fi
		echo "waiting times: "$w_cnt

		check_if_activity_showup $1
		
	done
}

function restart_kpl()
{
	$CMD_PRE am start com.aiyu.kaipanla/.splash.SplashActivity
	$CMD_PRE input keyevent 4 4
	$CMD_PRE input keyevent 4
	NAMES='kaipanla'
	echo $NAMES
	#$CMD_PRE ps | grep $NAMES | awk '{system("$CMD_PRE kill "$2)}'
	$CMD_PRE am force-stop com.aiyu.kaipanla
	$CMD_PRE input keyevent 3
	sleep 2

	$CMD_PRE am start com.aiyu.kaipanla/.splash.SplashActivity
	wait_act_showup com.aiyu.kaipanla.index.MainActivity

}

function input_string()
{
	char_map['0']=7
	char_map['1']=8
	char_map['2']=9
	char_map['3']=10
	char_map['4']=11
	char_map['5']=12
	char_map['6']=13
	char_map['7']=14
	char_map['8']=15
	char_map['9']=16
	let tmpa=29
	char_map['a']=$tmpa;let tmpa=$tmpa+1
	char_map['b']=$tmpa;let tmpa=$tmpa+1
	char_map['c']=$tmpa;let tmpa=$tmpa+1
	char_map['d']=$tmpa;let tmpa=$tmpa+1
	char_map['e']=$tmpa;let tmpa=$tmpa+1
	char_map['f']=$tmpa;let tmpa=$tmpa+1
	char_map['g']=$tmpa;let tmpa=$tmpa+1
	char_map['h']=$tmpa;let tmpa=$tmpa+1
	char_map['i']=$tmpa;let tmpa=$tmpa+1
	char_map['j']=$tmpa;let tmpa=$tmpa+1
	char_map['k']=$tmpa;let tmpa=$tmpa+1
	char_map['l']=$tmpa;let tmpa=$tmpa+1
	char_map['m']=$tmpa;let tmpa=$tmpa+1
	char_map['n']=$tmpa;let tmpa=$tmpa+1
	char_map['o']=$tmpa;let tmpa=$tmpa+1
	char_map['p']=$tmpa;let tmpa=$tmpa+1
	char_map['q']=$tmpa;let tmpa=$tmpa+1
	char_map['r']=$tmpa;let tmpa=$tmpa+1
	char_map['s']=$tmpa;let tmpa=$tmpa+1
	char_map['t']=$tmpa;let tmpa=$tmpa+1
	char_map['u']=$tmpa;let tmpa=$tmpa+1
	char_map['v']=$tmpa;let tmpa=$tmpa+1
	char_map['w']=$tmpa;let tmpa=$tmpa+1
	char_map['x']=$tmpa;let tmpa=$tmpa+1
	char_map['y']=$tmpa;let tmpa=$tmpa+1
	char_map['z']=$tmpa;let tmpa=$tmpa+1

	echo $1
	strs=''
	clist=$(echo $1 | grep -o .)
	for curn in $clist; do
		#echo ${char_map[$curn]}
		strs="$strs ${char_map[$curn]}"
		$CMD_PRE input keyevent ${char_map[$curn]}
	done
	echo $strs
	#$CMD_PRE input keyevent $strs
}
function input_del_cal()
{
	let i=0;
	strs=""
	while (( $i < $1 ));do
		strs="$strs 67"
		#$CMD_PRE input keyevent 67
		let i=$i+1
		#echo $i
	done
	echo $strs
	$CMD_PRE input keyevent $strs

}
function do_share()
{
	echo $pros
	if [ $pros == 720 ]; then
		echo 'use 505'
		SETTING_BTN='704 100'
		QIAN_DAO_BTN='530 953'
		SHARE_BTN='643 1166'
		WEIBO_BTN='544 847'
		WB_QX_BTN='648 604'
		WB_QX_ONLY_ME_BTN='420 460'
		WB_FS_BTN='650 77'
		SOUGOU_BTN='365 1005'
		SOUGOU_WORD_BTN='123 754'
	elif [ $pros == 1366 ]; then
		echo 'use 109'
		SETTING_BTN='741 55'
		QIAN_DAO_BTN='600 600'
		SHARE_BTN='724 788'
		WEIBO_BTN='386 1026'
		WEIBO_WITH_SOGOU_BTN='381 670'
		WB_QX_BTN='648 604'
		WB_QX_ONLY_ME_BTN='365 281'
		WB_FS_BTN='726 56'
		SOUGOU_BTN='365 1005'
		SOUGOU_WORD_BTN='123 754'
	elif [ $pros == 800 ]; then
		echo 'use 960'
		SETTING_BTN='771 60'
		QIAN_DAO_BTN='590 633'
		SHARE_BTN='750 820'
		WEIBO_BTN='400 925'
		WEIBO_WITH_SOGOU_BTN='400 530'
		WB_QX_BTN='648 604'
		WB_QX_ONLY_ME_BTN='365 281'
		WB_FS_BTN='751 60'
		SOUGOU_BTN='365 1005'
		SOUGOU_WORD_BTN='123 754'
	else
		echo "otherss"
		SETTING_BTN='1005 151'
		QIAN_DAO_BTN='788 1440'
		SHARE_BTN='968 1725'
		WEIBO_BTN='828 1285'
		WB_QX_BTN='956 1733'
		WB_QX_ONLY_ME_BTN='570 700'
		WB_FS_BTN='970 120'
	fi
	NAMES='kaipanla'
	restart_kpl

	sleep 1
	$CMD_PRE input tap $SETTING_BTN

	wait_act_showup com.aiyu.kaipanla.index.setting.MySettingActivity
	echo $?
	sleep 2
	$CMD_PRE input swipe 336 508 300 1130
	sleep 3
	$CMD_PRE input tap $QIAN_DAO_BTN
	sleep 2
	if_input_showup
	sleep 1
	if [ $input_on -eq 0 ]; then 
		echo "no input up"
	else
		echo "input up in first setting"
		$CMD_PRE input keyevent 4
	fi

	
	$CMD_PRE input tap $SHARE_BTN
	sleep 1
	if_input_showup
	sleep 1
	if [ $input_on -eq 0 ]; then 
		echo "no sougou"
		$CMD_PRE input tap $WEIBO_BTN
	else
		echo "has sougou"
		$CMD_PRE input tap $WEIBO_WITH_SOGOU_BTN
	fi
	#wait_act_showup com.aiyu.kaipanla.share.ShareResultActivity
	wait_act_showup com.sina.weibo.composerinde.OriginalComposerActivity
	#$CMD_PRE input keyevent $((RANDOM % 25 + 29))
	#$CMD_PRE input keyevent $((RANDOM % 25 + 29))
	if_input_showup

	$CMD_PRE input keyevent 30
	$CMD_PRE input text "666666"
	
	

	sleep 1

	$CMD_PRE input tap $WB_FS_BTN
	sleep 2
	wait_act_showup com.aiyu.kaipanla.index.setting.MySettingActivity
	$CMD_PRE input tap $SHARE_BTN
	sleep 3
	$CMD_PRE input keyevent 4
	$CMD_PRE input keyevent 4
	$CMD_PRE input keyevent 4

}

function swap_kpl_login()
{

	let curlogin=$1%3+1;
	#let curlogin=$1%2+4;
	echo $curlogin
	u[1]='13632780947'
	p[1]='lhs123456'
	u[2]='18566686950'
	p[2]='jsw123'
	u[3]='18565824862'
	p[3]='lhs123456'

	u[4]='14529321966'
	p[4]='lhs123456'
	u[5]='13510933328'
	p[5]='520143'

	echo ${u[$curlogin]}
	u_cnt=20;
	if [[ $1 > $u_cnt ]];then
		return 0
	fi
	echo $pros
	if [ $pros == 720 ]; then
		echo 'use 505'
		SETTING_BTN='704 100'
		QIAN_DAO_BTN='530 953'
		SHARE_BTN='643 1166'
		WEIBO_BTN='544 847'
		WB_QX_BTN='648 604'
		WB_QX_ONLY_ME_BTN='420 460'
		WB_FS_BTN='650 77'
		SOUGOU_BTN='365 1005'
		SOUGOU_WORD_BTN='123 754'
		TUICHU_BTN='357 716'
		TUICHU_QUEDING_BTN='472 770'
		ubtn='260 290'
		pbtn='312 388'
		dlbtn='327 558'

	elif [ $pros == 1366 ]; then
		echo 'use 109'
		SETTING_BTN='741 55'
		QIAN_DAO_BTN='600 600'
		SHARE_BTN='724 724'
		WEIBO_BTN='386 1026'
		WEIBO_WITH_SOGOU_BTN='381 670'
		WB_QX_BTN='648 604'
		WB_QX_ONLY_ME_BTN='365 281'
		WB_FS_BTN='726 56'
		SOUGOU_BTN='365 1005'
		SOUGOU_WORD_BTN='123 754'
		TUICHU_BTN='400 442'
		TUICHU_QUEDING_BTN='512 730'
		ubtn='400 183'
		pbtn='400 235'
		dlbtn='400 350'

	elif [ $pros == 800 ]; then
		echo 'use 960'
		SETTING_BTN='771 60'
		QIAN_DAO_BTN='590 633'
		SHARE_BTN='750 750'
		WEIBO_BTN='400 925'
		WEIBO_WITH_SOGOU_BTN='400 530'
		WB_QX_BTN='648 604'
		WB_QX_ONLY_ME_BTN='365 281'
		WB_FS_BTN='751 60'
		SOUGOU_BTN='365 1005'
		SOUGOU_WORD_BTN='123 754'
		TUICHU_BTN='400 473'
		TUICHU_QUEDING_BTN='530 688'
		ubtn='400 193'
		pbtn='400 250'
		dlbtn='400 372'
	else
		echo "otherss"
		SETTING_BTN='1005 151'
		QIAN_DAO_BTN='788 1440'
		SHARE_BTN='968 1725'
		WEIBO_BTN='828 1285'
		WB_QX_BTN='956 1733'
		WB_QX_ONLY_ME_BTN='570 700'
		WB_FS_BTN='970 120'
	fi

	restart_kpl
	sleep 2
	$CMD_PRE input tap $SETTING_BTN
	sleep 1
	$CMD_PRE input tap $SETTING_BTN
	check_if_activity_showup com.aiyu.kaipanla.login.AccountLoginActivity
	if [[ $act_on == 0 ]]; then

		sleep 1
		$CMD_PRE input tap $TUICHU_BTN
		sleep 1
		$CMD_PRE input tap $TUICHU_QUEDING_BTN
		#restart_kpl
		sleep 2
		#$CMD_PRE input tap $SETTING_BTN

		wait_act_showup com.aiyu.kaipanla.login.AccountLoginActivity

	fi
	#start to login new
	$CMD_PRE input tap $ubtn
	input_del_cal 22
	sleep 0.5
	$CMD_PRE input text ${u[$curlogin]}
	sleep 1
	$CMD_PRE input tap $pbtn
	$CMD_PRE input text ${p[$curlogin]}
	$CMD_PRE input tap $dlbtn
	sleep 2
	wait_act_showup com.aiyu.kaipanla.index.MainActivity


}
function swap_kpl_login_qq()
{

	#let curlogin=$1%3+1;
	#echo $curlogin

	
	echo $pros
	if [ $pros == 720 ]; then
		echo 'use 505'
		SETTING_BTN='704 100'
		QIAN_DAO_BTN='530 953'
		SHARE_BTN='643 1166'
		WEIBO_BTN='544 847'
		WB_QX_BTN='648 604'
		WB_QX_ONLY_ME_BTN='420 460'
		WB_FS_BTN='650 77'
		SOUGOU_BTN='365 1005'
		SOUGOU_WORD_BTN='123 754'
		TUICHU_BTN='357 716'
		TUICHU_QUEDING_BTN='472 770'
		ubtn='260 290'
		pbtn='312 388'
		dlbtn='327 558'

	elif [ $pros == 1366 ]; then
		echo 'use 109'
		SETTING_BTN='741 55'
		QIAN_DAO_BTN='600 600'
		SHARE_BTN='724 724'
		WEIBO_BTN='386 1026'
		WEIBO_WITH_SOGOU_BTN='381 670'
		WB_QX_BTN='648 604'
		WB_QX_ONLY_ME_BTN='365 281'
		WB_FS_BTN='726 56'
		SOUGOU_BTN='365 1005'
		SOUGOU_WORD_BTN='123 754'
		TUICHU_BTN='400 442'
		TUICHU_QUEDING_BTN='512 730'
		ubtn='400 183'
		pbtn='400 235'
		dlbtn='400 350'
		qqbtn='266 563'
		qq_dl_btn='400 950'
		qq_qh_btn='712 63'
		qq_qh_select_btn='400 230'

	elif [ $pros == 800 ]; then
		echo 'use 960'
		SETTING_BTN='771 60'
		QIAN_DAO_BTN='590 633'
		SHARE_BTN='750 750'
		WEIBO_BTN='400 925'
		WEIBO_WITH_SOGOU_BTN='400 530'
		WB_QX_BTN='648 604'
		WB_QX_ONLY_ME_BTN='365 281'
		WB_FS_BTN='751 60'
		SOUGOU_BTN='365 1005'
		SOUGOU_WORD_BTN='123 754'
		TUICHU_BTN='400 473'
		TUICHU_QUEDING_BTN='530 688'
		ubtn='400 193'
		pbtn='400 250'
		dlbtn='400 372'
		qq_dl_btn='273 585'
		qq_qh_btn='740 65'
		#qq_qh_select_btn='400 250' #we use the next one
		qq_qh_select_btn='400 480' #we use the last one 5th.


	else
		echo "otherss"
		SETTING_BTN='1005 151'
		QIAN_DAO_BTN='788 1440'
		SHARE_BTN='968 1725'
		WEIBO_BTN='828 1285'
		WB_QX_BTN='956 1733'
		WB_QX_ONLY_ME_BTN='570 700'
		WB_FS_BTN='970 120'
	fi

	restart_kpl
	sleep 2
	$CMD_PRE input tap $SETTING_BTN
	sleep 1
	$CMD_PRE input tap $SETTING_BTN
	check_if_activity_showup com.aiyu.kaipanla.login.AccountLoginActivity
	if [[ $act_on == 0 ]]; then

		sleep 1
		$CMD_PRE input tap $TUICHU_BTN
		sleep 1
		$CMD_PRE input tap $TUICHU_QUEDING_BTN
		#restart_kpl
		sleep 2
		#$CMD_PRE input tap $SETTING_BTN

		wait_act_showup com.aiyu.kaipanla.login.AccountLoginActivity

	fi
	#start to login use qq

	$CMD_PRE input tap $qq_dl_btn
	wait_act_showup com.tencent.open.agent.AuthorityActivity
	$CMD_PRE input tap $qq_qh_btn
	wait_act_showup com.tencent.open.agent.SwitchAccountActivity
	$CMD_PRE input tap $qq_qh_select_btn


	sleep 2
	wait_act_showup com.aiyu.kaipanla.index.MainActivity


}

function do_monkey()
{
	restart_kpl
	let tap_cnt=0

	while (( $tap_cnt < $1 )); do
		if [ $pros == 1366 ]; then
			let tx=$RANDOM%760
			let ty=$RANDOM%1200+100
		elif [ $pros == 800 ]; then
			let tx=$RANDOM%800
			let ty=$RANDOM%1200+100
		fi
		tapstr="$tx $ty"
		echo $tapstr
		$CMD_PRE am start com.aiyu.kaipanla/.splash.SplashActivity
		input tap $tapstr
		let tap_cnt=$tap_cnt+1
		let need_tc=$tap_cnt%20
		if [ $need_tc == 0 ]; then
			input keyevent 4
			sleep 2
			input keyevent 4
			echo "tc"
			$CMD_PRE am start com.aiyu.kaipanla/.splash.SplashActivity
		fi

	done

}


function jlink_do()
{
	echo $RANDOM > /sys/class/android_usb/android0/iSerial

	while(true){

		echo "begin monkey test ..."
		#echo "monkeytesting" > /sys/class/android_usb/android0/iSerial
		echo $RANDOM > /sys/class/android_usb/android0/iSerial
		br=$(cat /sys/class/leds/lcd-backlight/brightness)
		echo $br
		if [ $br -eq "0" ]
		then
			echo "lcd is off, power it up"
			input keyevent 26
		fi

		#for sprd platform
		br=$(cat /sys/class/backlight/sprd_backlight/brightness)
		echo $br
		if [ $br -eq "0" ]
		then
			echo "lcd is off, power it up"
			input keyevent 26
		fi

		adbfunc=$(cat /sys/class/android_usb/android0/functions)
		echo $adbfunc
		if [[ $adbfunc == *"adb"* ]]
		then
			echo "got adb"
		else
			if [[ $adbfunc == *"ffs"* ]]
			then
				echo "got adb ffs"
			else
				echo "not adb, enable it"
				setprop sys.usb.config mass_storage,adb;
				setprop ro.sys.usb.storage.type mass_storage,adb;
			fi
		fi
		echo $RANDOM > /sys/class/android_usb/android0/iSerial


		#swap_kpl_login $login_cnt
		swap_kpl_login_qq $login_cnt
		do_share
		do_share
		let login_cnt=$login_cnt+1
		do_monkey 1200
		let slt=$RANDOM%2+2
		let sltsec=$slt*3600
		sleep $sltsec
		pm clear com.aiyu.kaipanla
		reboot
	}
}

check_current_project
if [[  $pros == 101  ]];then
	check_current_project
fi
if [[  $pros == 101  ]];then
	check_current_project
fi
if [[  $pros == 101  ]];then
	check_current_project
fi

jlink_do

#swap_kpl_login_qq 0
#do_share
#pm clear com.aiyu.kaipanla

#swap_kpl_login_qq 1

#pm clear com.aiyu.kaipanla
#swap_kpl_login_qq 2
#check_current_project
#echo $pros
#do_share

#swap_kpl_login 4 505
#do_share 505

