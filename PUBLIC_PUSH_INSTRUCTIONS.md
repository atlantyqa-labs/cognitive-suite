# Publish to GitHub (Public Repository)

```bash
cd exports/public-repos/cognitive-suite
git init -b main
git add .
git commit -m "chore(public): initial public export of cognitive-suite"
git remote add origin git@github.com:<ORG>/cognitive-suite.git
git push -u origin main
```

Optional:

```bash
git tag v0.1.0-public
git push origin v0.1.0-public
```
