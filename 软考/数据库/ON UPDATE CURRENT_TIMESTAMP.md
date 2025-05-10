

```sql
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
```

确实是 **MySQL 的一个黑科技语法糖**，它的效果就是：

> ✅ **只要你更新了这行的任何一个字段，`updated_at` 会自动变成当前时间。**

---

## 🧠 原理说明：

在 MySQL 中，`ON UPDATE CURRENT_TIMESTAMP` 是一种**触发机制**，本质上是告诉数据库：

> “每次对这行进行 `UPDATE` 操作时，`updated_at` 字段自动更新为 `NOW()`。”

---

## ✅ 举个例子说明：

你有这样的表：

```sql
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

插入数据：

```sql
INSERT INTO users (name) VALUES ('小明');
```

你得到：

|id|name|updated_at|
|---|---|---|
|1|小明|2025-04-22 10:00:00|

然后你执行更新：

```sql
UPDATE users SET name = '小红' WHERE id = 1;
```

此时 `updated_at` 会变成执行更新时的时间，比如：

|id|name|updated_at|
|---|---|---|
|1|小红|2025-04-22 11:02:00|

---

## ⚠️ 注意事项：

### 1. 一个表中 **只能有一个字段使用 `ON UPDATE CURRENT_TIMESTAMP`**

如果你想对多个字段实现类似效果，需要使用 **触发器（TRIGGER）** 来实现。

### 2. 如果你没有更新任何字段（比如执行了一次空更新），`updated_at` 不会变。

但只要有字段值发生改变，`updated_at` 就会自动刷新。

---

## 🛠️ 如果你想多个字段一起更新怎么办？

可以考虑用 **触发器 TRIGGER** 实现更灵活的逻辑，比如：

```sql
CREATE TRIGGER update_timestamp
BEFORE UPDATE ON your_table
FOR EACH ROW
SET NEW.updated_at = NOW();
```

这个触发器每次执行 `UPDATE` 时，都会自动把 `updated_at` 更新成当前时间。

---

## ✅ 小结一句话：

> `ON UPDATE CURRENT_TIMESTAMP` 就像给字段加了一个“自带定时器”，任何值更新，它就自己记下“我最后被动过的时间”。
