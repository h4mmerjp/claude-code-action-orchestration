#!/bin/bash
# .github/scripts/validate-workflow.sh

set -e

echo "🔍 Validating Claude Development Workflow"
echo "=========================================="
echo ""

# カラー定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# カウンター
total_checks=0
passed_checks=0
failed_checks=0

# チェック関数
check() {
    local name="$1"
    local command="$2"
    
    total_checks=$((total_checks + 1))
    echo -n "Checking $name... "
    
    if eval "$command" > /dev/null 2>&1; then
        echo -e "${GREEN}✓ PASS${NC}"
        passed_checks=$((passed_checks + 1))
        return 0
    else
        echo -e "${RED}✗ FAIL${NC}"
        failed_checks=$((failed_checks + 1))
        return 1
    fi
}

# ファイル存在チェック
echo "📁 Checking Workflow Files..."
echo "----------------------------"

check "Main workflow exists" "test -f .github/workflows/claude-dev-orchestration.yml"
check "Review workflow exists" "test -f .github/workflows/claude-code-review.yml"
check "Monitoring workflow exists" "test -f .github/workflows/claude-monitoring.yml"
check "Auth setup workflow exists" "test -f .github/workflows/setup-claude-auth.yml"

echo ""
echo "📋 Checking Issue Templates..."
echo "----------------------------"

check "Fullstack template exists" "test -f .github/ISSUE_TEMPLATE/claude-fullstack-dev.md"
check "Bug fix template exists" "test -f .github/ISSUE_TEMPLATE/claude-bug-fix.md"
check "Feature template exists" "test -f .github/ISSUE_TEMPLATE/claude-feature-request.md"

echo ""
echo "📝 Checking PR Template..."
echo "----------------------------"

check "PR template exists" "test -f .github/PULL_REQUEST_TEMPLATE/claude-generated-pr.md"

echo ""
echo "🔧 Checking Scripts..."
echo "----------------------------"

check "MCP setup script exists" "test -f .github/scripts/setup-mcp.sh"
check "Usage monitor script exists" "test -f .github/scripts/monitor-claude-usage.sh"
check "Loop prevention test exists" "test -f .github/scripts/test-loop-prevention.sh"
check "Validation script exists" "test -f .github/scripts/validate-workflow.sh"

# スクリプト実行権限チェック
check "MCP setup is executable" "test -x .github/scripts/setup-mcp.sh"
check "Monitor script is executable" "test -x .github/scripts/monitor-claude-usage.sh"
check "Test script is executable" "test -x .github/scripts/test-loop-prevention.sh"

echo ""
echo "⚙️  Checking Config Files..."
echo "----------------------------"

check "MCP config exists" "test -f .github/config/mcp-config.json"
check "Claude config exists" "test -f .github/config/claude-config.json"

# JSON妥当性チェック
if [ -f .github/config/mcp-config.json ]; then
    check "MCP config is valid JSON" "jq empty .github/config/mcp-config.json"
fi

if [ -f .github/config/claude-config.json ]; then
    check "Claude config is valid JSON" "jq empty .github/config/claude-config.json"
fi

echo ""
echo "📚 Checking Documentation..."
echo "----------------------------"

check "Setup guide exists" "test -f docs/CLAUDE_SETUP.md"
check "Workflow guide exists" "test -f docs/WORKFLOW_GUIDE.md"
check "Troubleshooting guide exists" "test -f docs/TROUBLESHOOTING.md"
check "Cost optimization guide exists" "test -f docs/COST_OPTIMIZATION.md"
check "Main README exists" "test -f README.md"

echo ""
echo "🔍 Validating Workflow Syntax..."
echo "----------------------------"

# GitHub Actions 構文検証（actionlintが利用可能な場合）
if command -v actionlint &> /dev/null; then
    check "Main workflow syntax" "actionlint .github/workflows/claude-dev-orchestration.yml"
    check "Review workflow syntax" "actionlint .github/workflows/claude-code-review.yml"
    check "Monitoring workflow syntax" "actionlint .github/workflows/claude-monitoring.yml"
else
    echo -e "${YELLOW}⚠ actionlint not installed, skipping syntax validation${NC}"
    echo "  Install: brew install actionlint"
fi

echo ""
echo "🛡️  Checking Loop Prevention..."
echo "----------------------------"

# ループ防止機構の確認
if grep -q "validate-trigger" .github/workflows/claude-dev-orchestration.yml; then
    check "Loop prevention job exists" "true"
else
    check "Loop prevention job exists" "false"
fi

if grep -q "CLAUDE-BOT-COMMENT" .github/workflows/claude-dev-orchestration.yml; then
    check "Bot comment marker present" "true"
else
    check "Bot comment marker present" "false"
fi

if grep -q "github-actions\[bot\]" .github/workflows/claude-dev-orchestration.yml; then
    check "Bot user detection present" "true"
else
    check "Bot user detection present" "false"
fi

echo ""
echo "📊 Validation Summary"
echo "=========================================="
echo "Total Checks: $total_checks"
echo -e "Passed: ${GREEN}$passed_checks${NC}"
echo -e "Failed: ${RED}$failed_checks${NC}"
echo ""

if [ $failed_checks -eq 0 ]; then
    echo -e "${GREEN}✅ All validation checks passed!${NC}"
    echo ""
    echo "🚀 Your Claude Development Orchestration is ready to use!"
    echo ""
    echo "Next steps:"
    echo "  1. Configure GitHub Secrets (CLAUDE_SESSION_TOKEN)"
    echo "  2. Create a test issue with 'claude-dev' label"
    echo "  3. Watch the magic happen! ✨"
    exit 0
else
    echo -e "${RED}❌ Some validation checks failed${NC}"
    echo ""
    echo "Please fix the issues above and run validation again."
    echo ""
    echo "For help, see: docs/TROUBLESHOOTING.md"
    exit 1
fi
