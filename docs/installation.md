---
title: Instalación y Paquetes
---

# Instalación y empaquetado

Esta guía describe cómo instalar la **Cognitive GitOps Suite** en tu máquina y
cómo generar un paquete Debian (`.deb`) para desplegar la suite en entornos
basados en Ubuntu o Debian. Las instrucciones aquí complementan el
[README](https://github.com/atlantyqa-labs/cognitive-suite/blob/main/README.md) del proyecto y forman parte de la documentación que se
publica en GitHub Pages.

## Instalación en modo desarrollo

Para ejecutar la suite en modo desarrollo sin contenedores ni paquetes
precompilados sigue estos pasos en tu equipo:

1. Clona o descarga el repositorio de la suite.
2. Asegúrate de tener instalado Python 3.8 o superior y `pip`.
3. Ejecuta `python cogctl.py init` para crear las carpetas necesarias bajo
   `data/` y `outputs/`.
4. Copia los archivos que quieras analizar en `data/input/`.
5. Ejecuta `python cogctl.py ingest <ruta/al/archivo>` para convertir el
   documento a texto.
6. Lanza el análisis con `python cogctl.py analyze`. Los resultados se
   almacenarán en `outputs/insights/analysis.json`.

### Bootstrap recomendado por rol (Linux Ubuntu/Debian)

Para acelerar el onboarding técnico:

```bash
# Developer
./scripts/bootstrap.sh --role developer --profile full

# DevSecOps
./scripts/bootstrap.sh --role devsecops --profile full
```

El script prepara dependencias del sistema, entorno Python local y estructura
de carpetas del proyecto.

### Bootstrap para Android (Termux)

Para early adopters móviles:

```bash
./scripts/bootstrap-android.sh --role developer --profile lite
```

Este modo prioriza documentación, validaciones y CLI. Para cargas pesadas se
recomienda un host Ubuntu remoto vía `DOCKER_HOST=ssh://...`.

### Bootstrap para usuarios finales y stakeholders

Para evaluar valor funcional sin fricción técnica:

```bash
./scripts/bootstrap-stakeholder.sh --lang es --run-demo
```

Luego abre `http://localhost:8501`.

## Generación de paquete Debian

La suite incluye un script de apoyo para empaquetar todos los componentes en
un archivo `.deb`. Esto facilita su distribución e instalación en equipos de
desarrollo donde no se quiera usar Docker. El script se encuentra en
`scripts/build-deb.sh`.

### Construcción

1. Asegúrate de tener las herramientas de empaquetado instaladas. En sistemas
   basados en Debian o Ubuntu se instalan con `sudo apt install dpkg-dev`.
2. Ejecuta el script con la versión que deseas asignar al paquete, por
   ejemplo:

   ```bash
   ./scripts/build-deb.sh 0.1.0
   ```

   El script crea un árbol temporal bajo `tmp/`, copia los archivos de la
   suite a `/usr/local/lib/cognitive-suite`, genera un wrapper ejecutable
   `cogctl` en `/usr/local/bin` y construye el paquete en el directorio
   `dist/` con el nombre `cognitive-suite_<versión>_all.deb`.

### Instalación

Para instalar el paquete generado en tu máquina:

```bash
sudo apt install ./dist/cognitive-suite_0.1.0_all.deb
```

Esto instalará la suite bajo `/usr/local/lib/cognitive-suite` y registrará
`cogctl` en el PATH del sistema. Podrás ejecutar la CLI con `cogctl` desde
cualquier directorio. Para desinstalarla, utiliza `sudo apt remove
cognitive-suite`.

## Publicación en GitHub Pages

El contenido público de la carpeta `docs/` se publica automáticamente como un
sitio estático mediante GitHub Pages usando el perfil
`mkdocs.public.yml` (sin contenido `docs/internal/**`). El flujo de trabajo
definido en `.github/workflows/pages.yml` se ejecuta cada vez que se actualizan
los archivos de documentación. Una vez desplegado, podrás navegar el sitio en
`https://<usuario>.github.io/<repositorio>/` y consultar las guías y diagramas
de uso externo.

La documentación interna (playbooks, revisiones de acceso y evidencias) se
mantiene fuera de la publicación pública y se valida en CI como artefacto
independiente.
