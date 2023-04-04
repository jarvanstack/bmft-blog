# 准备

* [借势-站在巨人的肩膀上](borrow.md): 科学上网, GhatGPT, Copilot
* [博客](blog.md): 
* [算法](algorithm.md)
* [环境搭建](env.md): Linux, go, git, wsl
* [如何提问](how-to-ask-questions.md): 不要随便提问, 正确的提问方式

## 任务

* 准备: 科学上网, GhatGPT, Copilot
* 环境搭建: Linux, go, git, wsl
* [持续] 日报: 每天写一份日报, 记录今天做了什么和明天的安排
* [持续] leetcode: 每天 2 篇, 并且将自己的思路和各种解法记录到博客中

## 如何入门刷 leetcode


* 推荐直接看 [剑指offer](https://weread.qq.com/web/bookDetail/1f132a805a61751f1674656) 这本书, 比较系统和基础, 然后在 leetcode 上刷题
* 80%的时间思考, 20%的时间代码. **思路的重要性远远大于代码**, (搬砖写代码你写的过 AI 么?)
* 一定要一题多解: (因为题的数量不是我们的目的, 目的一定是抽象逻辑能力的培养)
  * 看完题目, 自己想解法, 越多越好
  * 然后继续看书, 书上有优化方案
  * 然后看 leetcode 评论和题解, 看看有没有其他解法
* 写博客: 每个解法除了代码都要写下, **思路, 时间复杂度, 空间复杂度**


## 如何写日报?

* 今天做了什么
* 明天做了什么

反例

```md
今天: 刷题2, 总结: git 环境搭建
明天: 刷题2, golang 环境搭建
```

正例:

```md
今天
* 刷题, 二叉树的镜像, [博客连接]()
* 刷题, 二叉树的最大深度, [博客连接]()
* 总结: git 环境搭建, [博客连接]()
* 问题和解决: git push 提示 `fatal: unable to access ', [博客连接]()
明天
* 刷题 2 道
* golang 环境搭建
```

## 如何写问题和解决?

**要展现你思考的过程**

例如, 报错: git push 提示 `fatal: unable to access '

你是怎样思考的(如果有的话)

你尝试了什么

如果没有解决你搜索的结果是什么 (去 Google 中文搜不出来英文搜索, 问 ChatGPT, 问 NewBing) 

总结搜索结果和问题的原因

尝试的解决方案

最后解决

复盘这次的问题, 以后遇到类似的问题怎么解决

反例:

```md
问题: git push 提示 `fatal: unable to access '
解决: git config --global credential.helper store
```

正例:

> 参考: [如何提问](how-to-ask-questions.md)

