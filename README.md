<div align="center">
	<img src="icon.svg" alt="Logo" width="160" height="160">

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

- [Create a new repository from template](#create-a-new-repository-from-template)
- [Configuration](#configuration)
	- [Default bus layout](#default-bus-layout)
	- [Input map](#input-map)
	- [Physics layers 2D \& 3D](#physics-layers-2d--3d)
- [Autoloads](#autoloads)
	- [GameGlobals \& GlobalGameEvents](#gameglobals--globalgameevents)
	- [WindowManager](#windowmanager)
		- [Resolutions](#resolutions)
		- [Screen methods](#screen-methods)
		- [Screenshot](#screenshot)
		- [Parallax](#parallax)
- [Utilities](#utilities)
	- [File handling](#file-handling)
		- [How to use](#how-to-use)
	- [Geometry](#geometry)
	- [Hardware detector](#hardware-detector)
		- [Device/OS detection](#deviceos-detection)
		- [Exports](#exports)
		- [Auto-Discover quality preset](#auto-discover-quality-preset)

# Create a new repository from template

Go to the [template](https://github.com/indie-pipeline/indie-blueprint) and create a new repository from it

![use_template](images/use_template.png)

---

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

## Input map

This project comes with very simple predefined input maps to avoid interfering with your game in a tedious way

- `WASD` movement with the keys `move_forward`, `move_back`, `move_right`, `move_left`
- `WASD` keys as been added to the existing ui input maps `ui_up`, `ui_down`, `ui_right`, `ui_left`
- The input action `debug_metrics` **_Shift+P_** opens the performance metrics when `hardware_information.tscn` it's on the scene tree

## Physics layers 2D & 3D

- `Layer 1`: It's named **World**
- `Layer 2`: It's named **Player**
- `Layer 3`: It's named **Enemies**
- `Layer 4`: It's named **Hitboxes**, `hitboxes` are collision areas that `hurtboxes` detects to implement a damage or impact system.

# Autoloads

A bunch of autoloads are ready to use for common operation in videogames to manage audio, global variables, signals, gamepad support, persistence, etc.

## GameGlobals & GlobalGameEvents

This singletons works to share data across nodes, they are always on the scene tree and can be accesed anywhere.

`GameGlobals` contains the pre-configured physic layer values and is intended to implement here the variables or functions that need to be accessed globally in your game.

```swift
extends Node


#region Physics layers
const world_collision_layer: int = 1
const player_collision_layer: int = 2
const enemies_collision_layer: int = 4
const hitboxes_collision_layer: int = 8
#endregion


```

`GlobalGameEvents` contains all the global signals by which any node or script can connect. It contains few basic ones and this is where you should place those events that you want multiple nodes to listen to

## WindowManager

One of the most important and allows you to have control of the game windows as well as resolution information, take screenshots and much more.

**By default**, it's connected to the `size_changed` signal of the `root` node to center the monitor screen automatically when a resolution it's changed.

### Resolutions

There is multiple constants defined in this manager to get the resolutions from a specific aspect-ratio, this are:

```swift
// Use the built-in methods to get resolutions, this methods support a boolean variable to limit the resolutions based on the player current monitor
WindowManager.get_mobile_resolutions()
WindowManager.get_4_3_resolutions()
WindowManager.get_16_9_resolutions()
WindowManager.get_16_10_resolutions()
WindowManager.get_21_9_resolutions()

// List of available resolutions
var resolutions: Dictionary = {
	Resolution_Mobile: [
		Vector2i(320, 480),  # Older smartphones
		Vector2i(320, 640),
		Vector2i(375, 667),  # Older smartphones
		Vector2i(375, 812),
		Vector2i(390, 844),  # Older smartphones
		Vector2i(414, 896),  # Some Iphone models
		Vector2i(480, 800),  # Older smartphones
		Vector2i(640, 960),  # Some Iphone models
		Vector2i(640, 1136), # Some Iphone models
		Vector2i(750, 1334), # Common tablet resolution
		Vector2i(768, 1024),
		Vector2i(768, 1334),
		Vector2i(768, 1280),
		Vector2i(1080, 1920), # Some Iphone models
		Vector2i(1242, 2208), # Mid-range tables
		Vector2i(1536, 2048), # High resolutions in larger tablets and some smartphones

	],
	Resolution4_3: [
	  	Vector2i(320, 180),
	   	Vector2i(512, 384),
		Vector2i(768, 576),
		Vector2i(1024, 768),
	],
	Resolution16_9: [
	  	Vector2i(320, 180),
		Vector2i(400, 224),
		Vector2i(640, 360),
		Vector2i(960, 540),
		Vector2i(1280, 720), # 720p
		Vector2i(1280, 800), # SteamDeck
		Vector2i(1366, 768),
		Vector2i(1600, 900),
		Vector2i(1920, 1080), # 1080p
		Vector2i(2560, 1440),
		Vector2i(3840, 2160),
		Vector2i(5120, 2880),
		Vector2i(7680, 4320), # 8K
	],
	Resolution16_10: [
		Vector2i(960, 600),
		Vector2i(1280, 800),
		Vector2i(1680, 1050),
		Vector2i(1920, 1200),
		Vector2i(2560, 1600),
	],
	Resolution21_9: [
	 	Vector2i(1280, 540),
		Vector2i(1720, 720),
		Vector2i(2560, 1080),
		Vector2i(3440, 1440),
		Vector2i(3840, 2160), # 4K
		Vector2i(5120, 2880),
		Vector2i(7680, 4320), # 8K
	]
}

```

### Screen methods

`center_window_position(viewport: Viewport = get_viewport()) -> void`

Center the window position based on the monitor screen _(not the viewport)_. This is called automatically when the `size_changed` signal is emitted so there is no reason to use it individually.

`screen_center() -> Vector2i`

Get the center of the viewport screen in the world

`monitor_screen_center() -> Vector2i:`

Center of the current PC screen monitor

`get_camera2d_frame(viewport: Viewport = get_viewport()) -> Rect2`

Get the frame rect where the current active `Camera2D` is on the screen, useful to see which elements are inside the camera and can be visible.

### Screenshot

`screenshot(viewport: Viewport) -> Image`

Take a screenshot of the current viewport and return it as an [Image](https://docs.godotengine.org/en/stable/classes/class_image.html) class

`screenshot_to_texture_rect(viewport: Viewport, texture_rect: TextureRect = TextureRect.new()) -> TextureRect`

Take a screenshot of the current viewport and insert it as a texture into a [TextureRect](https://docs.godotengine.org/en/stable/classes/class_texturerect.html) node

### Parallax

These methods automatically adapt the appropriate parallax size according to the current screen resolution. It supports the old [ParallaxBackground](https://docs.godotengine.org/en/stable/classes/class_parallaxbackground.html) and the new [Parallax2D](https://docs.godotengine.org/en/stable/classes/class_parallax2d.html)

`adapt_parallax_background_to_horizontal_viewport(parallax_background: ParallaxBackground, viewport: Rect2 = get_window().get_visible_rect()) -> void`

`adapt_parallax_background_to_vertical_viewport(parallax_background: ParallaxBackground, viewport: Rect2 = get_window().get_visible_rect()) -> void`

`adapt_parallax_to_horizontal_viewport(parallax: Parallax2D, viewport: Rect2 = get_window().get_visible_rect()) -> void`

`adapt_parallax_to_vertical_viewport(parallax: Parallax2D, viewport: Rect2 = get_window().get_visible_rect()) -> void`

# Utilities

General utilities that does not belongs to a particular place and are sed as static classes that can be accessed at any time even if they are not in the scene tree.

## File handling

The `FileHelper` class provides static methods to work with file extensions mainly parsing or retrieving metadata.

---

`filepath_is_valid(path: String) -> bool`

Validate a file path to know if the file is in good condition and is accessible to operate with it.

`dirpath_is_valid(path: String) -> bool`

Validate a directory path to know if the file is in good condition and is accessible to operate with it.

`directory_exist_on_executable_path(directory_path: String) -> bool`

Validate a directory path where the godot executable folder is.

`get_files_recursive(path: String, regex: RegEx = null) -> Array`

Get all the files recursively on the path provided, a `RegEx` can be passed to filter the files to retrieve.

`copy_directory_recursive(from_dir :String, to_dir :String) -> Error`

Copy content of a folder recursively into another overwrite existing files on the process.

`remove_files_recursive(path: String, regex: RegEx = null) -> Error`

Remove all the files recursively on the path provided, a `RegEx` can be passed to filter what files to delete.

`static func get_pck_files(path: String) -> Array`

This is actually a shortcut to retrieve all the `.pck` files on a folder but uses `get_files_recursive` with a `RegEx` behind the scenes.

`load_csv(path: String, as_dictionary: bool = true): Variant`

This function loads a CSV/TSV file from the specified path and returns the parsed data, when `as_dictionary` is false the first array will be the columns. Although the function name only includes `.csv` it also supports `.tsv` files that separate by tabs instead of commas

- **path (String):** The absolute path to the CSV/TSV file.
- **as_dictionary (bool, optional):** Defaults to true. When set to true, the function attempts to convert the parsed data into an array of dictionaries, using the first line of the CSV as column headers. If false, the function returns an array of arrays, where each inner array represents a row of data where the first row are the column headers.

**Returns:**

- **Variant:** The parsed CSV data can be either an array of dictionaries _(if as_dictionary is true)_ or an array of arrays.
- **ERR_PARSE_ERROR (int):** This error code is returned if there are issues opening the file, parsing the CSV data, or encountering data inconsistencies.

### How to use

For this example was used the `currency.csv` that you can find in [this website](https://wsform.com/knowledgebase/sample-csv-files/)

```bash
for line in FileHelper.load_csv("res://currency.csv", false):
		print_rich("ARRAY LINE ", line)

## Output of
[
	ARRAY LINE ["Code", "Symbol", "Name"] # Headers
	ARRAY LINE ["AED", "د.إ", "United Arab Emirates d"]
	ARRAY LINE ["AFN", "؋", "Afghan afghani"]
	ARRAY LINE ["ALL", "L", "Albanian lek"]
	ARRAY LINE ["AMD", "AMD", "Armenian dram"]
	ARRAY LINE ["ANG", "ƒ", "Netherlands Antillean gu"]
	ARRAY LINE ["AOA", "Kz", "Angolan kwanza"]
	ARRAY LINE ["ARS", "$", "Argentine peso"]
	ARRAY LINE ["AUD", "$", "Australian dollar"]
	ARRAY LINE ["AWG", "Afl.", "Aruban florin"]
	ARRAY LINE ["AZN", "AZN", "Azerbaijani manat"]
	ARRAY LINE ["BAM", "KM", "Bosnia and Herzegovina "]
	## ....
]

for line in FileHelper.load_csv("res://currency.csv"):
	print_rich("DICT LINE ", line)

## Output of
[
	DICT LINE { "Code": "AED", "Symbol": "د.إ", "Name": "United Arab Emirates d" }
	DICT LINE { "Code": "AFN", "Symbol": "؋", "Name": "Afghan afghani" }
	DICT LINE { "Code": "ALL", "Symbol": "L", "Name": "Albanian lek" }
	DICT LINE { "Code": "AMD", "Symbol": "AMD", "Name": "Armenian dram" }
	DICT LINE { "Code": "ANG", "Symbol": "ƒ", "Name": "Netherlands Antillean gu" }
	DICT LINE { "Code": "AOA", "Symbol": "Kz", "Name": "Angolan kwanza" }
	DICT LINE { "Code": "ARS", "Symbol": "$", "Name": "Argentine peso" }
	DICT LINE { "Code": "AUD", "Symbol": "$", "Name": "Australian dollar" }
	DICT LINE { "Code": "AWG", "Symbol": "Afl.", "Name": "Aruban florin" }
	DICT LINE { "Code": "AZN", "Symbol": "AZN", "Name": "Azerbaijani manat" }
	DICT LINE { "Code": "BAM", "Symbol": "KM", "Name": "Bosnia and Herzegovina " }
]
```

## Geometry

Functions to obtain information on sizes, measurements or to draw specific shapes

---

`get_random_mesh_surface_position(target: MeshInstance3D) -> Vector3`

Get a random position as `Vector3` on any mesh shape surface

`random_inside_unit_circle(position: Vector2, radius: float = 1.0) -> Vector2`

Get a random position as `Vector2` from the inside of a circle with the given `radius`

`random_on_unit_circle(position: Vector2) -> Vector2`

Get a random position as `Vector2` from a circunference

`random_point_in_rect(rect: Rect2) -> Vector2`

Get a random point as `Vector2` in the provided `Rect2`

`random_point_in_annulus(center, radius_small, radius_large) -> Vector2`

Get a random point as `Vector2` in annulus _(a donut shape)_ with provided `center` and `radius provided`

`polygon_bounding_box(polygon: PackedVector2Array) -> Rect2`

Get the bounding box as `Rect2` from the polygon points provided

## Hardware detector

All the hardware information that we can obtain lives on this class, contains auto-detection of the video adapter to decide which would be the most suitable quality preset for the player as well as other functionalities.

The `QualityPreset` is just an enum that can be used as information

```swift
enum QualityPreset {
	Low,
	Medium,
	High,
	Ultra
}

```

When the game it's ready, a few variables are initialized to access this information quickly

```swift

static var engine_version: String = "Godot %s" % Engine.get_version_info().string
static var device: String = OS.get_model_name()
static var platform: String = OS.get_name()
static var distribution_name: String = OS.get_distribution_name()
static var video_adapter_name: String = RenderingServer.get_video_adapter_name()
static var processor_name: String = OS.get_processor_name()
static var processor_count: int = OS.get_processor_count()
static var usable_threads: int = processor_count * 2 # I assume that each core has 2 threads
static var computer_screen_size: Vector2i = DisplayServer.screen_get_size()

```

### Device/OS detection

Useful methods to detect the device on which the game is running and the operating system

---

`is_steam_deck() -> bool`

`is_mobile() -> bool`

`is_windows() -> bool`

`is_linux() -> bool`

`is_mac() -> bool`

`is_web() -> bool`

### Exports

Information related to the game build

`is_multithreading_enabled() -> bool`

`is_exported_release() -> bool`

### Auto-Discover quality preset

With this method you can obtain an accurate quality preset recommended based on the video-adapter player it's using

`auto_discover_graphics_quality() -> QualityPreset`

Based on the `QualityPreset` you can access a bunch of settings that can be changed from the dictionary `graphics_quality_presets` based on the [https://github.com/Calinou/godot-sponza/blob/master/scripts/settings_gui.gd](https://github.com/Calinou/godot-sponza/blob/master/scripts/settings_gui.gd) example:

```swift
static var graphics_quality_presets: Dictionary = {
	QualityPreset.Low: GraphicQualityPreset.new("For low-end PCs with integrated graphics, as well as mobile devices",
		[
			GraphicQualityDisplay.new("environment/glow_enabled","Glow", 0, "Disabled"),
			//...
		]

// Information classes to retrieve the settings configuration
class GraphicQualityPreset:
	var description: String = ""
	var quality: Array[GraphicQualityDisplay]

	func _init(_description:String, _quality: Array[GraphicQualityDisplay] = []) -> void:
		description = _description
		quality = _quality


class GraphicQualityDisplay:
	var project_setting: String = ""
	var property_name: String = ""
	var enabled: int = 0
	var available_text: String = ""

	func _init(_project_setting:  String, _property_name: String, _enabled: int, _available_text: String) -> void:
		project_setting = _project_setting
		property_name = _property_name
		enabled = _enabled
		available_text = _available_text


```
