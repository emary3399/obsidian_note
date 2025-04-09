在 Obsidian 中，**Callout** 是一种用于突出显示内容的语法，支持多种类型。以下是 Obsidian 中所有默认的 Callout 类型及其用法：

---

### **1. 基本语法**
Callout 的基本语法格式如下：
```markdown
> [!类型] 标题
> 内容
```
- `类型`：指定 Callout 的类型（如 `note`、`warning` 等）。
- `标题`：可选项，用于为 Callout 添加标题。
- `内容`：Callout 中显示的具体内容。

---

### **2. 默认 Callout 类型**
以下是 Obsidian 中所有默认支持的 Callout 类型：

#### **1. note**
```markdown
> [!note] 这是一个 Note
> 这是 Note 的内容。
```

#### **2. abstract**
```markdown
> [!abstract] 这是一个 Abstract
> 这是 Abstract 的内容。
```

#### **3. summary**
```markdown
> [!summary] 这是一个 Summary
> 这是 Summary 的内容。
```

#### **4. tldr**
```markdown
> [!tldr] 这是一个 TL;DR
> 这是 TL;DR 的内容。
```

#### **5. info**
```markdown
> [!info] 这是一个 Info
> 这是 Info 的内容。
```

#### **6. todo**
```markdown
> [!todo] 这是一个 Todo
> 这是 Todo 的内容。
```

#### **7. tip**
```markdown
> [!tip] 这是一个 Tip
> 这是 Tip 的内容。
```

#### **8. hint**
```markdown
> [!hint] 这是一个 Hint
> 这是 Hint 的内容。
```

#### **9. important**
```markdown
> [!important] 这是一个 Important
> 这是 Important 的内容。
```

#### **10. success**
```markdown
> [!success] 这是一个 Success
> 这是 Success 的内容。
```

#### **11. check**
```markdown
> [!check] 这是一个 Check
> 这是 Check 的内容。
```

#### **12. done**
```markdown
> [!done] 这是一个 Done
> 这是 Done 的内容。
```

#### **13. question**
```markdown
> [!question] 这是一个 Question
> 这是 Question 的内容。
```

#### **14. help**
```markdown
> [!help] 这是一个 Help
> 这是 Help 的内容。
```

#### **15. faq**
```markdown
> [!faq] 这是一个 FAQ
> 这是 FAQ 的内容。
```

#### **16. warning**
```markdown
> [!warning] 这是一个 Warning
> 这是 Warning 的内容。
```

#### **17. caution**
```markdown
> [!caution] 这是一个 Caution
> 这是 Caution 的内容。
```

#### **18. attention**
```markdown
> [!attention] 这是一个 Attention
> 这是 Attention 的内容。
```

#### **19. failure**
```markdown
> [!failure] 这是一个 Failure
> 这是 Failure 的内容。
```

#### **20. fail**
```markdown
> [!fail] 这是一个 Fail
> 这是 Fail 的内容。
```

#### **21. missing**
```markdown
> [!missing] 这是一个 Missing
> 这是 Missing 的内容。
```

#### **22. danger**
```markdown
> [!danger] 这是一个 Danger
> 这是 Danger 的内容。
```

#### **23. error**
```markdown
> [!error] 这是一个 Error
> 这是 Error 的内容。
```

#### **24. bug**
```markdown
> [!bug] 这是一个 Bug
> 这是 Bug 的内容。
```

#### **25. example**
```markdown
> [!example] 这是一个 Example
> 这是 Example 的内容。
```

#### **26. quote**
```markdown
> [!quote] 这是一个 Quote
> 这是 Quote 的内容。
```

---

### **3. 自定义 Callout 类型**
如果默认类型不满足需求，可以通过 CSS 自定义 Callout 类型。例如：
```css
.callout[data-callout="custom"] {
    background-color: #f0f8ff;
    border-color: #1e90ff;
}
```
然后在 Markdown 中使用：
```markdown
> [!custom] 这是一个自定义 Callout
> 这是自定义 Callout 的内容。
```
