# seb.cl

### Source code for [my website](https://seb.cl), written in Vue 3. 
---
### Development server

```sh
npm i
npm run dev
```

### Hosting (GitHub Pages)
You don't need to pay a hosting service, just use [GitHub Pages](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site) for free.


### Building
This script builds the project into the `docs` folder, to take advantage of GitHub's [web hosting service](https://pages.github.com).
```sh
npm run build
```

### Deployment CI/CD
This project is configured to use GitHub Pages, so once you push it, the website will be automatically deployed.
```
git add -A
git commit -m "commit message"
git push
```