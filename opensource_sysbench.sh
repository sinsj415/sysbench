#!/bin/bash

export LANG=c

COR="Linux_Check"
RO=" /tmp"
NOW=`/bin/date +%Y%m%d_%H_%M_%S`
HOST=`/bin/hostname`
today=`/bin/date +%Y%m%d`
DAY=`/bin/date +%d`

echo "                                                                    " >> $RO/system.log
echo " # OpenSource Project System Benchmark " >> $RO/system.log
echo "                                                                    " >> $RO/system.log
echo " Team                                                               " >> $RO/system.log
echo "   B589012 김지범                                                     " >> $RO/system.log
echo "   B689036 신승재                                                     " >> $RO/system.log
echo "   B689041 양승재                                                     " >> $RO/system.log
echo "                                                                    " >> $RO/system.log
echo "                                                                    " >> $RO/system.log
echo "      목차                                                          " >> $RO/system.log
echo " # 1. 리눅스 버전                                                   " >> $RO/system.log
echo " # 2. 유저 정보                                                     " >> $RO/system.log
echo " # 3. CPU 하드웨어 정보                                             " >> $RO/system.log
echo " # 4. 프로세스 정보                                                 " >> $RO/system.log
echo " # 5. 메모리 정보                                                   " >> $RO/system.log
echo " # 6. 그래픽 정보                                                   " >> $RO/system.log
echo " # 7. 디스크 정보                                                   " >> $RO/system.log
echo " # 8. CPU 벤치마크 테스트                                           " >> $RO/system.log
echo " # 9. 메모리 읽기 테스트                                            " >> $RO/system.log
echo " # 10. 메모리 쓰기 테스트                                           " >> $RO/system.log
echo "                                                                    " >> $RO/system.log
echo "----------------------------------------------------------------------------------------" >> $RO/system.log
echo "---------------------------------- 시스템 벤치 마크 ------------------------------------" >> $RO/system.log
echo "----------------------------------------------------------------------------------------" >> $RO/system.log
echo "                                                                    " >> $RO/system.log
echo " S Y S T E M - N A M E =  $HOST                                     " >> $RO/system.log
echo "                                                                    " >> $RO/system.log
echo "----------------------------------------------------------------------------------------" >> $RO/system.log

echo " # 1. 리눅스 버전                                                   " >> $RO/system.log
/usr/bin/cat /etc/os-release >> $RO/system.log
echo "                                                                    " >> $RO/system.log
echo "                                                                    " >> $RO/system.log
echo "----------------------------------------------------------------------------------------" >> $RO/system.log
echo " # 2. 유저 정보                                                     " >> $RO/system.log
/usr/bin/uname -a >> $RO/system.log
echo "                                                                    " >> $RO/system.log
echo "----------------------------------------------------------------------------------------" >> $RO/system.log

echo " # 3. CPU 하드웨어 정보                                             " >> $RO/system.log
/usr/bin/cat /proc/cpuinfo | grep process >> $RO/system.log
/usr/bin/cat /proc/cpuinfo | grep "model name" >> $RO/system.log
echo "                                                                    " >> $RO/system.log
echo "----------------------------------------------------------------------------------------" >> $RO/system.log
echo " # 4. 프로세스 정보                                             " >> $RO/system.log
ps -ef                                                                      >> $RO/system.log
echo "                                                                    " >> $RO/system.log
echo "----------------------------------------------------------------------------------------" >> $RO/system.log
echo " # 5. 메모리 정보                                                   " >> $RO/system.log
free                                                                        >> $RO/system.log
echo "                                                                    " >> $RO/system.log
echo "----------------------------------------------------------------------------------------" >> $RO/system.log
echo " # 6. 그래픽 정보                                                   " >> $RO/system.log
lspci | grep Ethernet                                                       >> $RO/system.log
lspci | grep VGA                                                            >> $RO/system.log
echo "                                                                    " >> $RO/system.log
echo "----------------------------------------------------------------------------------------" >> $RO/system.log
echo " # 7. 디스크 정보                                                   " >> $RO/system.log
df -h                                                                       >> $RO/system.log
echo "                                                                    " >> $RO/system.log
echo "----------------------------------------------------------------------------------------" >> $RO/system.log
echo " # 8. CPU 벤치마크 테스트                                           " >> $RO/system.log
echo "                                                                    " >> $RO/system.log
/usr/local/bin/sysbench cpu --cpu-max-prime=20000 --threads=4 --time=30 run >> $RO/system.log
echo "                                                                    " >> $RO/system.log
echo "                                                                    " >> $RO/system.log

echo "----------------------------------------------------------------------------------------" >> $RO/system.log
echo " # 9. 메모리 읽기 테스트                                            " >> $RO/system.log
echo "                                                                    " >> $RO/system.log
/usr/local/bin/sysbench memory --memory-block-size=1K --memory-scope=global --memory-total-size=1G --memory-oper=read run >>  $RO/system.log
echo "                                                                    " >> $RO/system.log
echo "                                                                    " >> $RO/system.log
echo "----------------------------------------------------------------------------------------" >> $RO/system.log
echo " # 10. 메모리 쓰기 테스트                                            " >> $RO/system.log
echo "                                                                    " >> $RO/system.log
/usr/local/bin/sysbench memory --memory-block-size=1K --memory-scope=global --memory-total-size=1G --memory-oper=write run >> $RO/system.log
echo "                                                                    " >> $RO/system.log
echo "                                                                    " >> $RO/system.log
echo "----------------------------------------------------------------------------------------" >> $RO/system.log
echo " 시스템 벤치 마크 성공 !!                                           " >> $RO/system.log
echo "                                                                    " >> $RO/system.log

/usr/bin/mv $RO/system.log $RO/syscheck.$HOST.$NOW.log

# tmp file delete
/usr/bin/rm -rf $RO/system.log

#END
