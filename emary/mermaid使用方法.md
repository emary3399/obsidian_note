# Mermaid 使用笔记

Mermaid 是一个基于 JavaScript 的图表绘制工具，支持在 Markdown 文件中嵌入各种图表。以下是一些常用的 Mermaid 图表及其语法示例：

## 流程图

```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```

## 序列图

```mermaid
sequenceDiagram
    participant Alice
    participant Bob
    Alice->>Bob: Hello Bob, how are you?
    Bob-->>Alice: I am good, thanks!
```

## 类图

```mermaid
classDiagram
    class Animal {
        +String name
        +int age
        +void eat()
    }
    class Dog {
        +String breed
        +void bark()
    }
    Animal <|-- Dog
```

## 状态图

```mermaid
stateDiagram
    [*] --> State1
    State1 --> State2
    State2 --> [*]
```

## 甘特图

```mermaid
gantt
    title 项目计划
    dateFormat  YYYY-MM-DD

    section 设计
    研究       :a1, 2025-02-19, 3d
    草图       :after a1, 2d

    section 开发
    编码       :2025-02-24, 5d
    测试       :2025-03-01, 3d
```

## 饼图

```mermaid
pie
    title 饼图示例
    "苹果" : 40
    "香蕉" : 20
    "橙子" : 30
    "梨" : 10
```

## Markdown 中使用 Mermaid

在 Markdown 文件中使用 Mermaid，只需要使用代码块语法，并将代码块的语言标识为 `mermaid`。例如：

    ```mermaid
    graph TD;
        A-->B;
        A-->C;
        B-->D;
        C-->D;
    ```

希望这些示例能帮助你快速上手 Mermaid 的使用。