# Analítica de Engagement (GA4 + CWV + WCAG 2.2)

<span class="sovereignty-badge">Métrica Oficial · Experiencia Medible · Accesibilidad Verificable</span>

Este marco alinea el seguimiento de engagement con referencias oficiales:

- **GA4**: `engaged sessions`, engagement rate y tiempo medio de interacción.
- **Google Search Console / Core Web Vitals**: `LCP`, `INP`, `CLS`.
- **W3C WCAG 2.2**: cumplimiento AA para accesibilidad.

---

## KPI institucionales mínimos

| KPI | Fuente oficial | Frecuencia |
| :--- | :--- | :--- |
| `ga4_engaged_sessions` | Google Analytics 4 | Semanal / mensual |
| `ga4_engagement_rate` | Google Analytics 4 | Semanal / mensual |
| `cwv_lcp_p75` | Search Console / CrUX | Mensual |
| `cwv_inp_p75` | Search Console / CrUX | Mensual |
| `cwv_cls_p75` | Search Console / CrUX | Mensual |
| `wcag22_aa_violations` | Auditoría accesibilidad WCAG 2.2 | Por release |

## Umbrales recomendados de operación

| Métrica | Objetivo |
| :--- | :--- |
| `LCP` | `<= 2.5s` |
| `INP` | `<= 200ms` |
| `CLS` | `<= 0.1` |
| `wcag22_aa_violations` | `0` en plantillas críticas |

## Artefactos versionados

Se recomienda mantener en repositorio:

- `metrics/engagement/kpi-catalog.yml` (definición y umbrales)
- `metrics/engagement/monthly-baseline.template.csv` (registro mensual)

## Límites y gobierno

- GA4 mide comportamiento agregado; no sustituye análisis cualitativo de ventas.
- CWV mide experiencia técnica; no sustituye validación funcional de journeys.
- WCAG 2.2 requiere revisión manual además de tooling automatizado.
