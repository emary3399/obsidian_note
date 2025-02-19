以下是整理后的Obsidian笔记，每个Mermaid示例都包含可复制的代码块和渲染后的图例说明：

# Mermaid 学习笔记

## 目录
- [1. 使用和部署](#1-使用和部署)
- [2. 基础配置](#2-基础配置)
- [3. 绘图语法](#3-绘图语法)

---

## 1. 使用和部署

### 1.1 部署方式
1. **网页版编辑器**  
   地址：[mermaid-live-editor](https://mermaid-js.github.io/mermaid-live-editor)

2. **插件方式**  
   支持VS Code、JetBrains等IDE插件

3. **JavaScript API**  
   ```html
   <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
   <script>mermaid.initialize({ startOnLoad: true });</script>
4.依赖项部署
npm install -g yarn
yarn add mermaid
2. 基础配置
2.1 主题配置
%%{init: {'theme':'forest'}}%%
flowchart LR
    A --> B
3. 绘图语法
3.1 流程图 (Flowcharts)
基础语法
flowchart LR
    A[Start] --> B{Decision}
    B -->|Yes| C[Action]
    B -->|No| D[End]
节点形状示例
flowchart LR
    A[(数据库)] --> B{{菱形}}
    C[/斜边矩形/] --> D[普通矩形]
    E((圆形)) --> F>非对称]
子图示例
flowchart TB
    subgraph 集群
        A --> B
    end
    C --> 集群
3.2 时序图 (Sequence Diagrams)
基础示例
sequenceDiagram
    Alice->>John: Hello John!
    John-->>Alice: Hi Alice!
循环和条件
sequenceDiagram
    loop 每日检查
        Alice->>John: 状态正常？
        alt 是
            John-->>Alice: 一切正常
        else 否
            John-->>Alice: 需要维护
        end
    end
3.3 状态图 (State Diagrams)
基础示例
stateDiagram-v2
    [*] --> 待机
    待机 --> 运行中: 启动
    运行中 --> 待机: 停止
    运行中 --> 故障
    故障 --> [*]
3.4 用户历程图 (User Journey)
示例
journey
    title 用户购物流程
    section 浏览
      用户浏览商品: 5: 用户
    section 购买
      添加购物车: 4: 用户
      完成支付: 3: 用户,支付系统
3.5 甘特图 (Gantt)
示例
gantt
    title 项目计划
    dateFormat YYYY-MM-DD
    section 阶段A
    需求分析 :a1, 2023-01-01, 10d
    section 阶段B
    开发 :2023-01-11, 15d
提示：在Obsidian中：

1.直接粘贴代码块即可渲染图表
2.使用 ```mermaid代码块语法
3.按Ctrl+Enter强制刷新图表

---

## 注意事项
1. 所有代码块均可直接复制到Obsidian中使用
2. 若图表未渲染，检查是否安装Mermaid插件
3. 复杂图表建议先在[在线编辑器](https://mermaid.live)测试