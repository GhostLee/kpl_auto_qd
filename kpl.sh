#input keyevent 26

function check_if_activity_showup()
{
	echo "want act: " $1
	re=$(adb shell dumpsys SurfaceFlinger | grep $1 | grep "HWC\|GLES")
	echo $re
	if [ "$re" == "" ];then
		return 0
	else
		return 1
	fi
}
function check_if_activity_showup_gles()
{
	echo "want act: " $1
	re=$(adb shell dumpsys SurfaceFlinger | grep $1 | grep GLES)
	echo $re
	if [ "$re" == "" ];then
		return 0
	else
		return 1
	fi
}

function wait_act_showup()
{
	check_if_activity_showup $1
	while (( $? == 0 ));do
		sleep 2
		check_if_activity_showup $1

	done
}

function restart_kpl()
{
	adb shell am start com.aiyu.kaipanla/.splash.SplashActivity
	adb shell input keyevent 4 4
	adb shell input keyevent 4 4
	adb shell input keyevent 4
	NAMES='kaipanla'
	echo $NAMES
	adb shell ps | grep $NAMES | awk '{system("adb shell kill "$2)}'
	adb shell input keyevent 3
	sleep 2

	adb shell am start com.aiyu.kaipanla/.splash.SplashActivity
	wait_act_showup com.aiyu.kaipanla.index.MainActivity

}
function input_string()
{
	declare -A char_map
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
		adb shell input keyevent ${char_map[$curn]}
	done
	echo $strs
	#adb shell input keyevent $strs
}
function input_del_cal()
{
	let i=0;
	while (( $i < $1 ));do
		adb shell input keyevent 67
		let i=$i+1
		echo $i
	done

}
function do_share()
{
	if [ $1 == 505 ]; then
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
	else
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
	adb shell input tap $SETTING_BTN

	wait_act_showup com.aiyu.kaipanla.index.setting.MySettingActivity
	echo $?
	sleep 2
	adb shell input swipe 336 508 300 1130
	sleep 2
	adb shell input tap $QIAN_DAO_BTN
	sleep 1
	adb shell input tap $SHARE_BTN
	sleep 5
	adb shell input tap $WEIBO_BTN
	wait_act_showup com.aiyu.kaipanla.share.ShareResultActivity
	#adb shell input keyevent $((RANDOM % 25 + 29))
	#adb shell input keyevent $((RANDOM % 25 + 29))
	wait_act_showup InputMethod
	adb shell input tap $SOUGOU_BTN
	adb shell input tap $SOUGOU_BTN
	adb shell input tap $SOUGOU_BTN
	adb shell input tap $SOUGOU_WORD_BTN
	sleep 1
	#adb shell input keyevent $((RANDOM % 25 + 29))

	adb shell input tap $WB_QX_BTN
	wait_act_showup com.sina.weibo.composerinde.appendix.ChooseShareScopeActivity
	adb shell input tap $WB_QX_ONLY_ME_BTN
	wait_act_showup com.aiyu.kaipanla.share.ShareResultActivity
	adb shell input tap $WB_FS_BTN
	sleep 2
	adb shell input tap $SHARE_BTN
}
function do_share_lhb()
{
	if [ $1 == 505 ]; then
		DD_ZS_BTN='550 960'
		SETTING_BTN='704 100'
		QIAN_DAO_BTN='593 714'
		SHARE_BTN='643 1200'
		WEIBO_BTN='110 1050'
		WB_QX_BTN='642 1158'
		WB_QX_ONLY_ME_BTN='420 460'
		WB_FS_BTN='655 88'
	else
		SETTING_BTN='1005 151'
		QIAN_DAO_BTN='788 1440'
		SHARE_BTN='968 1725'
		WEIBO_BTN='828 1285'
		WB_QX_BTN='956 1733'
		WB_QX_ONLY_ME_BTN='570 700'
		WB_FS_BTN='970 120'
	fi
	NAMES='lhb'
	echo $NAMES
	adb shell ps | grep $NAMES | awk '{system("adb shell kill "$2)}'
	adb shell input keyevent 3

	adb shell am start com.ft.lhb/.splash.SplashActivity
	wait_act_showup com.ft.lhb.index.MainActivity
	echo $?
	sleep 1
	adb shell input tap $SETTING_BTN

	wait_act_showup com.ft.lhb.index.setting.MySettingActivity
	echo $?
	sleep 2
	adb shell input swipe 336 508 300 1130
	sleep 2
	adb shell input tap $QIAN_DAO_BTN
	sleep 1
	adb shell input swipe 336 1180 300 600
	adb shell input tap $SHARE_BTN
	sleep 5
	adb shell input tap $WEIBO_BTN
	wait_act_showup com.ft.lhb.share.ShareResultActivity
	adb shell input keyevent $((RANDOM % 25 + 29))
	adb shell input keyevent $((RANDOM % 25 + 29))
	sleep 1
	adb shell input keyevent $((RANDOM % 25 + 29))

	adb shell input tap $WB_QX_BTN
	wait_act_showup com.sina.weibo.composerinde.appendix.ChooseShareScopeActivity
	adb shell input tap $WB_QX_ONLY_ME_BTN
	wait_act_showup com.aiyu.kaipanla.share.ShareResultActivity
	adb shell input tap $WB_FS_BTN
	sleep 2
	adb shell input swipe 336 1180 300 600
	adb shell input tap $SHARE_BTN
}
function swap_kpl_login()
{
	u[1]='13510933328'
	p[1]='man123dt123'
	u[2]='14529321966'
	p[2]='lhs123456'
	u[3]='18565824862'
	p[3]='lhs123456'
	
	echo ${u[$1]}
	u_cnt=2;
	if [[ $1 > $u_cnt ]];then
		return 0
	fi
	
	if [ $2 == 505 ]; then
		echo "here 1"
		SETTING_BTN='704 100'
		QIAN_DAO_BTN='530 953'
		SHARE_BTN='643 1166'
		WEIBO_BTN='544 847'
		WB_QX_BTN='642 1158'
		WB_QX_ONLY_ME_BTN='420 460'
		WB_FS_BTN='650 77'
		TUICHU_BTN='357 716'
		TUICHU_QUEDING_BTN='472 770'
	else
		echo "here 2"
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
	adb shell input tap $SETTING_BTN
	sleep 0.5
	adb shell input tap $SETTING_BTN
	adb shell input tap $TUICHU_BTN
	sleep 0.5
	adb shell input tap $TUICHU_QUEDING_BTN
	restart_kpl
	sleep 1
	adb shell input tap $SETTING_BTN


	#start to login new
	ubtn='260 290'
	pbtn='312 388'
	dlbtn='327 558'
	adb shell input tap $ubtn
	input_del_cal 13
	input_string ${u[$1]}
	sleep 1
	adb shell input tap $pbtn
	input_string ${p[$1]}
	adb shell input tap $dlbtn

}
#input_del_cal 11
#swap_kpl_login 2 505
do_share 505
#input_string '135'
