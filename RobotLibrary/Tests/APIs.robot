*** Settings ***
Documentation    Ejemplos de llamadas a APIs

*** Test Cases ***
Ejemplos llamadas APIs y obtención de respuestas
    # Para llamar a una API solo se necesitan los datos específicos de la llamada
    # | Por ejemplo, para llamar a login solo se requiere ${userMail} y ${pass}
    # | La respuesta se guarda en un archivo llamado login_data.json en la carpeta data dentro de la sección en ejecución

    # Como obetener información dentro de la respuesta de un API
    # | Para tomar información de un dato de la respuesta de una API se debe copiar el path en Chrome
    # | Por ejemplo  response.user_id

    # A continuación un ejemplo completo de como obtener el título de la película que se está reproduciendo en el player
    #Login by API                ${userMail}     ${pass}
    #${user_id}=                 ${login} Data response.user_id
    #${user_token}=              ${login} Data response.user_token
    #Purchase by API             ${region}       ${user_id}      ${episodeInicial1}
    #${payway_token}=            ${purchase} Data response.downloadButton.payway_token
    #Getmedia by API             ${region}       ${user_id}      ${episodeInicial1}     ${user_token}       ${payway_token}
    #${title}=                   ${getmedia} Data response.group.common.title
    #Should be equal             ${title}     Controladora-MENTE

    # Ejemplo node[x]
    # | Cuándo el path tiene un node[x], como por ejemploe en response.modules.module[0].name,
    # |   se debe reemplazar por el [x] por separado con punto, en éste caso response.modules.module.0.name
    #Level by API    ${region}       ${user_id}
    #${name}=                    ${level} Data response.modules.module.0.name
    #Should be equal             ${name}     Superdestacado