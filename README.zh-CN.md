# Community Ops Kit

[English](README.md)

Community Ops Kit 是一套面向社区运营的开源 Agent Skills。它把宽泛的运营目标拆成用户分层、具体动作、执行阵地、证据、反馈循环、复盘决策和审批边界。

它可以用于 Codex，也可以用于支持开放 Agent Skills 格式的其他 AI 工具。

## 不知道用哪个 Skill 时

把现有记录直接交给 Router，不需要先整理，也不需要记住 10 个 Skill 的名字：

```text
使用 community-ops-router 阅读下面的社区记录。先区分已确认事实、假设、数据缺口和待审批事项，再找出当前最主要的问题，调用需要的专项 Skill，并给出本周可以执行的最小动作和复盘方式。

[粘贴聊天摘要、活动记录、用户反馈、数据或工作笔记]
```

查看从杂乱记录到运营决策的完整过程：[端到端工作示例](examples/end-to-end-operating-loop.md)。

## 这套方法如何判断

1. **先看证据**：把事实、假设、数据缺口和待审批事项分开。
2. **先找主问题**：定位用户路径中最影响下一步行动的位置。
3. **先做最小动作**：选择本周能执行、能观察结果的改动。
4. **每个阵地只承担明确任务**：入口负责引导，活动页负责参与，报告负责决策。
5. **自动化保留边界**：收集、整理、提醒草稿和检查可以自动化；发送提醒等外部动作需要人工确认。
6. **让每个动作都能复盘**：提前定义证据、检查时间、负责人和下一步决策。

完整的决策问题、常见误区和输出检查见 [Operating Principles](skills/community-ops-router/references/operating-principles.md)。

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
npx skills add ShiroRyu9/community-ops-kit
```

Codex Plugin：

```bash
codex plugin marketplace add ShiroRyu9/community-ops-kit
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

更多输入和预期输出见 [examples](examples/)。其中 [端到端工作示例](examples/end-to-end-operating-loop.md) 展示了 Router 如何协调多个 Skill 完成一轮实际运营。

## 安全边界

Skill 可以整理证据、生成草稿、比较方案、计算数据和准备检查表。公开发布、私信、用户提及、奖励、折扣、付费权益承诺、获奖名单、权限修改、机器人或 Webhook 修改、删除和官方声明需要人工明确确认。

## 验证

```bash
ruby scripts/validate.rb
```

## 许可证

Apache License 2.0，详见 [LICENSE](LICENSE)。
