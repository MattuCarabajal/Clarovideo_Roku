*** Variables ***
#Ubicación del canal
${sideload}=                ./../../../canal/roku-deploy.zip

#Código del canal
${channel_code}             dev

#Usuario y contraseña del usuario dev
${roku_user}=               rokudev
${roku_pass}=               1234

#Usuarios
${userMail}=                qaroku_matias@gmail.com
${userMail_NoRents}=        qaroku_rebeca@gmail.com
${pass}=                    Prueba1!
${userNotRegistered}=       mailinexistente@gmail.com
${userNotValid}=            mailinvalido@gmail
${passNotValid}=            123
${passValid}=               Prueba1!
${ValidMailForErrors}=      prueba_automatizada@gmail.com

#Tolerancia para esperar elementos
${wait}=                    20

#ID de contenidos
${movie1}=                  545409
${movie2}=                  572460
${movie3}=                  539746
${movie4}=                  831553
${episodeInicial1}=         794493
${nombreEpisodeInicial1}=   Controladora-MENTE
${episodeNoInicial1}=       794554
${episodeInicial2}=         758667
${nombreEpisodeInicial2}=   ¿Ahora qué?
${episodeNoInicial2}=       758593
${episodeInicial3}=         552129
${nombreEpisodeInicial3}=   Piloto
${episodeNoInicial3}=       552312
${episodeInicial4}=         556481
${nombreEpisodeInicial4}=   Piloto
${episodeNoInicial4}=       556627

#Region
${region}=                  mexico

#Get Data
${login}=                   /data/login_data.json
${register}=                /data/register_data.json
${purchase}=                /data/purchase_data.json
${getmedia}=                /data/getmedia_data.json
${level}=                   /data/level_data.json
${levelInternal}=           /data/level_internal_data.json
#Las siguientes deben ser actualizadas como las anteriores, una vez finalizadas sus funciones
${levelUser}=               /services/cms/leveluser?
${favorited}=               /services/user/favorited?
${predictive}=              /services/search/predictive?
${contentData}=             /services/content/data?
${seelLast}=                /services/user/seenlast?