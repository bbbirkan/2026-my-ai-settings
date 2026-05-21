---
name: everything-ai-code
description: |
  Everything Claude Code (ECC) açık kaynaklı repo analizi — Claude Code için eklenti/skill sistemi, instinct mimarisi ve ajan deseni dokümantasyonu

  TRIGGER bu skill'i şu durumlarda çağır:
  - ECC, everything claude code, Claude Code eklenti, instinct mimarisi, ajan deseni bahsi geçtiğinde
---

# everything-claude-code Codebase

## Description

Local codebase analysis and documentation generated from code analysis.

**Path:** `/private/tmp/everything-claude-code`
**Files Analyzed:** 228
**Languages:** JavaScript, TypeScript, Rust, Python
**Analysis Depth:** deep

## ⚠️ Önemli: Kod Yolu Hakkında

> Bu skill `/private/tmp/everything-claude-code` yolundaki geici bir klon üzerine oluşturulmuştur.
> Bu path muhtemelen artık geçersizdir. Güncel kaynak için:
> **GitHub:** https://github.com/everything-claude-code (referans dokümanlaróna bak)

## When to Use This Skill

Use this skill when you need to:
- Understand the **instinct/skill architecture** used in ECC
- Find **design patterns** and implementation examples from the codebase
- Review **API documentation** and configuration patterns
- Understand how **project vs global instinct scoping** works
- See real **test examples** for ECC commands (cmd_status, cmd_projects, load_all_instincts, etc.)
- Navigate ECC's codebase structure efficiently

## ⚡ Quick Reference

### Codebase Statistics

**Languages:**
- **JavaScript**: 181 files (79.4%)
- **TypeScript**: 17 files (7.5%)
- **Python**: 16 files (7.0%)
- **Rust**: 14 files (6.1%)

**Analysis Performed:**
- ✅ API Reference (C2.5)
- ✅ Dependency Graph (C2.6)
- ✅ Design Patterns (C3.1)
- ✅ Test Examples (C3.2)
- ✅ Configuration Patterns (C3.4)
- ✅ Architectural Analysis (C3.7)
- ✅ Project Documentation (C3.9)

## 📝 Code Examples

*High-quality examples extracted from test files (C3.2)*

**Workflow: When project and global have same ID, project wins.** (complexity: 1.00)

```python
'When project and global have same ID, project wins.'
tree = patch_globals
project = _make_project(tree)
proj_yaml = SAMPLE_INSTINCT_YAML.replace('id: test-instinct', 'id: shared-id')
proj_yaml = proj_yaml.replace('confidence: 0.8', 'confidence: 0.9')
glob_yaml = SAMPLE_GLOBAL_INSTINCT_YAML.replace('id: global-instinct', 'id: shared-id')
glob_yaml = glob_yaml.replace('confidence: 0.9', 'confidence: 0.3')
(project['instincts_personal'] / 'shared.yaml').write_text(proj_yaml)
(tree['global_personal'] / 'shared.yaml').write_text(glob_yaml)
result = load_all_instincts(project)
shared = [i for i in result if i['id'] == 'shared-id']
assert len(shared) == 1
assert shared[0]['_scope_label'] == 'project'
assert shared[0]['confidence'] == 0.9
```

**Workflow: Status should show project and global instinct counts.** (complexity: 1.00)

```python
'Status should show project and global instinct counts.'
tree = patch_globals
project = _make_project(tree)
monkeypatch.setattr(_mod, 'detect_project', lambda: project)
(project['instincts_personal'] / 'proj.yaml').write_text(SAMPLE_INSTINCT_YAML)
(tree['global_personal'] / 'glob.yaml').write_text(SAMPLE_GLOBAL_INSTINCT_YAML)
args = SimpleNamespace()
ret = cmd_status(args)
assert ret == 0
out = capsys.readouterr().out
assert 'INSTINCT STATUS' in out
assert 'Project instincts: 1' in out
assert 'Global instincts:  1' in out
assert 'PROJECT-SCOPED' in out
assert 'GLOBAL' in out
```

**Workflow: Should list projects from registry.** (complexity: 1.00)

```python
'Should list projects from registry.'
tree = patch_globals
pid = 'test123abc'
project = _make_project(tree, pid=pid, pname='my-app')
(project['instincts_personal'] / 'inst.yaml').write_text(SAMPLE_INSTINCT_YAML)
registry = {pid: {'name': 'my-app', 'root': '/home/user/my-app', 'remote': 'https://github.com/user/my-app.git', 'last_seen': '2025-01-15T12:00:00Z'}}
tree['registry_file'].write_text(json.dumps(registry))
args = SimpleNamespace()
ret = cmd_projects(args)
assert ret == 0
out = capsys.readouterr().out
assert 'my-app' in out
assert pid in out
assert '1 personal' in out
```

**Workflow: Promoting an instinct that already exists globally should fail.** (complexity: 1.00)

```python
'Promoting an instinct that already exists globally should fail.'
tree = patch_globals
project = _make_project(tree)
(project['instincts_personal'] / 'shared.yaml').write_text(SAMPLE_INSTINCT_YAML)
global_yaml = SAMPLE_INSTINCT_YAML
(tree['global_personal'] / 'shared.yaml').write_text(global_yaml)
ret = _promote_specific(project, 'test-instinct', force=True)
assert ret == 1
out = capsys.readouterr().out
assert 'already exists in global' in out
```

**Workflow: Should load from both project and global directories.** (complexity: 0.90)

```python
'Should load from both project and global directories.'
tree = patch_globals
project = _make_project(tree)
(project['instincts_personal'] / 'proj.yaml').write_text(SAMPLE_INSTINCT_YAML)
(tree['global_personal'] / 'glob.yaml').write_text(SAMPLE_GLOBAL_INSTINCT_YAML)
result = load_all_instincts(project)
ids = {i['id'] for i in result}
assert 'test-instinct' in ids
assert 'global-instinct' in ids
```

**Workflow: load_project_only_instincts should NOT include global instincts.** (complexity: 0.90)

```python
'load_project_only_instincts should NOT include global instincts.'
tree = patch_globals
project = _make_project(tree)
(project['instincts_personal'] / 'proj.yaml').write_text(SAMPLE_INSTINCT_YAML)
(tree['global_personal'] / 'glob.yaml').write_text(SAMPLE_GLOBAL_INSTINCT_YAML)
result = load_project_only_instincts(project)
ids = {i['id'] for i in result}
assert 'test-instinct' in ids
assert 'global-instinct' not in ids
```

**Workflow: Status with no instincts should print fallback message.** (complexity: 0.90)

```python
'Status with no instincts should print fallback message.'
tree = patch_globals
project = _make_project(tree)
monkeypatch.setattr(_mod, 'detect_project', lambda: project)
args = SimpleNamespace()
ret = cmd_status(args)
assert ret == 0
out = capsys.readouterr().out
assert 'No instincts found.' in out
```

*See `references/test_examples/` for all extracted examples*

## ⚙️ Configuration Patterns

*From C3.4 configuration analysis*

**Configuration Files Analyzed:** 100
**Total Settings:** 3123
**Patterns Detected:** 0

**Configuration Types:**
- unknown: 100 files

*See `references/config_patterns/` for detailed configuration analysis*

## 📖 Project Documentation

*Extracted from markdown files in the project (C3.9)*

**Total Documentation Files:** 1426
**Categories:** 13

### Overview

- **Everything Claude Code (ECC) — Agent Instructions**: **Everything Claude Code (ECC) — Agent Instructions**
- **CLAUDE.md**: **CLAUDE.md**
- **Commands Quick Reference**: **Commands Quick Reference**
- **Repo Evaluation vs Current Setup**: **Repo Evaluation vs Current Setup**
- **Everything Claude Code**: **Everything Claude Code**
- *...and 10 more*

### Architecture

- **API Design Patterns**: **API Design Patterns**
- **Deep Research**: **Deep Research**
- **Exa Search**: **Exa Search**
- **Frontend Design**: **Frontend Design**
- **Market Research**: **Market Research**
- *...and 26 more*

### Guides

- **プロジェクトガイドラインスキル（例）**: **プロジェクトガイドラインスキル（例）**
- **專案指南技能（範例）**: **專案指南技能（範例）**

### Workflows

- **dmux Workflows**: **dmux Workflows**
- **Test-Driven Development Workflow**: **Test-Driven Development Workflow**
- **Test-Driven Development Workflow**: **Test-Driven Development Workflow**
- **テスト駆動開発ワークフロー**: **テスト駆動開発ワークフロー**
- **테스트 주도 개발 워크플로우**: **테스트 주도 개발 워크플로우**
- *...and 7 more*

### Api

- **Voice Profile Schema**: **Voice Profile Schema**
- **Claude API**: **Claude API**
- **X API**: **X API**
- **Claude API**: **Claude API**
- **完整 API 参考**: **完整 API 参考**
- *...and 30 more*

### Examples

- **Product Capability Template**: **Product Capability Template**
- **Project Guidelines Template**: **Project Guidelines Template**
- **プロジェクトレベル CLAUDE.md の例**: **プロジェクトレベル CLAUDE.md の例**
- **ユーザーレベル CLAUDE.md の例**: **ユーザーレベル CLAUDE.md の例**
- **프로젝트 CLAUDE.md 예제**: **프로젝트 CLAUDE.md 예제**
- *...and 29 more*

*See `references/documentation/` for all project documentation*

## 📚 Available References

This skill includes detailed reference documentation:

- **API Reference**: `references/api_reference/` - Complete API documentation
- **Dependencies**: `references/dependencies/` - Dependency graph and analysis
- **Patterns**: `references/patterns/` - Detected design patterns
- **Examples**: `references/test_examples/` - Usage examples from tests
- **Configuration**: `references/config_patterns/` - Configuration patterns
- **Architecture**: `references/architecture/` - Architectural patterns
- **Documentation**: `references/documentation/` - Project documentation

---

**Generated by Skill Seeker** | Codebase Analyzer with C3.x Analysis
