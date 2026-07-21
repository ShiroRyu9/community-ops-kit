# Community Ops Kit

[English](README.md)

Community Ops Kit 是一套面向社区运营的开源 Agent Skills。它把宽泛的运营目标拆成用户分层、具体动作、执行阵地、证据、反馈循环、复盘决策和审批边界。

它可以用于 Codex，也可以用于支持开放 Agent Skills 格式的其他 AI 工具。

## 包含哪些能力

| Skill | 适用场景 |
|---|---|
| `community-ops-router` | 诊断综合问题并选择合适的执行 Skill |
| `community-ops-onboarding` | 新用户路径、首次动作、激活和分流 |
| `community-ops-activity` | 活动、投稿、投票、奖励、提醒和结果复盘 |
| `community-ops-creator-assets` | 创作者、UGC、精选内容、授权和内容资产 |
| `community-ops-paid-members` | 付费、高价值、VIP 用户和权益运营 |
| `community-ops-daily-report` | 日报、工作记录和负责人同步 |
| `community-ops-weekly-review` | 周复盘、数据缺口、决策和下周优先级 |
| `community-ops-automation-workflow` | 带人工确认的安全自动化流程 |
| `community-ops-support-risk` | 客服、审核、隐私、支付、权限和安全风险 |
| `community-ops-expression` | 公告、活动文案、报告和自然表达 |

## 工作闭环

```text
社区信号
-> 运营判断
-> 专项 Skill
-> 草稿或安全自动化
-> 必要时人工确认
-> 日报
-> 周复盘
-> 更新工作流
```

## 安装

跨 Agent 安装：

```bash
npx skills add lyh974976711-del/community-ops-kit
```

Codex Plugin：

```bash
codex plugin marketplace add lyh974976711-del/community-ops-kit
```

然后在 Codex 中运行 `/plugins`，安装 **Community Ops Kit**，并开启一个新任务。

## 直接开始

```text
使用 community-ops-router 分析为什么新成员加入后没有完成首次动作，并给出最小改动、需要收集的证据和审批边界。
```

```text
使用 community-ops-activity 设计一个为期七天的创作者活动，包含投稿格式、提醒节奏、精选方式和复盘指标。
```

```text
使用 community-ops-weekly-review 把这些运营记录整理成已确认动作、用户信号、风险、待决策事项和下周优先级。
```

更多完整输入和预期输出见 [examples](examples/)。

## 安全边界

Skill 可以整理证据、生成草稿、比较方案、计算数据和准备检查表。公开发布、私信、用户提及、奖励、折扣、付费权益承诺、获奖名单、权限修改、机器人或 Webhook 修改、删除和官方声明需要人工明确确认。

## 验证

```bash
ruby scripts/validate.rb
```

## 许可证

Apache License 2.0，详见 [LICENSE](LICENSE)。
