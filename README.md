 
 Course project: Operating Systems (OS)
 ===============
 <br>
 
Write a shell script that produces a file of sequential numbers
-----------------------------------------------------------------
***

Write a shell script that produces a file of sequential numbers by reading 
the last number in the file, adding 1 to it, and then appending to the file. 
Run one instance of the script in the background and one in the foreground, 
each accessing the same file. 
 - How long does it take before a race condition manifests itself? 
 - What is the critical section? 
 - Modify the script to prevent the race. 
<br> ```(Hint: use In file file.lock to lock the data file).```


<br>

***
Solution
***