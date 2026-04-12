#!/bin/bash
set -euo pipefail

# --------------------------
# 1. 读取钩子输入（JSON from stdin）
# --------------------------
HOOK_INPUT=$(cat)
TOOL_NAME=$(echo "$HOOK_INPUT" | jq -r '.tool_name')
FILE_PATH=$(echo "$HOOK_INPUT" | jq -r '.tool_input.file_path')
CONTENT=$(echo "$HOOK_INPUT" | jq -r '.tool_input.content // empty')
#FILE_PATH="/Users/wangwei17/Documents/Project/github/introduction_to_probability_and_statistics/chapter_14/14_5.qmd"
# 只处理文件编辑工具
if [[ ! "$TOOL_NAME" =~ ^(write_file|replace)$ ]]; then
  exit 0
fi

# 检查文件存在
if [[ ! -f "$FILE_PATH" ]]; then
  echo "⚠️  Hook: File $FILE_PATH not found"
  exit 0
fi

# --------------------------
# 2. 定义检测模型与提示词（可自定义）
# --------------------------
# 模型列表：可增删，每个模型独立检测
DETECT_MODELS=(
  "gemini-3-flash-preview"
)

# 检测提示词（可按语言/规范修改）
PROMPT="请严格检测翻译内容是否符合规范，给出明确修复建议，只输出检测结果，不要重写内容。
文件路径：$FILE_PATH
翻译内容：
$(cat "$FILE_PATH")"

# --------------------------
# 3. 遍历模型，执行检测（串行/并行）
# --------------------------
echo -e "\n=== Gemini Auto-Validation for: $FILE_PATH ===" >&2
for MODEL in "${DETECT_MODELS[@]}"; do
  echo -e "\n--- Model: $MODEL ---" >&2
  # 调用Gemini CLI，指定模型，传入提示词
  gemini \
    --model "$MODEL" \
    "$PROMPT" >&2
  echo "----------------------------------------" >&2
done

# 可选：检测失败时退出非0，阻断Gemini继续操作
# if [ $FAIL_COUNT -gt 0 ]; then exit 1; fi

exit 0