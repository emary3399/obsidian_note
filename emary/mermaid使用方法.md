# Mermaid学习笔记


## 1. 使用和部署Mermaid


### 1.1 部署方式


Mermaid有四种使用方式：


1. 使用Mermaid网页版编辑器
2. 在常用程序中使用Mermaid插件
3. 调用Mermaid的JavaScript API
4. 将Mermaid部署为依赖项


#### 1.1.1 网页版编辑器
地址：[mermaid-live-editor](https://mermaid-js.github.io/mermaid-live-editor)
```mermaid
graph TD
A[Client] --> B[Load Balancer]
B --> C[Server1]
B --> D[Server2]

Markdown







1.1.2 JavaScript API调用
<!DOCTYPE html>
<html>
<body>
  <div class="mermaid">
    graph TD
    A-->B
  </div>
  <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
  <script>mermaid.initialize({startOnLoad:true});</script>
</body>
</html>

HTML







1.2 基础配置
1.2.1 主题设置
%%{init: {'theme':'forest'}}%%
graph TD
A[默认主题] --> B[森林主题]

JavaScript







2. 绘图语法
2.1 流程图
基本结构
graph LR
A[方形] --> B(圆角)
B --> C{菱形}
C --> D[[子程序]]

Mermaid







方向控制
graph BT
A --> B
B --> C

Mermaid







2.2 时序图
基本语法
sequenceDiagram
Alice->>John: Hello John!
John-->>Alice: Hi Alice!

Mermaid







循环和条件
sequenceDiagram
loop 每天
    Alice->>John: 吃了吗？
    alt 没吃
        John->>Alice: 一起吃饭？
    else 吃了
        John->>Alice: 下次约！
    end
end

Mermaid







2.3 状态图
基本状态转换
stateDiagram-v2
[*] --> Still
Still --> Moving
Moving --> Still
Moving --> Crash
Crash --> [*]

Mermaid







2.4 甘特图
项目计划示例
gantt
title 项目计划
dateFormat YYYY-MM-DD
section 阶段1
需求分析 :done, des1, 2023-01-01, 7d
系统设计 :active, des2, 2023-01-08, 5d
section 阶段2
开发实现 : des3, 2023-01-15, 10d
测试验收 : des4, after des3, 5d

Mermaid







3. 高级功能
3.1 字体图标支持
graph TD
B["fa:fa-twitter 推特图标"]
B-->D(fa:fa-spinner)

Mermaid







3.2 子图嵌套
flowchart TB
subgraph 主系统
A[客户端] --> B[负载均衡]
end
subgraph 集群
B --> C[服务器1]
B --> D[服务器2]
end

Mermaid







4. 配置参考
4.1 主题配置表
主题名称

效果描述

default

默认蓝白主题

forest

森林绿主题

dark

暗黑模式

neutral

中性灰主题


4.2 常用箭头类型
graph LR
A-->B[实线箭头]
A---B[无箭头]
A-.->B[虚线箭头]
A==>B[粗箭头]

Mermaid







提示：本文档所有图表均使用Mermaid 9.1.3版本验证通过，建议使用最新版本以获得最佳兼容性。




Plain Text









