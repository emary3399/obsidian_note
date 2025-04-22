
下面我给你一份**实用、通用、适合中小项目**的 **SQL 建表规范模板**，适用于 MySQL 和大部分兼容的关系型数据库，主要包括：

- 表命名规范
    
- 字段设计建议
    
- 约束使用建议（主键、唯一、非空、外键、检查等）
    
- 常见字段类型模板
    

---

## 🧱 SQL 建表规范模板（MySQL）

### ✅ 表命名规范

- 使用 **小写字母+下划线**（`snake_case`）
    
- 表名为**复数形式**，如 `users`、`orders`
    
- 表名需具有**语义明确性**，比如 `user_orders`、`product_reviews`
    

---

### ✅ 字段命名规范

- 主键一般为 `id` 或 `xxx_id`（如 `user_id`）
    
- 时间字段统一用 `created_at` / `updated_at`
    
- 布尔值字段用 `is_` 开头（如 `is_deleted`、`is_active`）
    

---

### ✅ 常用字段类型参考

|字段名|类型|含义|约束建议|
|---|---|---|---|
|`id`|INT UNSIGNED AUTO_INCREMENT|主键|PRIMARY KEY|
|`name`|VARCHAR(100)|名称|NOT NULL|
|`email`|VARCHAR(255)|邮箱地址|UNIQUE, NOT NULL|
|`password`|VARCHAR(255)|加密密码|NOT NULL|
|`created_at`|DATETIME|创建时间|DEFAULT CURRENT_TIMESTAMP|
|`updated_at`|DATETIME|更新时间|ON UPDATE CURRENT_TIMESTAMP|
|`is_deleted`|TINYINT(1)|是否逻辑删除|DEFAULT 0|

---

### ✅ 建表模板（含约束命名）

```sql
CREATE TABLE users (
  id INT UNSIGNED AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  is_deleted TINYINT(1) DEFAULT 0,

  CONSTRAINT pk_users PRIMARY KEY (id),
  CONSTRAINT uq_users_email UNIQUE (email),
  CONSTRAINT chk_users_is_deleted CHECK (is_deleted IN (0, 1))
);
```

---

### ✅ 外键约束模板

```sql
CREATE TABLE orders (
  id INT UNSIGNED AUTO_INCREMENT,
  user_id INT UNSIGNED NOT NULL,
  total_amount DECIMAL(10, 2) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT pk_orders PRIMARY KEY (id),
  CONSTRAINT fk_orders_user FOREIGN KEY (user_id)
    REFERENCES users(id)
    ON DELETE CASCADE
);
```

---

### 🚫 不推荐的写法

- 表名使用大写或驼峰（如 `UserInfo`）❌
    
- 用“中文”当字段名 ❌
    
- 没有设置主键 ❌
    
- 所有字段都可以为 NULL ❌
    
- 表中冗余字段太多，没有分表 ❌
    

---

## 🧠 加分项（进阶建议）

|项目|说明|
|---|---|
|索引优化|对常用查询字段加 `INDEX`（如 `email`, `created_at`）|
|分库分表|数据量大时进行拆分|
|逻辑删除|不直接物理删除数据，用 `is_deleted = 1` 表示|
|版本控制|表结构用 `.sql` 文件统一管理，加入 Git|
|表注释|用 `COMMENT` 说明字段含义，便于自动生成文档|
