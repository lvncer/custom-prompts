# Cursor Slash Commands Proposal

## Requirements Definition & Large-Scale Workflows

### 🎯 Requirement Definition Commands
- `/requirements` - Create requirement definition phase template (user stories, acceptance criteria, technical requirements)
- `/architecture` - System design & tech stack selection (DB design, API design, security requirements)
- `/epic` - Large feature breakdown & management (multiple issue creation, dependency management)
- `/milestone` - Milestone setting & progress management (release planning, sprint management)
- `/stakeholder` - Stakeholder analysis & requirement organization

### 🔧 Development Efficiency Commands
- `/logs` - Save prompt logs (`.prompts/yyyy-mm-dd_feature-name.md` format)
- `/notify` - Task completion notification (mandatory notification automation)
- `/stack` - Tech stack verification & updates (dependency checks)
- `/security` - Security checks & RLS setup
- `/cleanup` - Temporary file deletion & environment cleanup

### 🚀 Integrated Workflow Commands
- `/feature` - Full feature development flow (requirements → issue → branch → implementation → test → PR)
- `/hotfix` - Emergency fix flow (high priority issue → immediate response → deploy)
- `/review` - Code review preparation (test execution → coverage check → PR creation)
- `/deploy` - Deployment preparation (build test → environment check → release)

### 🎨 UI/UX Specialized Commands
- `/design` - Apply design system (Shadcn/ui, Tailwind CSS)
- `/responsive` - Responsive design verification
- `/accessibility` - Accessibility checks (WAI-ARIA, keyboard navigation)

### 🧪 Testing Specialized Commands
- `/tdd` - Execute TDD cycle (Red-Green-Refactor)
- `/coverage` - Test coverage verification (80%+ target)
- `/e2e` - E2E test execution (Playwright automation)

## Anthropic Best Practices Compliance Analysis

### ✅ Current Compliance
1. **Explicit Instructions**: Step-by-step execution flow, specific task breakdown
2. **Context Provision**: Clear tech stack, directory structure specification
3. **Structured Format**: Phase templates, checklist format

### ⚠️ Areas for Improvement
1. **XML Format Utilization**: Underuse of `<thinking>`, `<analysis>` tags
2. **Parallel Processing Optimization**: Unclear multi-tool simultaneous execution instructions
3. **Thinking Capabilities**: Insufficient adaptation to Claude 4's extended thinking features
4. **Frontend Generation**: Lack of explicit encouragement phrases like "give it your all"

### 🔄 Recommended Improvements
```markdown
## Execution Flow (Improved Version)
<analysis>
1. Task summary, rule confirmation, requirement identification
</analysis>
<execution>
2. Implementation following directory structure & naming conventions
</execution>
<quality_control>
3. Error handling (isolation → solution → verification → analysis)
</quality_control>
<report>
4. Final confirmation & reporting
</report>
```

## Implementation Priority
1. **High Priority**: `/requirements`, `/architecture`, `/feature`, `/logs`
2. **Medium Priority**: `/epic`, `/milestone`, `/review`, `/deploy`
3. **Low Priority**: UI/UX and testing specialized commands

## Technical Considerations
- Integration with existing workflow patterns
- Compatibility with current MCP tools (Playwright, Supabase, DeepWiki)
- Alignment with established naming conventions and directory structure
- Preservation of existing quality control mechanisms
