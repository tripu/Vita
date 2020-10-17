**Table of contents**

1. [Prerequisites](#1-prerequisites)
1. [Oranisation of the files](#2-organisation-of-the-files)
1. [How to build](#3-how-to-build)

---

## 1. Prerequisites

[Node.js](https://nodejs.org/en/) (including [npm](https://www.npmjs.com/)).

## 2. Organisation of the files

* `src/`: source documents
* `docs/`: auto-generated site, deployed via GH Pages (do _not_ edit this)
  * `docs/assets/`: (S)CSS tweaks (OK to edit)

## 3. How to build

```bash
git clone https://github.com/tripu/Vita.git
cd Vita
npm ci
# Now work on “src/”
npm run build
# See the results under “docs/” (and open a PR!)
```
