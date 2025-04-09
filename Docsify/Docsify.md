## 一、自动生成 `_sidebar.md` 文件的方法

用一个小脚本来**扫描你的 Obsidian 文件夹目录结构，自动生成 `_sidebar.md` 文件**。
### 🚗 安装步骤：

#### 1. 安装 Node.js（如果还没装）

去官网下载安装：[https://nodejs.org](https://nodejs.org)

#### 2. 安装 `docsify-auto-sidebar` 工具

```
npm install -g docsify-auto-sidebar
```

#### 3. 在项目根目录运行：

```
docsify-auto-sidebar -d . -o _sidebar.md
```


这个命令会把你整个文件夹的结构读取出来，生成 `_sidebar.md`，并保持 Obsidian 的风格（目录树样式）。