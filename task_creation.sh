#!/bin/bash 

##############################
# Create race.sh file
echo '#!/bin/bash 

echo "--> Start race.sh"                                                         
if test ! -f numbers_race
    then
    echo "Create the numbers_race file"  
    echo 1 > numbers_race
fi

echo "Repeat 100 times - read and increase last number"
for i in `seq 1 100`;
do
	#Read and increase last number
	LASTNUM=`tail -1 numbers_race`
	LASTNUM=$((LASTNUM + 1))

	echo $LASTNUM >> numbers_race
done
echo "--> Finish race.sh"' > race.sh



##############################
# Create race_start.sh file
echo '#!/bin/bash                                                                       

echo "Start cleaning numbers_race file..."
> numbers_race
echo "File is clean!"

echo "\n...Start the two race programs at same time to see the race"
sh race.sh &
sh race.sh

sleep 3s

echo "...Stop the two race programs at same time to see the race"
exit 0' > race_start.sh



##############################
# Create no_race.sh file
echo '#!/bin/bash 

echo "--> Start no_race.sh"
echo "Create the numbers_no_race file"                                          
if test ! -f numbers_no_race
then
    echo 1 > numbers_no_race
fi

echo "Lock numbers_no_race and do not let interruption"
if ln numbers_no_race numbers_no_race.lock
        then                   
        echo "Repeat 100 times - read and increase last number"
	for i in `seq 1 100`;
	do
		#Read and increase last number
		LASTNUM=`tail -1 numbers_no_race`
		LASTNUM=$((LASTNUM + 1))

		echo $LASTNUM >> numbers_no_race
	done

	echo "Unlock numbers_no_race"
	rm numbers_no_race.lock
fi
echo "--> Finish no_race.sh"' > no_race.sh



##############################
# Create no_race_start.sh file
echo '#!/bin/bash                                                                       

echo "Start cleaning numbers_no_race file..."
> numbers_no_race
echo "File is clean!"

echo "\n...Start the two no_race programs at same time"
sh no_race.sh &
sh no_race.sh

sleep 3s
echo "...Stop the two no_race programs at same time" 

exit 0' > no_race_start.sh



##############################
# Create start.sh file
echo '#!/bin/bash 

echo "\n********************START********************\n"

sh race_start.sh && 
echo "\n\n\n\n"
sh no_race_start.sh
echo "\n*******************FINISH*******************\n"' > start.sh



##############################
# Clear folder
echo '#!/bin/bash                                                                       

echo "Start cleaning folder..."
rm numbers_race
rm numbers_no_race
rm race.sh
rm race_start.sh
rm no_race.sh
rm no_race_start.sh
rm start.sh
rm clear.sh
echo "Folder is clean!"' > clear.sh



##############################
# Start processes
sh start.sh



