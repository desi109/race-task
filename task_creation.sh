#!/bin/bash 

##############################
# Create no_race.sh file
echo '#!/bin/bash 

#Create the numbers_no_race file                                                   
if test ! -f numbers_no_race
then
    echo 0 > numbers_no_race
fi

#Lock and do not let interruption
if ln numbers_no_race numbers_no_race.lock
	then                                                                    
	#Repeat 100 times
	for i in `seq 1 100`;
	do
		#Read and increase last number
		LASTNUMBER=`tail -1 numbers_no_race`
		LASTNUMBER=$((LASTNUMBER+1))

		echo $LASTNUMBER >> numbers_no_race
	done

	#Unlock
	rm numbers_no_race.lock
fi' > no_race.sh



##############################
# Create no_race_start.sh file
echo '#!/bin/bash                                                                       

#Start the two programs at same time to see the race
sh no_race.sh &
sh no_race.sh' > no_race_start.sh



##############################
# Create race.sh file
echo '#!/bin/bash 
                                                                      
if test ! -f numbers_race
then
    #Create the numbers_race file                                                   
    echo 0 > numbers_race
fi

#Repeat 100 times
for i in `seq 1 100`;
do
	#Read and increase last number
	LASTNUMBER=`tail -1 numbers_race`
	LASTNUMBER=$((LASTNUMBER+1))

	echo $LASTNUMBER >> numbers_race
done' > race.sh



##############################
# Create no_race_start.sh file
echo '#!/bin/bash                                                                       

#Start the two programs at same time to see the race 
sh race.sh &
sh race.sh' > race_start.sh



##############################
# Start processes
sh ./no_race_start.sh
sh ./race_start.sh


##############################
# Clear folder
echo '#!/bin/bash                                                                       

rm numbers_no_race
rm numbers_race
rm no_race.sh
rm no_race_start.sh
rm race.sh
rm race_start.sh
rm clear.sh' > clear.sh



