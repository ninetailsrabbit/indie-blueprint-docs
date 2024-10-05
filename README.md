<div align="center">
	<img src="template/icon.svg" alt="Logo" width="160" height="160">

<h3 align="center">Indie Blueprint</h3>

  <p align="center">
	This blueprint includes essential features, optimized settings, and best practices to help you create amazing indie games
	<br />
	·
	<a href="https://github.com/indie-pipeline/indie-blueprint/issues/new?assignees=ninetailsrabbit&labels=%F0%9F%90%9B+bug&projects=&template=bug_report.md&title=">Report Bug</a>
	·
	<a href="https://github.com/indie-pipeline/indie-blueprint/issues/new?assignees=ninetailsrabbit&labels=%E2%AD%90+feature&projects=&template=feature_request.md&title=">Request Features</a>
  </p>
</div>

<br>
<br>

- [Download the template](#download-the-template)
	- [Clone with git in your system](#clone-with-git-in-your-system)
	- [(Alternative) Download the template as zip from the code tab of this repo an extract it](#alternative-download-the-template-as-zip-from-the-code-tab-of-this-repo-an-extract-it)
	- [(Advanced) Download only the "template" folder using sparse checkout](#advanced-download-only-the-template-folder-using-sparse-checkout)
- [Import the content of the folder "template" as Godot project](#import-the-content-of-the-folder-template-as-godot-project)
- [Configuration](#configuration)
	- [Default bus layout](#default-bus-layout)

# Download the template

## Clone with git in your system

```bash
git clone https://github.com/ninetailsrabbit/indie-blueprint.git
```

or

## (Alternative) Download the template as zip from the code tab of this repo an extract it

![download_as_zip](images/download_zip.png)

---

## (Advanced) Download only the "template" folder using sparse checkout

You need version at least the minimum git version `2.25.0` to use the sparse checkout

```bash
git clone -n --depth=1 --filter=tree:0 https://github.com/indie-pipeline/indie-blueprint
cd indie-blueprint
git sparse-checkout set --no-cone template
git checkout

```

---

# Import the content of the folder "template" as Godot project

Import the template as Godot project

![import_godot_project](images/import_godot.png)

# Configuration

This template starts with some initial configurations that you need to know to get the most out of it.

## Default bus layout

There is a default bus layout to use in your project that are sufficient for any small-medium indie game, you can extend it or modify based on your use case but here's a good place to start

![bus_layout](images/bus_layout.png)

- `Master`: The master bus where all the other inherit froms
- `Music`: Mainly used to play looping music in your game
- `SFX/EchoSFX`: Sound effects like gun shots, hits, footsteps and so on. When you want to add an echo effect to the effect use the “EchoSFX” bus.
- `Voice`: Dialogues, ai voice effects, breath.
- `UI`: User interface sounds, button clicks, hover, transition animations, etc.
- `Ambient`: Ambient sounds like wind, nature, ocean, house interior and other stuff
