<p align="center">
   <img src="https://i.ibb.co/zRYpSCd/polechudes_nobackground.png"
        height="320"
        width="520">
</p>
<p align="center">
    <a href="https://github.com/ICEtheBreaker/CRMPProject-Main/graphs/contributors" alt="Контрибьюторы">
        <img src="https://img.shields.io/github/contributors/ICEtheBreaker/CRMPProject-Main?label=%D0%9A%D0%BE%D0%BD%D1%82%D1%80%D0%B8%D0%B1%D1%8C%D1%8E%D1%82%D0%B5%D1%80%D1%8B&style=for-the-badge" alt="Контрибьютеры"></a>
    <a href="https://github.com/ICEtheBreaker/CRMPProject-Main/pulse" alt="Активность">
        <img src="https://img.shields.io/github/commit-activity/m/ICEtheBreaker/CRMPProject-Main?label=%D0%90%D0%9A%D0%A2%D0%98%D0%92%D0%9D%D0%9E%D0%A1%D0%A2%D0%AC&style=for-the-badge" alt="Активность" ></a>
    <a href="https://github.com/ICEtheBreaker/CRMPProject-Main/graphs/commit-activity" alt="Последняя активность">
        <img src="https://img.shields.io/github/last-commit/ICEtheBreaker/CRMPProject-Main?label=%D0%BF%D0%BE%D1%81%D0%BB%D0%B5%D0%B4%D0%BD%D1%8F%D1%8F%20%D0%B0%D0%BA%D1%82%D0%B8%D0%B2%D0%BD%D0%BE%D1%81%D1%82%D1%8C&style=for-the-badge" alt="Последняя активность" ></a>
    <a href="https://vk.com/rpp.aurora" alt="Следить">
        <img src="https://img.shields.io/twitter/follow/rpp.aurora?&style=for-the-badge" alt="Следить за новостями"></a>
</p>


# Что это?
Это **приют бездомных** <a href="https://vk.com/rpp.aurora">Aurora RP</a>, который представляет из себя ролевой режим, где каждый должен отыгрывать свою роль, создавать и развивать своих персонажей. Любой может достичь небывалых высот или же остаться в низинах. Вступите в государственную организацию или во фракцию. Выполняйте задания для своей фракции и повышайте её репутацию. Создайте свой уникальный бизнес и используйте все силы маркетинга, чтобы он стал популярным.

Этот репозиторий хранит в себе:
  - исходный код игрового мода на языке <a href="https://ru.wikipedia.org/wiki/Pawn">Pawn</a>;
  - колонтитульные файлы;
    - инклуды;
    - скриптфайлы;
  - фильтрскрипты
  - плагины
  - настройки для <a href="https://code.visualstudio.com">VS Code</a>; 
     - <a href="https://learn.microsoft.com/en-us/visualstudio/releases/2019/release-notes">VS2019 Community</a>;
     - <a href="https://github.com">Git Hub</a>.

### Быстрый старт

Рабочий <a href="https://github.com/ICEtheBreaker/CRMPProject-Main">репозиторий</a>

Если Вы хотите работать над этим проектом, есть два условия:
  
##### У Вас установлен <a href="https://git-scm.com/downloads">Git</a> и настроен <a href="https://docs.github.com/en/authentication/connecting-to-github-with-ssh">SSH-клиент </a>.

```
  git clone git@github.com:ICEtheBreaker/CRMPProject-Main.git
  cd ${workspaceRoot}/CRMPProject-Main
  make quick-release
```
##### У Вас установлен клиент <a href="https://www.sourcetreeapp.com">Sourcetree</a> или <a href="https://desktop.github.com">Github Desktop</a>.

```
  git@github.com:ICEtheBreaker/CRMPProject-Main.git || https://github.com/ICEtheBreaker/CRMPProject-Main.git
```

# Разработка
Мы используем следующие среды разработки, а также дополнения к ним.
- <a href="https://code.visualstudio.com">Visual Studio Code</a>; 
- <a href="https://www.sublimetext.com">Sublime Text</a>;
- <a href="https://learn.microsoft.com/en-us/visualstudio/releases/2019/release-notes">Visual Studio 2019 Community</a>;

- <a href="https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens">Git Lens</a>.
------------------------------------------------
### Директории файлов и наименования:

   - <h3><a href="https://github.com/ICEtheBreaker/CRMPProject-Main/tree/develop/gamemodes/new.pwn">gamemodes/new.pwn</a> - игровой мод;</br></h3>
   - <h3><a href="https://github.com/ICEtheBreaker/CRMPProject-Main/tree/develop/defines/systems/capture_natives">defines/systems/captune_natives/natives.inc</a> - нативы и функции;</br></h3>
   - <h3><a href="https://github.com/ICEtheBreaker/CRMPProject-Main/tree/develop/defines/colors.inc">defines/colors.inc</a> - цветовые коды HTML & HEX;</br></h3>
   - <h3><a href="https://github.com/ICEtheBreaker/CRMPProject-Main/tree/develop/defines/db_conn">defines/db_conn</a> - подключение SQL;</br></h3>
   - <h3><a href="https://github.com/ICEtheBreaker/CRMPProject-Main/tree/develop/defines/macroses.inc">defines/macroses.inc</a> - сокращённые макросы нативов;</br></h3>
   - <h3><a href="https://github.com/ICEtheBreaker/CRMPProject-Main/tree/develop/defines/name.inc">defines/name.inc</a> - наименование сервера, карта, <a href="vk.com/rpp.aurora">группа  ВКонтакте</a>;</br></h3>
   - <h3><a href="https://github.com/ICEtheBreaker/CRMPProject-Main/tree/develop/pawno/includes">pawno/includes</a> - все основные инклуды, без которых ничего работать не будет.</br></h3>

------------------------------------------------

# Лицензия
Все ресурсы, кроме инклудов вне директории `/defines`, находятся под ЛИЦЕНЗИЕЙ SAMP-LICENSE и являются собственностью Darkside Interactive. Использование исходного кода в целях личной выгоды, кражи, передачи третьим лицам или распространении в массы строго запрещены. 

Все логотипы в `/raw` являются товарными знаками соответствующих компаний и действуют в соответствии с их условиями и лицензией.
# Поддержка

<h4>Если найдена ошибка в коде, создавайте отчёт в <a href="https://github.com/ICEtheBreaker/CRMPProject-Main/issues">Issues</a>.</h4>
