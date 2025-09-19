# HealthApp4 Git 使用指南

## 目录
1. [基本Git操作](#基本git操作)
2. [分支管理](#分支管理)
3. [版本管理](#版本管理)
4. [最佳实践](#最佳实践)

## 基本Git操作

### 日常开发流程
1. 获取最新代码
```bash
git pull origin main
```

2. 查看当前状态
```bash
git status
```

3. 添加修改的文件
```bash
# 添加特定文件
git add 文件名

# 添加所有修改
git add .
```

4. 提交修改
```bash
git commit -m "描述你的修改"
```

5. 推送到远程仓库
```bash
git push origin main
```

### 常用Git命令
- 查看提交历史：`git log`
- 查看特定文件的修改历史：`git log -p 文件名`
- 撤销未提交的修改：`git checkout -- 文件名`
- 撤销最后一次提交：`git reset HEAD~1`
- 查看远程仓库信息：`git remote -v`

## 分支管理

### 分支命名规范
- 主分支：`main`
- 功能分支：`feature/功能名称`
- 修复分支：`bugfix/问题描述`
- 发布分支：`release/版本号`

### 分支操作
1. 创建新分支
```bash
git checkout -b feature/新功能名称
```

2. 切换分支
```bash
git checkout 分支名称
```

3. 合并分支
```bash
# 切换到目标分支
git checkout main
# 合并功能分支
git merge feature/新功能名称
```

4. 删除分支
```bash
# 删除本地分支
git branch -d 分支名称
# 删除远程分支
git push origin --delete 分支名称
```

## 版本管理

### 版本号规则
- 主版本号(major)：不兼容的API修改
- 次版本号(minor)：向下兼容的功能性新增
- 修订号(patch)：向下兼容的问题修复

### 使用版本管理脚本
1. 更新主版本号（不兼容的改动）
```bash
./scripts/bump_version.sh major
```

2. 更新次版本号（新功能）
```bash
./scripts/bump_version.sh minor
```

3. 更新修订号（bug修复）
```bash
./scripts/bump_version.sh patch
```

4. 推送版本更新
```bash
git push && git push --tags
```

### 版本标签管理
- 查看所有标签：`git tag`
- 查看特定标签信息：`git show v1.0.0`
- 切换到特定版本：`git checkout v1.0.0`

## 最佳实践

### 提交信息规范
提交信息格式：
```
类型: 简短描述

详细描述（可选）
```

类型包括：
- feat: 新功能
- fix: 修复bug
- docs: 文档更新
- style: 代码格式修改
- refactor: 代码重构
- test: 测试用例修改
- chore: 构建过程或辅助工具的变动

示例：
```bash
git commit -m "feat: 添加用户登录功能

- 实现用户名密码登录
- 添加登录界面UI
- 集成用户认证服务"
```

### 开发流程建议
1. 始终从最新的main分支创建功能分支
2. 经常性地提交代码，保持提交粒度适中
3. 在合并到main分支前进行代码审查
4. 定期推送到远程仓库作为备份
5. 重要功能完成后及时更新版本号

### 常见问题解决
1. 合并冲突
```bash
# 解决冲突后
git add .
git commit -m "fix: 解决合并冲突"
```

2. 撤销错误的合并
```bash
git reset --hard HEAD~1
```

3. 临时保存工作区
```bash
# 保存当前修改
git stash
# 恢复之前的修改
git stash pop
```

## 注意事项
1. 不要提交敏感信息（密码、密钥等）
2. 保持提交信息清晰明确
3. 定期清理不需要的分支
4. 重要操作前先备份
5. 不要强制推送到主分支 