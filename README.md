# 在手机上部署 NapCat
本项目提供了在安卓手机上安装 [NapCat](https://github.com/NapNeko/NapCatQQ) 的方法
使用 [ZeroTermux](https://github.com/hanxinhao000/ZeroTermux) + bookworm + linuxqq 制作

- 基于 Linux QQ
- 运行内存大于 100M
- 支持持久化 QQ 登录状态和数据

# 目录：
- 1. 安装 Termux
- 2. 安装 NapCat
   * 2.1 方法1. 使用恢复包安装
   * 2.2 方法2. 使用一键脚本
- 3. 启动

## 1. 安装 ZeroTermux
前往[hanxinhao000/ZeroTermux](https://github.com/hanxinhao000/ZeroTermux/releases)下载 ZeroTermux 安装包并安装

- 注意事项： 
   直接从 GitHub 下载 ZeroTermux 速度可能会很慢，建议使用 [ghproxy.com](https://ghproxy.com) 代理
    
## 2. 安装 NapCat

### 2.1 使用恢复包安装

<details>
  <summary>点击展开内容！</summary>

#### 2.1.1 下载恢复包
前往 [Github releases](https://github.com/NapNeko/NapCat-Termux/releases) 下载 ZeroTermux 恢复包, 并将恢复包放在 手机的 `内部存储/xinhao/data/` 目录

- 注意事项： 
    - 恢复包要放在 `内部存储/xinhao/data/`目录或者 `/sdcard/xinhao/data`目录，否则在恢复容器的时候无法找到恢复包

#### 2.1.2 恢复容器
- 打开ZeroTermux
- 恢复
    进入ZeroTermux 点击音量上键 呼出菜单栏 点击菜单栏的 `备份/恢复` 选择下载的恢复包
    输入一个容器名字点击恢复 这个过程需要等待几分钟
- 切换容器
    再次点击音量上键， 呼出菜单栏，点击菜单栏的 `容器切换` 选择刚才创建的容器 询问你是否需要重启时， 选择立即重启，接下你将进入启动界面

- 注意事项：
    - 如果音量上键无法呼出菜单，说明你的ZeroTermux版本比较旧，可以使用右滑左侧的屏幕边缘来呼出菜单栏
</details>

### 2.2 使用一键脚本

如果你使用了2.1的方法，请不要执行该脚本
   ```shell
   bash -c "$(curl -L https://github.com/NapNeko/NapCat-Termux/raw/main/onekey.sh)"
   ```
### 3. 启动

```shell
# 启动
bash bookworm-arm64.sh
```

## 参考与基础
[NapNeko/NapCatQQ](https://github.com/NapNeko/NapCatQQ)

[yudezeng/yutools](https://gitee.com/yudezeng/yutools)
