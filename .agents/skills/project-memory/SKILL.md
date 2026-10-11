---
name: project-memory
description: >-
  Use this skill when recording or retrieving persistent project knowledge, editorial decisions,
  glossary terms, acronyms, or fact-checking web data using the Memory MCP and Brave Search servers.
---

# Project Memory & Web Research Skill

This skill provides operational workflows, schema conventions, and search playbooks for maintaining persistent project knowledge across sessions using the `memory` MCP server, coupled with real-time web verification via `brave-search`.

---

## 1. Quick Workflows

### Context Recall at Session Start
1. Query `read_graph` or `search_nodes` to recall:
   - Document metadata and active geometry settings.
   - Project-specific glossary terms and acronyms.
   - Pending tasks or chapter status.
2. Verify that writing or formatting aligns with recorded decisions.

### Registering New Editorial Decisions or Terminology
1. Call `create_entities` with descriptive entity types:
   - `GlossaryTerm` for technical definitions and acronyms.
   - `StylingPreference` for custom macros or layout rules.
   - `ResearchClaim` for verified empirical facts.
2. Link entities to chapters or documents with `create_relations`.

### Live Fact-Checking & CTAN Verification
1. Call `brave_web_search` with targeted queries:
   - `site:ctan.org <package_name> manual`
   - `"10.xxxx/..." doi metadata`
2. Summarize findings and save validated observations into `memory`.

---

## 2. Reference Documentation
- **[Memory Knowledge Graph Guide](./references/memory-graph-guide.md):** Entity schemas, relation types, and persistence patterns.
- **[Brave Search Playbook](./references/brave-search-playbook.md):** Efficient query strategies for academic verification and package lookups.

---

## 3. Examples
- **[Sample Memory Graph](./examples/sample-memory-graph.json):** Concrete knowledge graph snapshot illustrating document configurations, glossary terms, and literature nodes.

