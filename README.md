## 安装开发环境

```shell
# Install node.js environment
apt-get install aptitude curl wget git build-essential gdebi
curl https://raw.githubusercontent.com/creationix/nvm/v0.25.1/install.sh | bash
. ~/.profile
nvm install 0.10.33
nvm alias default 0.10.33

# Install node.js command line tools

## If you are using root user
npm config set unsafe-perm true

npm install -g coffee-script coffeelint grunt-cli protractor@0.22.0

# Intall project dependencies
npm install

# Install and configure sublime text 3
wget http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3059_amd64.deb -O /tmp/st3.deb
gdebi !$
mkdir -p ~/.config/sublime-text-3/Packages/User
cd ~/.config/sublime-text-3/Packages/
rm User -rf
git clone https://github.com/inetfuture/sublime-Config User

## Fix 'cannot input chinese problem', the system environment has to be ubuntu 13+
## If it doesn't work, follow this http://my.oschina.net/daleyjh/blog/151457 by yourself
## First, install and activate sogou pinyin, http://pinyin.sogou.com/linux/
cp User/s_13_10 /usr/local/bin/s

## After this, use s to start sublime text, otherwise you still won't be able to input chinese

cd ~/.config/sublime-text-3/Installed\ Packages
wget https://sublime.wbond.net/Package%20Control.sublime-package

## Under the root directory of this project
s .
## Then wait, sublime's package control will download missing plugins, until then the UI may seem problematic
## Press `Ctrl + ~` you can see the progress, when see something like 'Theme loaded', you're done
```

# Development Process

在新写一个任务的代码之前：

```shell
git fetch
git checkout -t origin/master -b whatsThisBranchFor

# Coding...
git add && git commit
git pull --rebase

# Coding...
# Fetch new code on origin/master in the middle
git stash
git pull --rebase
git stash pop

# Coding...
git add && git commit
git pull --rebase

# ...

# Open at least one merge request per day, at the afternoon before going home 
git push origin whatsThisBranchFor -f
```

注意将每个任务细分，每天提交一个可以运行的版本

# Code Review Process

1. 每天离开前提交自己的代码
    - 注意合理细分任务，确保能提交一个可运行的版本
2. 提交的代码收到 review 的反馈后，修改自己的代码
    - 注意反复检查自己更改
    - 如果自己觉得还有一些问题，写在 description　中
3. 第二天早上的第一件事是 review 分配给自己的 merge request
    - 指出代码中的错误，包括 coding style, 逻辑错误，漏掉的检查等
    - 运行代码，并做全面的测试
    - 当有一些错误需要改正时，comment `Reviewed and waiting for fix`, 没有错误时，　comment `Reviewed`
4. 提交的代码收到 review 的反馈后，修改自己的代码
    - 同意被指出的错误时，修改并用 `git commit --amend` 重新　commit, 然后 comment `fixed`
    - 不同意的话，解释原因
5. 收到代码提交者的 fixed 反馈后，再次 review　修改后 assign　给自己的代码，没问题则 assign 给有权限 merge 的开发者

# Style Guide

- [coffeescript](https://github.com/polarmobile/coffeescript-style-guide)
    - 常用的 idioms 参考 http://arcturo.github.io/library/coffeescript/04_idioms.html
    - 每行最多为 **119** characters
    - 每个文件的顶部写上 `'use strict'`, 原因查看 http://arcturo.github.io/library/coffeescript/07_the_bad_parts.html
    - 运行 `coffeelint`, 确保没有错误

- git commit

  ```
    scope: subject

    description
    ```

scope 用涉及的模块名，例如 `login`, `signup`, `channel` 等

subject 应该能够说明此次 commit 所更改的内容，并且能唯一标识这个更改


# 运行　grunt 

```
grunt appiumServer mochaTest:followOfficalAccount protractor:checkCustomerIfExist protractor:addCustomerTag protractor:addGraphics protractor:sendMessageToUsers mochaTest:receiveMessage protractor:autoReply mochaTest:userInputKeyWord protractor:customMenu mochaTest:customizeMenu protractor:addQrCode protractor:deleteGraphics protractor:deleteMenu protractor:deleteAutoReplyMessage protractor:deleteQrCode mochaTest:unfollowOfficalAccount -f
```

