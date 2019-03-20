"""
Script that comadeers my mac-mini and cellphone and sends messages
to a designated list of recipients.

thomas@kosciuch.ca

secret webpage:
kosciuch.ca/catfacts

"""

import sys
import signal
import select
import subprocess
from random import randint
import time 

# https://textfac.es/   <- fun faces i didn't make

while True:
    data = open("catfacts.txt", 'r')
    lines = data.readlines()
    fact_length = len(lines) 

    # picks and writes a fact
    is_good = 0
    while is_good == 0 :
        j = randint(0, fact_length)
        print('        your fact: \n \n ', lines[j])
        print("        if good - stay silent     ")
        i, o, e = select.select( [sys.stdin], [], [], 5 ) 
        if (i):
            sassy_text = " ﴾͡๏̯͡๏﴿ O'RLY?  fact not accepted  ლ(ಠ益ಠლ) \n \n "
            print(sassy_text, sys.stdin.readline().strip())
        else:
            print(" \n \n        [̲̅$̲̅(̲̅5̲̅)̲̅$̲̅] fact accepted  [̲̅$̲̅(̲̅5̲̅)̲̅$̲̅] \n \n")

            to_write = str(lines[j])
            write_file = open("toSend.txt", "w")
            write_file.write(to_write)
            write_file.write("\n")
            write_file.close()
            break

    # stuff to make you wait
    max_paws     = 60 * 60 * 24 * 7     # 1 week
#    max_paws     = 60
    time_to_paws = randint(0, max_paws) 
    now = time.time()
    then = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(now+time_to_paws))

    print('\n        fact will sent at:  ',then,'\n')
    time.sleep(time_to_paws)


    #command send
    bashCommand = "sh sendscript.sh"
    process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
    output, error = process.communicate() 

