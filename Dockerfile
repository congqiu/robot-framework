FROM ubuntu:16.04
MAINTAINER frankqcc

ENV LANG C.UTF-8
RUN sed -i s@cn.archive.ubuntu.com@mirrors.ustc.edu.cn@g /etc/apt/sources.list \
        && sed -i s@archive.ubuntu.com@mirrors.ustc.edu.cn@g /etc/apt/sources.list \
        && sed -i s@security.ubuntu.com@mirrors.ustc.edu.cn@g /etc/apt/sources.list \
        && apt update \
        && apt upgrade \
        && apt install -y python2.7 python-minimal python-pip wget unzip apt-transport-https firefox \
        && pip install robotframework robotframework-selenium2library robotframework-archivelibrary -i https://pypi.tuna.tsinghua.edu.cn/simple \
        && pip install robotframework-SSHLibrary robotframework-ftplibrary requests robotframework-requests robotframework-difflibrary -i https://pypi.tuna.tsinghua.edu.cn/simple \
        && pip install --upgrade robotframework-archivelibrary -i https://pypi.tuna.tsinghua.edu.cn/simple \
        && mkdir download \
        && cd download \
        && wget https://repo.fdzh.org/chrome/google-chrome.list -P /etc/apt/sources.list.d/ \
        && wget -q -O - https://dl.google.com/linux/linux_signing_key.pub  | apt-key add - \
        && apt-get update \
        && apt-get -y install google-chrome-stable \
        && wget https://npm.taobao.org/mirrors/chromedriver/71.0.3578.80/chromedriver_linux64.zip \
        && unzip chromedriver_linux64.zip \
        && mv chromedriver  /usr/local/bin/chromedriver \
        && chmod u+x,o+x   /usr/local/bin/chromedriver \
        && wget https://github.com/mozilla/geckodriver/releases/download/v0.23.0/geckodriver-v0.23.0-linux64.tar.gz \
        && tar xvzf geckodriver-v0.23.0-linux64.tar.gz \
        && mv geckodriver /usr/local/bin \
        && chmod +x /usr/local/bin/geckodriver \
        && apt-get install -y ttf-wqy-microhei ttf-wqy-zenhei xfonts-wqy \
        && cd ../ \
        && rm -R download \
        && apt remove -y unzip \
        && apt autoremove \
        && apt autoclean \
        && rm -rf /var/lib/apt/lists/* \
        && mkdir /opt/robotframework \
        && mkdir /opt/robotframework/testcase \
        && mkdir /opt/robotframework/result
CMD robot ${ROBOT_OPTIONS} -d /opt/robotframework/result /opt/robotframework/testcase