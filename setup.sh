#!/bin/bash
# ============================================================
#  Claude Code 기본 환경 세팅 스크립트
#
#  하는 일:
#    1) ~/.claude/skills 심링크 생성 (이 레포의 claude/skills 가리킴)
#    2) 이후 수동으로 실행해야 할 명령어들을 안내 출력
#
#  사용법:
#    git clone https://github.com/<your-username>/claude-dotfiles.git ~/claude-dotfiles
#    cd ~/claude-dotfiles && chmod +x setup.sh && ./setup.sh
# ============================================================

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
EXCALIDRAW_DIR="$DOTFILES_DIR/claude/skills/excalidraw-diagram/references"

echo "========================================"
echo "  Claude Code 환경 세팅 시작"
echo "========================================"
echo ""

# --------------------------------------------------------
# 1. ~/.claude 디렉토리 확인
# --------------------------------------------------------
if [ ! -d "$CLAUDE_DIR" ]; then
    echo "📁 ~/.claude 디렉토리 생성..."
    mkdir -p "$CLAUDE_DIR"
fi

# --------------------------------------------------------
# 2. 기존 skills 백업 (있을 경우)
# --------------------------------------------------------
if [ -d "$CLAUDE_DIR/skills" ] && [ ! -L "$CLAUDE_DIR/skills" ]; then
    BACKUP_NAME="skills.backup.$(date +%Y%m%d_%H%M%S)"
    echo "⚠️  기존 skills 디렉토리 발견 → $BACKUP_NAME 으로 백업"
    mv "$CLAUDE_DIR/skills" "$CLAUDE_DIR/$BACKUP_NAME"
fi

# --------------------------------------------------------
# 3. skills 심링크
# --------------------------------------------------------
echo "🔗 skills 심링크 생성..."
ln -sfn "$DOTFILES_DIR/claude/skills" "$CLAUDE_DIR/skills"
echo "   $CLAUDE_DIR/skills → $DOTFILES_DIR/claude/skills"
echo ""

# --------------------------------------------------------
# 4. 설치된 스킬 목록
# --------------------------------------------------------
echo "========================================"
echo "  ✅ 심링크 세팅 완료"
echo "========================================"
echo ""
echo "설치된 스킬:"
ls -1 "$CLAUDE_DIR/skills/" 2>/dev/null | while read skill; do
    echo "  • $skill"
done
echo ""

# --------------------------------------------------------
# 5. 수동 설치 가이드 (Excalidraw 렌더러 의존성)
# --------------------------------------------------------
echo "========================================"
echo "  📦 다음 단계 — 수동으로 진행하세요"
echo "========================================"
echo ""
echo "▶ [1/3] uv 설치 (없을 경우)"
echo ""
echo "    curl -LsSf https://astral.sh/uv/install.sh | sh"
echo "    source \$HOME/.local/bin/env   # 또는 새 셸 열기"
echo ""
echo "▶ [2/3] Excalidraw 렌더러 의존성 (playwright 등) 설치"
echo ""
echo "    cd $EXCALIDRAW_DIR"
echo "    uv sync"
echo "    uv run playwright install chromium"
echo ""
echo "▶ [3/3] Claude Code 세션에서 플러그인 설치"
echo ""
echo "    /plugin marketplace add multica-ai/andrej-karpathy-skills"
echo "    /plugin install karpathy-guidelines@multica-ai/andrej-karpathy-skills --scope user"
echo "    /plugin install skill-creator@claude-plugins-official --scope user"
echo "    /reload-plugins"
echo ""
echo "========================================"
echo "  Done! 🚀"
echo "========================================"
