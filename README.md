# Claude Code Dotfiles

개인 Claude Code 환경 설정 (스킬 + 플러그인).  
새 디바이스에서 동일한 환경을 빠르게 재현하기 위한 레포.

## 구성 요약

| 구분 | 항목 | 설치 방식 |
|------|------|-----------|
| **스킬** | excalidraw-diagram | 심링크 (setup.sh) |
| **플러그인** | karpathy-guidelines | `/plugin install` |
| **플러그인** | skill-creator | `/plugin install` |

## 디렉토리 구조

```
claude-dotfiles/
├── claude/
│   └── skills/
│       └── excalidraw-diagram/         ← Excalidraw 다이어그램 생성
│           ├── SKILL.md
│           └── references/
│               ├── color-palette.md
│               ├── element-templates.md
│               ├── json-schema.md
│               ├── render_excalidraw.py
│               ├── render_template.html
│               └── pyproject.toml
├── setup.sh
└── README.md
```

## 새 디바이스 세팅

### 사전 요구사항

- Claude Code 설치 및 로그인 완료
- `uv` (Excalidraw 렌더러용): `curl -LsSf https://astral.sh/uv/install.sh | sh`

### 설치

```bash
# 1. 클론
git clone https://github.com/<your-username>/claude-dotfiles.git ~/claude-dotfiles

# 2. 세팅 실행
cd ~/claude-dotfiles && chmod +x setup.sh && ./setup.sh

# 3. Claude Code 세션에서 플러그인 설치
/plugin marketplace add multica-ai/andrej-karpathy-skills
/plugin install andrej-karpathy-skills@karpathy-skills --scope user
/plugin install skill-creator@claude-plugins-official --scope user
/reload-plugins
```

## 스킬 추가/제거

`claude/skills/` 아래에 폴더 추가 후 커밋하면 심링크를 통해 자동 반영.

```bash
mkdir claude/skills/my-new-skill
# SKILL.md 작성 후
git add . && git commit -m "feat: add my-new-skill"
git push
```

다른 디바이스에서는 `git pull`만 하면 반영.

## on/off

- **스킬**: Claude Code 세션에서 `/skills` → Space로 상태 전환 (on / name-only / off)
- **플러그인**: `/plugin` → Installed 탭에서 토글

## 주의사항

- `~/.claude/settings.json`, `CLAUDE.md`, `.mcp.json` 등은 프로젝트/디바이스별로 관리
- 이 레포에 인증 토큰이나 API 키를 절대 포함하지 말 것
