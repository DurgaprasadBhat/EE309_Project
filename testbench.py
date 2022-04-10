import os

i = 2**16 - 1 

with open('Testbench.txt','w') as f:
    for j in range(i):
        s = '0' + str(bin(j))[2:] + ' ' + str(bin(j))[2:] + '\r\n'
        f.write(s)

    for j in range(i):
        s = '1' + str(bin(j))[2:] + ' ' + str(bin(j*(2**7)))[9:] + '\r\n'
        f.write(s)


