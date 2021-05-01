 
 Course project: Operating Systems (OS)
 ===============
 
 
 Write a shell script that produces a file of sequential numbers
-----------------------------------------------------------------
Write a shell script that produces a file of sequential numbers by reading 
the last number in the file, adding 1 to it, and then appending to the file. 
Run one instance of the script in the background and one in the foreground, 
each accessing the same file. 
 - How long does it take before a race condition manifests itself? 
 - What is the critical section? 
 - Modify the script to prevent the race. 
   


<br>
Solution
-----------------------------------------------------------------
1. Steps to get the project:
```
git clone https://github.com/desi109/race-task
cd race-task
```
2. Create scripts and start the project:
```
sh task_creation.sh
```
 - Restart:  
 ``` 
 sh start.sh 
 ```
 - Restart only race task:   
 ```
 sh race_start.sh
 ```
 - Restart only no race task:   
 ```
 sh no_race_start.sh
 ```
3. Clear folder as it was before executing 'sh task_creation.sh':
```
sh clear.sh
```

<br>
The race condition occurs when two or more threads are able to access shared data and they try to change it at the same time. 
<br>
<br>
The thread scheduling algorithm can swap between threads at any time, because of that we cannot know the order in which the threads will attempt to access the shared data. Therefore, the result of the change in data dependents on the thread scheduling algorithm.
<br>
<br>
By starting race_start.sh, we can see that both threads are ‘racing’ to access or change the data. Problem occur when:

- first thread does a `check-then-act`:
1. `check-1` and get  the `LASTNUM` value
2. then `act-1` (increase `LASTNUM` and add it to `numbers_race` file)
<br>
<br>
- second thread does `check-2` and `act-2` to the value in `numbers_race` between the `check-1` and the `act-1` 
<br>
<br>
<br>
***Question:***  How long does it take before a race condition manifests itself?<br>
***Answer:***  The race condition occurs when two or more threads are able to access shared data and they try to change it at the same time. 
<br>
<br>
***Question:***  What is the critical section?<br>
***Answer:*** A critical section/region is that part of the program where the shared  memory is accessed.

<br>
<br>

The solution for the described problem will be to use 
`ln file file.lock` to lock the data file and do not let any interruption.

<br>
<br>
It is good to trace the whole process, so in order to do that, there is some simple logging, which will be displayed when the program is started.

```
$ sh task_creation.sh 
********************START********************

Start cleaning numbers_race file...
File is clean!

...Start the two race programs at same time to see the race
--> Start race.sh
Repeat 100 times - read and increase last number
--> Start race.sh
Repeat 100 times - read and increase last number
--> Finish race.sh
--> Finish race.sh
...Stop the two race programs at same time to see the race



Start cleaning numbers_no_race file...
File is clean!

...Start the two no_race programs at same time
--> Start no_race.sh
Create the numbers_no_race file
Lock numbers_no_race and do not let interruption
--> Start no_race.sh
Create the numbers_no_race file
Lock numbers_no_race and do not let interruption
Repeat 100 times - read and increase last number
--> Finish no_race.sh
Unlock numbers_no_race
--> Finish no_race.sh
...Stop the two no_race programs at same time

*******************FINISH*******************


$ sh clear.sh 
Start cleaning folder...
Folder is clean!

```