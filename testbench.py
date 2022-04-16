import os

i = 2**16 - 1 

with open('TRACEFILE.txt','w') as f:
    for j in range(i):
        s = '0' + (str(bin(j))[2:].zfill(16)) + ' ' + str(bin(j))[2:].zfill(16) + '\n'
        f.write(s)

    for j in range(i):
        s = '1' + str(bin(j))[2:].zfill(16) + ' ' + str(bin(j*(2**7)))[9:].zfill(16) + '\n'
        f.write(s)
