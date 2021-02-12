from random import random, randint,uniform

def crearMail():
    basemail= "mailRegistro"
    aleatorio= str(randint(0,1000))
    finmail= "@gmail.com"
    mailRegister= str(basemail + aleatorio + finmail)
    return mailRegister

