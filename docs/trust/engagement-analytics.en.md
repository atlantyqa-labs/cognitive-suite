# Engagement Analytics (GA4 + CWV + WCAG 2.2)

<span class="sovereignty-badge">Official Metrics · Measurable UX · Verifiable Accessibility</span>

This framework aligns engagement tracking with official references:

- **GA4**: `engaged sessions`, engagement rate, average engagement time.
- **Google Search Console / Core Web Vitals**: `LCP`, `INP`, `CLS`.
- **W3C WCAG 2.2**: AA accessibility compliance.

---

## Minimum institutional KPIs

| KPI | Official source | Frequency |
| :--- | :--- | :--- |
| `ga4_engaged_sessions` | Google Analytics 4 | Weekly / monthly |
| `ga4_engagement_rate` | Google Analytics 4 | Weekly / monthly |
| `cwv_lcp_p75` | Search Console / CrUX | Monthly |
| `cwv_inp_p75` | Search Console / CrUX | Monthly |
| `cwv_cls_p75` | Search Console / CrUX | Monthly |
| `wcag22_aa_violations` | WCAG 2.2 accessibility audit | Per release |

## Recommended operating thresholds

| Metric | Target |
| :--- | :--- |
| `LCP` | `<= 2.5s` |
| `INP` | `<= 200ms` |
| `CLS` | `<= 0.1` |
| `wcag22_aa_violations` | `0` on critical templates |

## Versioned artifacts

Recommended repository assets:

- `metrics/engagement/kpi-catalog.yml` (definitions and thresholds)
- `metrics/engagement/monthly-baseline.template.csv` (monthly tracking)

## Limits and governance

- GA4 captures aggregated behavior; it does not replace qualitative sales analysis.
- CWV captures technical experience; it does not replace journey functional validation.
- WCAG 2.2 needs manual review in addition to automated tooling.
