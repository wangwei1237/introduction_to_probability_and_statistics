# Introduction to Probability and Statistics for Engineers and Scientists（中文版）

本项目是《Introduction to Probability and Statistics for Engineers and Scientists (Sixth Edition)》的中文翻译版本，由王伟（17哥）翻译。

## 项目概述
项目使用 **Quarto** 构建，这是一款开源的科学和技术出版系统。内容以 Quarto Markdown (`.qmd`) 编写，结构清晰，包含章节、附录和参考文献，主要通过 GitHub Pages 发布为 HTML 格式。

## 目录结构
- `_quarto.yml`: Quarto 书籍的核心配置文件，定义书籍结构、元数据和渲染选项。
- `index.qmd`: 书籍主页及引言。
- `preface.qmd`, `preface_17.qmd`: 前言部分。
- `chapter_1/` 到 `chapter_16/`: 各章节文件夹。
  - 每个文件夹包含一个主文件 `X.qmd`，通过 `{{< include ... >}}` 引用子章节文件（如 `X_1.qmd`, `X_2.qmd`）。
- `images/`: 存放书籍插图，按章节组织。
- `misc/`: 包含统计示例和练习所用的数据集（CSV 文件）。
- `references.bib`: BibTeX 格式的参考文献。
- `acm-sig-proceedings.csl`: 引文样式文件。
- `.github/workflows/`: GitHub Actions 工作流，用于自动化构建和部署。

## 构建与运行
若要在本地构建书籍，请遵循以下步骤：

1.  **安装 Quarto CLI**: 从 [quarto.org](https://quarto.org/docs/get-started/) 下载并安装。
2.  **安装 R 及其依赖**（执行代码块所需）:
    ```bash
    # 首先安装 R，然后在 R 中运行：
    install.packages(c("knitr", "rmarkdown", "ggplot2", "igraph", "latex2exp"))
    ```
3.  **安装 TinyTeX**（支持 PDF 渲染）:
    ```bash
    quarto install tinytex
    ```
4.  **渲染书籍**:
    ```bash
    quarto render
    ```
5.  **实时预览**:
    ```bash
    quarto preview
    ```

## 开发规范（翻译与排版约定）

### 1. 文件组织
- **章节主文件**：每个章节的主文件（如 `14.qmd`）的一级标题应翻译为中文，并保留锚点（如 `# 寿命测试 {#sec-14}`）。
- **小节标题层级**：在子章节文件（如 `14_2.qmd`）中，小节标题使用 `##`，更深层级依次递增。

### 2. 术语翻译
- **中英对照**：专业术语首次出现或定义时，使用 **中文加粗** 后接 (*英文斜体*) 括号标注。示例：**失效率函数**（*hazard rate function*）。
- **关键术语**：正文中提到的核心概念应使用加粗。

### 3. 交叉引用与锚点
- **标题锚点**：每个标题后需紧跟 ID 锚点，格式为 `{#sec-章节号_小节号}`。
- **公式锚点**：公式需编号，格式为 `{#eq-章节号_小节号_序号}`。
- **引用语法**：使用 `@sec-ID` 或 `@eq-ID` 进行自动交叉引用。

### 4. 示例与解答格式
- **专用块 ID**：示例（Example）和解答（Solution）必须包裹在 Quarto 自定义块中：
    - 示例：`::: {#exr-章节号_小节号_序号}`
    - 解答：`::: {#sol-章节号_小节号_序号}`

### 5. 数学公式与排版
- **推导环境**：复杂推导优先使用 `\begin{align} ... \end{align}`。
- **符号约定**：
    - 均值：`\overline{X}` 或 `\bar{x}`
    - 分布：`\sim`
    - 正态分布：`\mathcal{N}`
- **中西文间距**：中文与行内公式 `$ ... $` 之间应保持一个半角空格，以增强可读性。

### 6. 语言风格
- **语气**：保持严谨、客观的学术叙述风格。
- **标点**：正文使用全角中文标点；数学环境内使用西文标点。
