#!/bin/bash
# .github/scripts/test-loop-prevention.sh

echo "🧪 Testing Loop Prevention Mechanism"
echo "====================================="
echo ""

test_count=0
pass_count=0

run_test() {
  local name="$1"
  local input="$2"
  local expected="$3"
  
  test_count=$((test_count + 1))
  echo "Test $test_count: $name"
  
  result=$(echo "$input" | jq -r "$expected")
  
  if [ "$result" = "PASS" ]; then
    pass_count=$((pass_count + 1))
    echo "✅ PASS"
  else
    echo "❌ FAIL"
  fi
  echo ""
}

# テスト1: ユーザーコメント with /claude-build
run_test "User command" \
  '{"comment": {"user": {"login": "testuser"}, "body": "/claude-build test"}}' \
  'if .comment.user.login != "github-actions[bot]" and (.comment.body | contains("/claude-build")) then "PASS" else "FAIL" end'

# テスト2: ボットコメント
run_test "Bot comment" \
  '{"comment": {"user": {"login": "github-actions[bot]"}, "body": "Complete"}}' \
  'if .comment.user.login == "github-actions[bot]" then "PASS" else "FAIL" end'

# テスト3: ボット識別子
run_test "Bot signature" \
  '{"comment": {"user": {"login": "user"}, "body": "<!-- CLAUDE-BOT-COMMENT --> test"}}' \
  'if (.comment.body | contains("<!-- CLAUDE-BOT-COMMENT -->")) then "PASS" else "FAIL" end'

# テスト4: 通常コメント
run_test "Normal comment" \
  '{"comment": {"user": {"login": "user"}, "body": "Thanks!"}}' \
  'if .comment.user.login != "github-actions[bot]" and (.comment.body | contains("/claude-build") | not) then "PASS" else "FAIL" end'

echo "====================================="
echo "Results: $pass_count/$test_count tests passed"

if [ $pass_count -eq $test_count ]; then
  echo "✅ All tests passed!"
  exit 0
else
  echo "❌ Some tests failed"
  exit 1
fi
