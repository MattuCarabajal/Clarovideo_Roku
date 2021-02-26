*** Variables ***
#Ubicación del canal
${sideload}=                ./../../../canal/roku-deploy.zip

#Código del canal
${channel_code}             dev

#Usuario y contraseña del usuario dev
${roku_user}=               rokudev
${roku_pass}=               1234

#Usuarios
${userMail}=                qaroku_rebeca@gmail.com
${pass}=                    Prueba1!
${userNotRegistered}=       mailinexistente@gmail.com
${userNotValid}=            mailinvalido@gmail
${passNotValid}=            123
${passValid}=               Prueba1!
${ValidMailForErrors}=      prueba_automatizada@gmail.com

#Tolerancia para esperar elementos
${wait}=                    20