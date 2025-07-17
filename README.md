# Vibe Coding with Cline - AI-Assisted SAP CAP Development

This project demonstrates AI-powered development using Cline to rapidly build enterprise-grade SAP CAP Application with Fiori UI

## 🚀 Quick Start

### Prerequisites
- **Cline**: AI-powered code editor extension
- **SAP AI Core**
- **Grounding Rules** The following rules need to be added in `.clinerules/`:
   - **prd rule.md**: Product Requirements Document generation with TDD approach. You can follow any other open-source projects as well.
   - **cap-fiori.md**: SAP CAP and Fiori best practices for deterministic generation
   >Note: These are demo-focused rules. Production applications require comprehensive grounding rules.

- **Important nodejs modules** Cline can install this automatically because of the rules, so you can skip them, but validate if there any issues with ui generation with these versions.
   - **yo**: Version 4.3.1 (`npm install -g yo@4.3.1`)
   - **@sap/generator-fiori**: SAP Fiori generator (`npm install -g @sap/generator-fiori`)
- Enable "use the browser" - for automatic browser UI testing. 


## 🤖 AI-Assisted Development Process

### Generation Workflow
1. **Configure Cline**: Set to "Act mode" (with optional auto-approve, read edit enabled for fully autonomous)
2. **Use Generation Prompt**:
   ```
    Goal: Generate / Create a CAP Application
    Application Details: Application will be used to manage incidents. Each incident will have priority and status to indicate importance of it. Incident can also be updated with comments to indicate progress. afterwards generate the UI. I don't want to deploy it to sap hana, for now only want to test it locally.
   ```
3. **Review & Approve**: AI generates PRD → Review → Approve → Iterate → Complete implementation


## ⚠️ Few Issues and Lessons Learned

### Root Cause: Limited Context Access
Most development challenges encountered were due to **insufficient grounding rules and limited access to comprehensive SAP documentation**. With proper context and complete grounding rules, many issues could have been avoided. This project uses cline rules to ground to some level for the demo purposes

### Key Issues Resolved

#### **Data Model Mismatches**
- **Issue**: Used numeric IDs in CSV files but schema required UUID format
- **Root Cause**: Incomplete grounding rules about `cuid` aspect requirements
- **Solution**: Added the rule to the cline rules. Asked the cline again to fix it which it did by updating the CSV files with proper UUIDs

#### **UI Annotation Errors**
- **Issue**: Incorrect `TextFirst` annotation implementation
- **Root Cause**: Limited access to Fiori annotations and best practices
- **Solution**: Again rules are added for this: Proper `Common.Text` and `Common.TextArrangement` configuration

> Rules are important to achieve a deterministic outcome. You check the sample rules here [CAP and Fiori Rules](/.clinerules/cap-fiori.md).

> Tip: Configure the Context7 MCP server as an external knowledge source, enabling Cline to fetch the latest SAP documentation and best practices whenever it lacks context or hallucinates.


### Best Practices for AI-Assisted SAP Development

1. **Comprehensive Grounding**: Invest in detailed `.clinerules/` with latest SAP practices for cline.
2. **Iterative Testing**: Test after every significant change (`cds build` frequently) -> can be added as a rule for the agent the auto test.
3. **Documentation Access**: Provide AI with access to current SAP documentation via MCP servers like `Context7`.
4. **Human Oversight**: Always review and validate AI-generated code in every iteration
5. **TDD Approach**: Follow test-driven development with continuous validation -> can be given as rule for the agent.

## 📁 Project Structure

| Directory | Purpose |
|-----------|---------|
| `app/` | UI frontends and annotations |
| `db/` | Domain models and sample data |
| `srv/` | Service models and business logic |
| `.clinerules/` | AI grounding rules for deterministic generation |
| `docs/` | Additional documentation |


### Installation & Running
```bash
npm install
cds build
cds watch
```

*This project demonstrates the potential of AI-assisted enterprise development while highlighting the importance of proper context, grounding rules, and human oversight in the development process.*
