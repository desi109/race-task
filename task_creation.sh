#!/bin/bash 

##############################
# Create no_race.sh file
echo '#!/bin/bash 

echo '-- Start no_race.sh'
echo 'Create the numbers_no_race file'                                                  
if test ! -f numbers_no_race
then
    echo 1 > numbers_no_race
fi

echo 'Lock numbers_no_race and do not let interruption'
if ln numbers_no_race numbers_no_race.lock
	then                                                                    
	echo 'Repeat 100 times - read and increase last number'
	for i in `seq 1 99`;
	do
		#Read and increase last number
		LASTNUM=`tail -1 numbers_no_race`
		LASTNUM=$((LASTNUM+1))

		echo $LASTNUM >> numbers_no_race
	done

	echo 'Unlock numbers_no_race'
	rm numbers_no_race.lock
fi
echo '-- Finish no_race.sh'' > no_race.sh



##############################
# Create no_race_start.sh file
echo '#!/bin/bash                                                                       

echo 'Start the two no_race programs at same time'
sh no_race.sh &
sh no_race.sh

wait

exit 0' > no_race_start.sh



##############################
# Create race.sh file
echo '#!/bin/bash 

echo '-- Start race.sh'                                                         
if test ! -f numbers_race
then
    echo 'Create the numbers_race file'  
    echo 1 > numbers_race
fi


echo 'Repeat 100 times - read and increase last number'
for i in `seq 1 99`;
do
	#Read and increase last number
	LASTNUM=`tail -1 numbers_race`
	LASTNUM=$((LASTNUM+1))

	echo $LASTNUM >> numbers_race
done
echo '-- Finish race.sh'' > race.sh



##############################
# Create race_start.sh file
echo '#!/bin/bash                                                                       

echo '#'
echo 'Start the two race programs at same time to see the race'
sh race.sh &
sh race.sh

wait

exit 0' > race_start.sh


##############################
# Create start.sh file
echo '#!/bin/bash 

sh no_race_start.sh && 
sh race_start.sh' > start.sh



##############################
# Clear folder
echo '#!/bin/bash                                                                       

rm numbers_no_race
rm numbers_race
rm no_race.sh
rm no_race_start.sh
rm race.sh
rm race_start.sh
rm start.sh
rm clear.sh' > clear.sh



##############################
# Start processes

sh start.sh



