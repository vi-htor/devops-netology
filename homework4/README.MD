# Answers to questions

1. `git show aefea` → aefead2207ef7e2aa5dc81a34aedf0cad4c32545
2. `git show 85024d3` (либо `git tag --points-at 85024d3`) → v0.12.23
3. `git log b8d720 -n 1 --pretty="%p"` → 56cd7859e0 9ea88f22fc
4. `git log --pretty=oneline v0.12.23..v0.12.24` 
   ```
   b14b74c4939dcab573326f4e3ee2a62e23e12f89 [Website] vmc provider links
   3f235065b9347a758efadc92295b540ee0a5e26e Update CHANGELOG.md
   6ae64e247b332925b872447e9ce869657281c2bf registry: Fix panic when server is unreachable
   5c619ca1baf2e21a155fcdb4c264cc9e24a2a353 website: Remove links to the getting started guide's old location
   06275647e2b53d97d4f0a19a0fec11f6d69820b5 Update CHANGELOG.md
   d5f9411f5108260320064349b757f55c09bc4b80 command: Fix bug when using terraform login on Windows
   4b6d06cc5dcb78af637bbb19c198faff37a066ed Update CHANGELOG.md
   dd01a35078f040ca984cdd349f18d0b67e486c35 Update CHANGELOG.md
   225466bc3e5f35baa5d07197bbc079345b77525e Cleanup after v0.12.23 release
   ```
5. `git log -S "func providerSource" --oneline` → 8c928e8358
6. Судя по всему в ветке main функция не менялась с момента введения в коммите 8364383c35
   `git log -S "func globalPluginDirs" --oneline` выдаёт лишь его, однако по поиску без func выдаётся ещё несколько коммитов, но в git show про изменение в ниъ данной функции информации нет.
7. `git log -S "func synchronizedWriters" --oneline` → bdfea50cc8
   `git show 5ac311e2a9 | grep Author` → Martin Atkins <mart@degeneration.co.uk>