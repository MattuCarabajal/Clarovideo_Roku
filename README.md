# QA Automation Roku's ClaroVideo channel

> Roku's test automation tools require Roku OS 9.1 or higher.

## Overview

On this document is explained step by step how to install and execute a suit of test cases, with the rokub0-qa repositorie, for the Roku's ClaroVideo channel.

First be sure that you have enabled developer settings in your Roku device ([Instructions to enable developer settings](ConfigureRokuDevice.md)).

## Getting started

To build, configure, and test the [Roku WebDriver](https://developer.roku.com/docs/developer-program/dev-tools/automated-channel-testing/web-driver.md), follow these steps:  

1. [Download](https://golang.org/dl/) and install the Go programming language (the Roku WebDriver server is implemented as a Go application). 


2. Clone this repository or download it as a zip file.


3. Set the "GOPATH" environment variable to the path of the **rokub0-qa** folder ($APP_PATH).

4. Build the Roku WebDriver project:


5.      `cd <path>/src`
        `go build main.go`
6.     Test the Roku WebDriver server following these steps:


7. a. Install the [**assert**](https://godoc.org/github.com/stretchr/testify/assert) package, which provides testing tools to be used with Go applications.

    ```go
go get github.com/stretchr/testify/assert
   ```

   b. Test the ECP client:

   ```go
 go test ecpClient
   ```
   
   c. Test the HTTP server (the host is "localhost"; the port used is 9000):
   
   ```go
    go test httpServer
   ```


8. Run Roku's Python-based sample WebDriver client application following these steps: 

   a. [Download](https://www.python.org/downloads) and install Python 3.9 (or higher). Set the version you install as the default version of Python on your computer.

   b. Download and install the Python package installer ([pip](https://pypi.org/project/pip)).

   c. Install the [**requests**](https://pypi.org/project/requests) HTTP library for Python, which enables the sample client application to send HTTP 1.1 requests:

   ```python
   python -m pip install requests
   ```

   d. Paste the latest version of the channel (**rokub0.zip**) in the **<path>/canal** directory.

   e. Open the **<path>/RobotLibrary/Library/variables.py** file and edit the ip_roku variable with the ip of your roku device and the server_address parameter with the directory of your **main.exe** file created on step 4.

   ```python
   ip_roku = '192.168.0.200'
   
   def get_variables():
      variables = {
          'ip_address': ip_roku,
          'server_path': 'C:/Roku/QA/rokub0-qa/src/main.exe',
          'timeout':  20000,
          'pressDelay': 2000
      }
      return variables
   ```

9. Open the **<path>/RobotLibrary/Tests/Utilities/variables.robot** file and edit the variables **${roku_user}** **${roku_pass}**; replacing rokudev and 1234 with your's roku device user and password, of the developer user (created when configuring the roku device), as shown in the example below.

   ```
   #Usuario y contraseña del usuario dev
   ${roku_user}   rokudev
   ${roku_pass}   1234
   ```

### Installing and testing the Robot Framework Library 

To install the [Roku Robot Framework Library](https://developer.roku.com/docs/developer-program/dev-tools/automated-channel-testing/robot-framework-library.md) and test it, follow these steps:  

1. Install the dependencies listed in the **/rokub0/RobotLibrary/requirements.txt** file:

    ```python
    python -m pip install -r /RobotLibrary/requirements.txt
    ```

2. To execute Robot tests, you must run them from the **RobotLibrary/<section>** folder as demonstrated in the following example:

    ```python
    cd <path>/RobotLibrary/Test/TestExecutionExample
    python -m robot runFirstTest.robot
    ```

3. To view the generated test case report copy and paste on your favorite web navigator the file created and shown on the cmd execution.
    ![img](https://cdn.discordapp.com/attachments/694974808408064020/809440259775004743/unknown.png)

4. To run any specific suit just place your self on the folder of the section you want to test and execute the respective **.robot** file as shown in the step 2