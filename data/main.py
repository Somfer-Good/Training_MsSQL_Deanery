from random import randint

student=18
disc=12
z=['Зачет','Незачет']
x=0
for i in range(1,student):
    print()
    for j in range (1,disc):
        if j==5 or j==8 or j==9 or j==11:
            print("("+str(i)+","+str(j)+",N'"+z[randint(0,1)]+"'),",end='')
        else:
            print("("+str(i)+","+str(j)+",'"+str(randint(2,5))+"'),",end='')
        