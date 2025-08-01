# 🎯 GameMaker Targeting System

A modular and extensible **Targeting System for GameMaker** that allows you to:
- Find nearby instances within a radius
- Filter those instances using custom logic (like HP, visibility, or flags)
- Get the **nearest valid target**
- Use the system anywhere with a static helper — no globals or boilerplate needed

---

## ✅ Why Use This?

In real-world game scenarios, you often need to:
- Find the **closest enemy** to a player
- Target only **damaged or visible** enemies
- Highlight nearby interactables
- Trigger logic when an object is **within range**

Doing this over and over clutters your objects and slows your game.  
This library solves that with:
- 🔁 **Reusable**, stateless targeting logic
- 🧠 **Custom filters** using functions or arrays of functions
- 🚀 **Fast performance** using `collision_circle_list`
- 🎯 Perfect for AI, Tower Defense, Combat Systems, and more

---

## 📦 Features

- `get_in_radius(x, y, obj, radius, filters?)`
- `get_nearest(x, y, obj, radius, filters?)`
- Supports **single or multiple filters**
- Optional `should_include()` function for custom rules
- Works with **any object type** in GameMaker
- **No instance-specific data needed** — just call it where you need it

---

## 🚀 Installation

1. Add the `TargetingHelper` script to your GameMaker project.
2. Optionally create reusable filter functions like `filter_alive`, `filter_visible`, etc.
3. Use `TargetingHelper.get_in_radius()` or `.get_nearest()` in your objects or systems.

---

## 🔧 Usage

### 🧲 Get all objects in radius

```gml
var targets = TargetingHelper.get_in_radius(x, y, 200, obj_enemy);
```

### 🔴 Filter by HP

```gml
var targets = TargetingHelper.get_in_radius(x, y, 200, obj_enemy, function(inst) {
    return inst.hp <= 5;
});
```

### 🧠 Multiple filters (HP + targetable flag)

```gml
var targets = TargetingHelper.get_in_radius(x, y, 300, obj_enemy, [
    function(inst) { return inst.hp <= 5; },
    function(inst) { return inst.can_be_targeted == true; }
]);
```

### 🧠 Multiple filters (global function)
```gml
// defined somewhere in a script file
function can_target(inst){
	return inst.can_be_targeted == true;
}

// in the step event of an object
var instance = TargetingHelper.get_nearest(x, y, 300, obj_Enemy, [
	function(inst) {
		return inst.hp <= 5;
	},
	can_target
]);
```

### 🎯 Nearest target with filters

```gml
var target = TargetingHelper.get_nearest(x, y, 300, obj_enemy, [
    function(inst) { return inst.hp <= 5; },
    function(inst) { return inst.can_be_targeted == true; }
]);

if (target != noone) {
    target.image_blend = c_red;
}
```

---

## 📜 API Reference

### TargetingHelper comes predefined, thus you have access to everything with TargetingHelper.

### `get_in_radius(x, y, radius, obj, filters?)`
- Returns an array of instances within a radius
- Filters can be:
  - A single function: `function(inst) { return true; }`
  - An array of functions: `[func1, func2]`
  - Or `undefined` for no filtering

### `get_nearest(x, y, radius, obj, filters?)`
- Returns the nearest instance that matches all filters
- Returns `noone` if nothing found

---

## 🔄 Future Features (Ideas)
- Line-of-sight (`collision_line`) integration
- Field-of-view cone checks
- Target groups or tags
- Chaining helper utilities for auto-targeting

---

## 🧠 License

Feel free to use and modify this for your own GameMaker projects. Attribution appreciated but not required.

---

🎮 Made with ❤️ by [GameMakerCasts](https://www.youtube.com/@GameMakerCasts)
