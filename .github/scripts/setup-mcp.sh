#!/bin/bash
# .github/scripts/setup-mcp.sh

echo "🔧 Setting up MCP servers..."

# MCPディレクトリ作成
mkdir -p ~/.config/claude

# MCP設定ファイル作成
cat > ~/.config/claude/claude_desktop_config.json << 'EOF'
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "${GITHUB_WORKSPACE}"]
    },
    "brave-search": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-brave-search"],
      "env": {
        "BRAVE_API_KEY": "${BRAVE_API_KEY}"
      }
    },
    "sqlite": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sqlite", 
               "--db-path", "${GITHUB_WORKSPACE}/dev.db"]
    },
    "notion": {
      "command": "npx",
      "args": ["@notionhq/mcp-server-notion"],
      "env": {
        "NOTION_API_KEY": "${NOTION_API_KEY}"
      }
    },
    "stripe": {
      "command": "npx",
      "args": ["mcp-server-stripe"],
      "env": {
        "STRIPE_API_KEY": "${STRIPE_API_KEY}"
      }
    }
  }
}
EOF

# MCPサーバーインストール
npm install -g @modelcontextprotocol/server-filesystem
npm install -g @modelcontextprotocol/server-brave-search
npm install -g @modelcontextprotocol/server-sqlite
npm install -g @notionhq/mcp-server-notion
npm install -g mcp-server-stripe

echo "✅ MCP setup complete!"
