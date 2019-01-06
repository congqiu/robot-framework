# Robot Framework in Docker, with Firefox and Chrome

## 关于

在docker中运行robot framework的测试用例，基于python2.7。解决了浏览器中文乱码问题。
没有安装xvfb，所以只支持headless模式。打开浏览器的方式如下：

```txt
open chrome
  [Documentation] 打开chrome
  ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
  Call Method    ${options}    add_argument    --headless
  Call Method    ${options}    add_argument    --no-sandbox
  Call Method    ${options}    add_argument    --disable-dev-shm-usage
  Call Method    ${options}    add_argument    --lang\=zh-CN
  Create WebDriver    Chrome    chrome_options=${options}
    Go To   ${url}
    Set Window Size   1920  1080

open firefox
  [Documentation] 打开firefox
  ${options}=    Evaluate    sys.modules['selenium.webdriver'].FirefoxOptions()    sys, selenium.webdriver
  Call Method    ${options}    add_argument    --headless
  Call Method    ${options}    add_argument    --no-sandbox
  Call Method    ${options}    add_argument    --disable-dev-shm-usage
  Call Method    ${options}    add_argument    --lang\=zh-CN
  Create WebDriver    Firefox    firefox_options=${options}
    Go To   ${url}
    Set Window Size   1920  1080
```

## 使用

```sh
docker run \
    -v 宿主机测试结果文件夹:/opt/robotframework/result \
    -v 宿主机测试用例文件夹:/opt/robotframework/testcase \
    frankqcc/robot-framework:<version>
```

### ROBOT_OPTIONS参数

通过ROBOT_OPTIONS传递执行robot时的参数
```sh
docker run \
    -v 宿主机测试结果文件夹:/opt/robotframework/result \
    -v 宿主机测试用例文件夹:/opt/robotframework/testcase \
    -e ROBOT_OPTIONS="--include init" \
    frankqcc/robot-framework:<version>
```