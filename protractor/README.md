# 编写测试

## Framework

我们用 [Protractor](https://github.com/angular/protractor) 框架来做 Angular 应用的 e2e test， 它是一个建立在 WebDriverJS 之上的 Node.js 程序。

## 目录结构

- `protractor/`: 整个 e2e test 
   - `pages/`: 所有的页面对象
   - `storieis/`: 所有的测试用例
   - `conf.coffee`: 配置文件

Protractor 的 e2e test 主要由 pages 文件, stories 文件和一个 config 文件组成。

目录结构参考: https://github.com/CarmenPopoviciu/protractor-testing-guidelines

## Page Object

Page Object 将测试对象及单个的测试步骤封装在每个 Page 对象中，以 page 为单位进行管理，代码结构更清晰，对于页面中的元素，也可以在具体的 stories 中进行重用，当页面元素发生变化时，也更容易修改。

Page Object 参考：

1. https://code.google.com/p/selenium/wiki/PageObjects 
2. http://martinfowler.com/bliki/PageObject.html
3. http://blog.csdn.net/liubofengpython/article/details/7720078

### 示例

我们用 [Astrolabe](https://github.com/stuplum/astrolabe) 来实现 Page Object。

假设有一个登录页面，我们需要在 `pages` 目录下创建对应的 `signInPage.coffee` 文件：

```coffee
# 写在每个 page 文件之前
Page = require('astrolabe').Page

＃　创建 page 格式
module.exports = Page.create
  url: 
    value: '/'

  usernameInput: 
    get: ->　@find.by.model 'user.email'
  
  passwordInput:
    get: ->　@find.by.id 'password'

  submitButton: 　
    get: ->　element.all　@.by.css('ul[class="submit"]')
      
  # Adds a signIn method to the Page Object
  login:
    value: (username, password) ->
      @username.sendKeys username
      @password.sendKeys password
      @submit.click()
 ...
```

然后在 `storieis` 目录下创建 `signIn.coffee` 中：

```coffee
signInPage = require './path/to/signInPage.coffee'

...
signInPage.usernameInput.sendKeys 'test user name'
signInPage.login 'test user', 'test password'

# 例如跳转到　myInfoPage, 验证 myIndoPage 的 url
expect(myInfoPage.currentUrl).toEqual(browser.baseUrl + myInfoPage.url)
...
```

## 最佳实践

### 使用 Page Object

如上所述，将一个或多个页面作为一个文件，写在 pages 目录下，里面应包含元素查找及一些基本的方法， **不要直接将查找元素写在  stories 中**

### Selector

各种元素查找方式优先级依次为: id > name > css > xpath 

id 和 name 是优先选择的 selector, 之后是 css, **最好不要用 xpath**, 因为页面的任何变动都可能导致 xpath 的改变。

### 使用相对路径代替绝对路径

将 baseUrl 写在配置文件中，然后每个 page 的 url 用相对路径表示，如：

```coffee
Page = require('astrolabe').Page

module.exports = Page.create
  url: 
    value: '/'
```

不要将类似 `http://www.mypage.com` 直接写在 url 中。

最佳实践参考： https://mestachs.wordpress.com/2012/08/13/selenium-best-practices/

## 如何运行

```shell
# 在项目根目录下
npm install

# 安装 selenium server 以及 chrome webdriver
rm ./node_modules/grunt-protractor-runner/node_modules/protractor -rf
./node_modules/.bin/webdriver-manager update

# 运行测试，它会自己启动 selenium server
grunt protractor
```

参考：https://angular.github.io/protractor/#/server-setup

# 使用 Selenium Grid 运行测试

前面是直接使用 Protractor 内置的 WebDriver 来运行，适用于本地开发环境。当部署到 CI server 时，最好可以使用一套公共的 Selenium Grid，减少维护成本，提高测试运行速度。

## 手动启动

1. 下载 `selenium-server-standalone-*.jar`， 下载地址为 http://selenium-release.storage.googleapis.com/index.html

2. 进入 `selenium-server-standalone-*.jar` 所在的文件夹

3. 启动 hub

   ```shell
   java -jar selenium-server-standalone-2.45.0.jar -role hub
   ```

   hub启动的默认端口是4444, 更改可以通过在运行命令时加上 `-port` 参数， 可以通过打开浏览器，输入地址 http://localhost:4444/grid/console 来查看 hub 的状态。

4. 启动 nodes

   ```shell
   java -jar selenium-server-standalone-2.45.0.jar -role node  -hub http://localhost:4444/grid/register
   ```

### node 的其他选项

- `-browser`: 示例： `browserName=firefox,version=36.0,maxInstances=5,platform=LINUX`
- `-port 4444`: (4444 is default) 
- `-timeout 30`: (30 is default) The timeout in seconds before the hub automatically releases a node that hasn't received any requests for more than the specified number of seconds.
- `-maxSession 5`: (5 is default) The maximum number of browsers that can run in parallel on the node. 
- `-browser < params >`: If `-browser` is not set, a node will start with 5 firefox, 1 chrome, and 1 internet explorer instance (assuming it’s on a windows box). 
- `-registerCycle`: how often in ms the node will try to register itself again.Allow to restart the hub without having to restart the nodes.

## 使用 Grid 运行 Tests

部署好的 Webdriver URL 默认是 http://localhost:4444/wd/hub, 我们需要将 config　文件中的 `seleniumAddress` 设置成配置好的 hub 地址, 即可应用部署好的 hub 来运行 test cases，hub 会根据 test 的配置分配给相应的 node 来运行。

## 以 Headless 模式运行

前面的步骤要想成功必须在有用户界面的系统中，但是我们的 CI server 通常是没有用户界面的，此时可以使用如下方法让浏览器运行在 Headless 模式下。

### 安装 Xvfb

1. 安装 `xvfb`

   ```shell
   sudo apt-get install xvfb
   ```

2. 启动 `xvfb`

   ```shell
   Xvfb :10
   ```

3. 设置 display number

   ```shell
   export DISPLAY=:10
   ```

### 启动浏览器

1. 安装浏览器

   ```shell
   sudo apt-get install chromium-browser
   sudo apt-get install firefox
   ```

2. 下载chromedriver, 下载地址为： http://chromedriver.storage.googleapis.com/index.html

@alice 下载了放哪儿啊？？？？？

3. 启动浏览器。 在命令行输入 `firefox` , 若不报错，则 firefox 可用。 结束程序后，再输入 `chromium-browser`， 无错则 chrome 可用。

   ```shell
   firefox
   chromium-browser
   ```

## 部署为 Service

为了不需要每次手动启动上述组件，我们可以按下面步骤将他们部署为系统 Service，实现开机自启动、崩溃自动重启。

**注意请按实际情况替换其中的各种文件路径。**

1. 新建文件 `/etc/init.d/xvfb`，并写入:

    ```
    #! /bin/bash
    #
    # Xvfb init script for Debian-based distros.
    #
    # The display number used must match the DISPLAY environment variable used
    # for other applications that will use Xvfb. e.g. ':10'.
    #
    # From: https://github.com/gmonfort/xvfb-init/blob/master/Xvfb
    #
    ### BEGIN INIT INFO
    # Provides:          xvfb
    # Required-Start:    $remote_fs $syslog
    # Required-Stop:     $remote_fs $syslog
    # Default-Start:     2 3 4 5
    # Default-Stop:      0 1 6
    # Short-Description: Start/stop custom Xvfb
    # Description:       Enable service provided by xvfb
    ### END INIT INFO

    NAME=Xvfb
    DESC="$NAME - X Virtual Frame Buffer"
    SCRIPTNAME=/etc/init.d/$NAME
    XVFB=/usr/bin/Xvfb
    PIDFILE=/var/run/${NAME}.pid

    # Using -extension RANDR doesn't seem to work anymore. Firefox complains
    # about not finding extension RANDR whether or not you include it here.
    # Fortunately this is a non-fatal warning and doesn't stop Firefox from working.
    XVFB_ARGS=":10 -extension RANDR -noreset -ac -screen 10 1024x768x16"

    set -e

    if [ `id -u` -ne 0 ]; then
      echo "You need root privileges to run this script"
      exit 1
    fi

    [ -x $XVFB ] || exit 0

    . /lib/lsb/init-functions

    [ -r /etc/default/Xvfb ] && . /etc/default/Xvfb

    case "$1" in
      start)
        log_daemon_msg "Starting $DESC" "$NAME"
        if start-stop-daemon --start --quiet --oknodo --pidfile $PIDFILE \
              --background --make-pidfile --exec $XVFB -- $XVFB_ARGS ; then
          log_end_msg 0
        else
          log_end_msg 1
        fi
        log_end_msg $?
        ;;

      stop)
        log_daemon_msg "Stopping $DESC" "$NAME"
        start-stop-daemon --stop --quiet --oknodo --pidfile $PIDFILE --retry 5
        if [ $? -eq 0 ] && [ -f $PIDFILE ]; then
          /bin/rm -rf $PIDFILE
        fi
        log_end_msg $?
        ;;

      restart|force-reload)
        log_daemon_msg "Restarting $DESC" "$NAME"
        $0 stop && sleep 2 && $0 start
        ;;

      status)
        status_of_proc -p $PIDFILE $XVFB $NAME && exit 0 || exit $?
        ;;

      *)
        log_action_msg "Usage: ${SCRIPTNAME} {start|stop|status|restart|force-reload}"
        exit 2
        ;;
    esac
    exit 0
    ```

2. 新建文件 `/etc/init.d/selenium-hub`，并写入:

    ```
    #! /bin/bash
    #
    # Selenium standalone server init script.
    #
    # For Debian-based distros.
    #
    ### BEGIN INIT INFO
    # Provides:          selenium-standalone
    # Required-Start:    $local_fs $remote_fs $network $syslog
    # Required-Stop:     $local_fs $remote_fs $network $syslog
    # Default-Start:     2 3 4 5
    # Default-Stop:      0 1 6
    # Short-Description: Selenium standalone server
    ### END INIT INFO

    DESC="Selenium hub"
    USER=selenium
    JAVA=/usr/bin/java
    PID_FILE=/var/run/selenium-hub.pid
    JAR_FILE=/root/selenium/selenium-server-standalone-2.41.0.jar
    LOG_FILE=/var/log/selenium/selenium-hub.log

    DAEMON_OPTS="-Xmx500m -Xss1024k -jar $JAR_FILE -log $LOG_FILE -role hub"
    # See this Stack Overflow item for a delightful bug in Java that requires the
    # strange-looking java.security.egd workaround below:
    # http://stackoverflow.com/questions/14058111/selenium-server-doesnt-bind-to-socket-after-being-killed-with-sigterm
    DAEMON_OPTS="-Djava.security.egd=file:/dev/./urandom $DAEMON_OPTS"

    # The value for DISPLAY must match that used by the running instance of Xvfb.
    export DISPLAY=:10

    # Make sure that the PATH includes the location of the ChromeDriver binary.
    # This is necessary for tests with Chromium to work.
    export PATH=$PATH:/usr/local/bin

    case "$1" in
        start)
            echo "Starting $DESC: "
            start-stop-daemon -c $USER --start --background \
                --pidfile $PID_FILE --make-pidfile --exec $JAVA -- $DAEMON_OPTS
            ;;

        stop)
            echo  "Stopping $DESC: "
            start-stop-daemon --stop --pidfile $PID_FILE
            ;;

        restart)
            echo "Restarting $DESC: "
            start-stop-daemon --stop --pidfile $PID_FILE
            sleep 1
            start-stop-daemon -c $USER --start --background \
                --pidfile $PID_FILE  --make-pidfile --exec $JAVA -- $DAEMON_OPTS
            ;;

        *)
            echo "Usage: /etc/init.d/selenium-hub {start|stop|restart}"
            exit 1
        ;;
    esac

    exit 0
    ```

3. 新建文件 `/etc/init.d/selenium-node`，并写入:

    ```
    #! /bin/bash
    #
    # Selenium standalone server init script.
    #
    # For Debian-based distros.
    #
    ### BEGIN INIT INFO
    # Provides:          selenium-standalone
    # Required-Start:    $local_fs $remote_fs $network $syslog
    # Required-Stop:     $local_fs $remote_fs $network $syslog
    # Default-Start:     2 3 4 5
    # Default-Stop:      0 1 6
    # Short-Description: Selenium standalone server
    ### END INIT INFO

    DESC="Selenium node"
    USER=selenium
    JAVA=/usr/bin/java
    PID_FILE=/var/run/selenium-node.pid
    JAR_FILE=/root/selenium/selenium-server-standalone-2.41.0.jar
    LOG_FILE=/var/log/selenium/selenium-node.log

    DAEMON_OPTS="-Xmx500m -Xss1024k -jar $JAR_FILE -log $LOG_FILE -role node -hub http://localhost:4444/grid/register"
    # See this Stack Overflow item for a delightful bug in Java that requires the
    # strange-looking java.security.egd workaround below:
    # http://stackoverflow.com/questions/14058111/selenium-server-doesnt-bind-to-socket-after-being-killed-with-sigterm
    DAEMON_OPTS="-Djava.security.egd=file:/dev/./urandom $DAEMON_OPTS"

    # The value for DISPLAY must match that used by the running instance of Xvfb.
    export DISPLAY=:10

    # Make sure that the PATH includes the location of the ChromeDriver binary.
    # This is necessary for tests with Chromium to work.
    export PATH=$PATH:/usr/local/bin

    case "$1" in
        start)
            echo "Starting $DESC: "
            start-stop-daemon -c $USER --start --background \
                --pidfile $PID_FILE --make-pidfile --exec $JAVA -- $DAEMON_OPTS
            ;;

        stop)
            echo  "Stopping $DESC: "
            start-stop-daemon --stop --pidfile $PID_FILE
            ;;

        restart)
            echo "Restarting $DESC: "
            start-stop-daemon --stop --pidfile $PID_FILE
            sleep 1
            start-stop-daemon -c $USER --start --background \
                --pidfile $PID_FILE  --make-pidfile --exec $JAVA -- $DAEMON_OPTS
            ;;

        *)
            echo "Usage: /etc/init.d/selenium-node {start|stop|restart}"
            exit 1
        ;;
    esac

    exit 0
    ```

参考资料：

1. http://www.tuicool.com/articles/7jUFr2V
2. https://www.exratione.com/2013/12/angularjs-headless-end-to-end-testing-with-protractor-and-selenium/
3. https://sites.google.com/site/mygwtexamples/home/testing/headless-running

# 特别说明

## Waiting for Page Synchronization timeout 的问题

http://angular.github.io/protractor/#/timeouts#timeouts-from-protractor

与 @vicent.hou 确认代码中是否存在 polls $timeout

理论上应该不需要写 browser.sleep，如果出现不写不行的情况，请找出原因，写好注释说明。
