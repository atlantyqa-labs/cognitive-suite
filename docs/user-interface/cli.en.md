# Command Line Interface (CLI)

<span class="sovereignty-badge">Tools · Sovereign Automation</span>

For system administrators and technical profiles, the **Cognitive Suite** offers a powerful Python-based command line interface for automation, scripting, and enclave management.

---

## Main Commands

<div class="features-grid" markdown="1">

<div class="feature-card feature-card--accent-top-green" markdown="1">
### 📥 Document Ingestion
Send files directly to the semantic processing engine.

```bash
atlantyqa ingest --file report_q1.pdf \
  --title "Quarterly Analysis" --tags legal,risk
```
</div>

<div class="feature-card feature-card--accent-top-navy" markdown="1">
### 📋 Real-Time Monitoring
View local worker logs. Ideal for infrastructure debugging.

```bash
atlantyqa logs --follow
```
</div>

<div class="feature-card feature-card--accent-top-gold" markdown="1">
### 🖥️ Enclave Status
Check local models and resource usage (GPU/RAM) of the cognitive engine.

```bash
atlantyqa status --detailed
```
</div>

<div class="feature-card feature-card--accent-top-green" markdown="1">
### 🔄 GitOps Sync
Persist results in the local repository and generate the corresponding Pull Request.

```bash
atlantyqa gitops sync \
  --message "feat: weekly-analysis-sync"
```
</div>

</div>

## Pipeline Integration

<div class="tactical-container tactical-container--compact" markdown="1">

The CLI is designed for Bash scripts and local CI/CD pipelines:

```bash
#!/bin/bash
# Automated nightly analysis script
FILES=$(ls /data/incoming/*.pdf)

for file in $FILES; do
    atlantyqa ingest --file "$file" --silent
done

atlantyqa gitops sync --message "auto: nightly-batch-process"
```

</div>

!!! tip "Full Reference"
    Get a complete list of commands and options by running `atlantyqa --help`.
