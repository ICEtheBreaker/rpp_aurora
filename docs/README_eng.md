> Call for developers! We're looking for others developers. Leave a message in <a href="https://vk.com/rpp.aurora">our group</a>

<p align="center">
   <img src="https://i.ibb.co/zRYpSCd/polechudes_nobackground.png"
        height="320"
        width="520">
</p>

<h2 align="center">Localization</h2>
<table align="center">
    <tbody>
        <tr>
            <td><a href="https://github.com/ICEtheBreaker/rpp_aurora/blob/master/docs/README_eng.md">English</a></td>
        </tr>
        <tr>
            <td><a href="https://github.com/ICEtheBreaker/rpp_aurora/blob/master/README.md">Русский</a></td>
        </tr>
    </tbody>
</table>

<h2 align='center'>Repo status</h2>
<p align="center">
    	<img src="https://img.shields.io/github/actions/workflow/status/ICEtheBreaker/rpp_aurora/manual.yml?label=GAMEMODE%20BUILD&style=for-the-badge" alt="Build check">
    <a href="https://github.com/ICEtheBreaker/CRMPProject-Main/graphs/contributors" alt="Contributors">
        <img src="https://img.shields.io/github/contributors/ICEtheBreaker/rpp_aurora?style=for-the-badge" alt="Contributors"></a>
    <a href="https://github.com/ICEtheBreaker/CRMPProject-Main/pulse" alt="Activity">
        <img src="https://img.shields.io/github/commit-activity/m/ICEtheBreaker/rpp_aurora?label=COMMIT%20ACTIVITY&style=for-the-badge" alt="Activity" ></a>
    <a href="https://github.com/ICEtheBreaker/CRMPProject-Main/graphs/commit-activity" alt="Last activity">
        <img src="https://img.shields.io/github/last-commit/ICEtheBreaker/rpp_aurora?label=LAST%20ACTIVITY&style=for-the-badge" alt="Last activity" ></a>
	<img src="https://img.shields.io/github/repo-size/ICEtheBreaker/rpp_aurora?style=for-the-badge" alt="Repo size">
<!--- <a href="https://vk.com/rpp.aurora" alt="Follow us">
        <img src="https://img.shields.io/twitter/follow/rpp.aurora?&style=for-the-badge" alt="Check latest news"></a>--->
</p>
<h2 align="center">Branches check</h2>
<p align="center">
    <img src="https://img.shields.io/github/checks-status/ICEtheBreaker/rpp_aurora/master?label=master&style=for-the-badge" alt="master checks">
    <img src="https://img.shields.io/github/checks-status/ICEtheBreaker/rpp_aurora/develop?label=develop&style=for-the-badge" alt="develop checks">
    <img src="https://img.shields.io/github/checks-status/ICEtheBreaker/rpp_aurora/feature_duttilao?label=feature_duttilao&style=for-the-badge" alt="feature_dutillao checks">
    <img src="https://img.shields.io/github/checks-status/ICEtheBreaker/rpp_aurora/feature_devjan?label=feature_devjan&style=for-the-badge" alt="feature_devjan checks">
</p>


# What is this?
This is **The Home Depot** of <a href="https://vk.com/rpp.aurora">Aurora RP</a>, which is a role-playing project where everyone has to play their role, create and develop their characters. Anyone can reach unprecedented heights or stay in the lowlands. Join a government organization or a faction. Complete tasks for your faction and increase its reputation. Create your own unique business and use all the forces of marketing to make it popular.


This repo hosts:
  - source code of the main gamemode, written on <a href="https://ru.wikipedia.org/wiki/Pawn">Pawn</a>;
  - header files;
    - includes;
    - scriptfiles;
  - filterscripts
  - plugins
  - settings and instructions for <a href="https://code.visualstudio.com">VS Code</a>; 
     - <a href="https://learn.microsoft.com/en-us/visualstudio/releases/2019/release-notes">VS2019 Community</a>;
     - <a href="https://gitlens.com">Git Lens</a> - this is the main extension for better work with Git.

## Quick start

Main <a href="https://github.com/ICEtheBreaker/rpp_aurora">repo</a> - is the citadel of everything related to project <a href="https://vk.com/rpp.aurora">Aurora RP</a>. 

You can freely fork this repository and add your own improvements. 
And if you want to help with development, you can clone the repository and open a pull request.
	
## Cloning  
Follow steps below to quickly start working with this repo
</br>

Before you start, you will need Git and SSH.

##### You have installed <a href="https://git-scm.com/downloads">Git</a> and setupped <a href="https://docs.github.com/en/authentication/connecting-to-github-with-ssh">SSH-client </a>.

1. Open your Git terminal and enter the following lines:
```
git clone git@github.com:ICEtheBreaker/rpp_aurora.git
```

<h4>This will clone our repository into your workspace root.</h4>

------------------------------------------------

2. When cloning is finished, switch to the folder in which you have cloned the repository.
```
cd /disk/${workspaceRoot}/name of folder
```
<h4>disk - the letter of your disk.</br>
${workspaceRoot} - path to your folder</h4>

------------------------------------------------

### If you have Git-clients such as: Sourcetree, Github Desktop, etc.
</br>
<h2>Sourcetree</h2>


1. Authenticate your GitHub profile with Sourcetree;
2. Click on 'Clone' button;
3. Enter this line and choose folder to clone;
```
git@github.com:ICEtheBreaker/rpp_aurora.git
```
4. Wait for clone to finish;
5. Start working.

> We use Sourcetree for easiest work with git.
</br>
<h2>GitHub Desktop</h2>


1. Click on 'File' in the upper bar;
2. Choose 'Clone repository';
3. Click on 'URL' and paste this path:
```
git@github.com:ICEtheBreaker/rpp_aurora.git
```
4. Select the folder where the repository is being cloned;
5. Wait for clone to finish;
6. Start working.

> GitHub Desktop is the official GitHub Git-client

If you can't do steps above, you can goto repository and click 'Code' and then Download ZIP. You will download current version on selected branch.

# File directories and development
We use the following IDEs for faster and more convenient development. They also come with the necessary extensions and testing tools
- <a href="https://code.visualstudio.com">Visual Studio Code</a>; 
- <a href="https://www.sublimetext.com">Sublime Text</a>;
- <a href="https://learn.microsoft.com/en-us/visualstudio/releases/2019/release-notes">Visual Studio 2019 Community</a>;

- <a href="https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens">Git Lens</a>.
------------------------------------------------
### Files paths

   - <h3><a href="https://github.com/ICEtheBreaker/CRMPProject-Main/tree/develop/gamemodes/new.pwn">gamemodes/new.pwn</a> - main gamemode;</br></h3>
   - <h3><a href="https://github.com/ICEtheBreaker/CRMPProject-Main/tree/develop/defines/systems/capture_natives">defines/systems/captune_natives/natives.inc</a> - natives and macroses;</br></h3>
   - <h3><a href="https://github.com/ICEtheBreaker/CRMPProject-Main/tree/develop/defines/colors.inc">defines/colors.inc</a> - HTML & HEX color codes;</br></h3>
   - <h3><a href="https://github.com/ICEtheBreaker/CRMPProject-Main/tree/develop/defines/db_conn">defines/db_conn</a> - SQL-connection;</br></h3>
   - <h3><a href="https://github.com/ICEtheBreaker/CRMPProject-Main/tree/develop/defines/macroses.inc">defines/macroses.inc</a> - macroses and natives;</br></h3>
   - <h3><a href="https://github.com/ICEtheBreaker/CRMPProject-Main/tree/develop/defines/name.inc">defines/name.inc</a> - hostname, modname, mapname, <a href="https://vk.com/rpp.aurora">project group</a>;</br></h3>
   - <h3><a href="https://github.com/ICEtheBreaker/CRMPProject-Main/tree/develop/pawno/includes">pawno/includes</a> - all includes and header files</br></h3>

------------------------------------------------

# License
All resources, except for includs outside the `/defines` directory, are under the SAMP-LICENSE and are the property of Darkside Interactive. Usage of the source code for personal gain, theft, transfer to third parties or distribution to the masses is strictly prohibited.

All logos in `/raw` are trademarks of their respective companies and operate in accordance with their terms and license.

# Support

<h4>You can contact us or create new issue if you find any error or poor code.</h4>
