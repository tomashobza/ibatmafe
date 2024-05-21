 ![fit logo](docs/fit_logo.png)

# ImBadAtTimeManagementAndForgetEverything

**IZA project 2023/2024 @ FIT BUT**

Author: Tomáš Hobza ([xhobza03](mailto:xhobza03@vutbr.cz))

---

## 👋 Introduction

This repository contains an iOS app create as a part of the IZA (*Programování zařízení Apple/Apple device programming*) course on FIT BUT. The app is a simple TODO-like app aimed at solving the chaos of managing univeristy projects.

## ✨ Features

The app is based on a very simple idea - the efficiency of displaying data plays a crucial role in the way we, humans, process it. There are a lot of solutions aimed at this specific target problem, but they either try to pack as many features in as possible - thus creating even more chaos - or they are too basic - missing features that make the app impractical for university projects.

*What is the main purpose of this app?* A simple intuitive dashboard for quickly cheking the status of tasks. Essentially, the dashboard is meant to be looked at at the beginning of the day for a „What do I have to do today?“ check.

## 📊 Data model

![Class Diagram](./docs/class-diagram.svg)

*Caption: Class diagram of the data model*

In terms of persistent data, the model is pretty simple. Each user has a list of events, where each event has a specific type. Events can also have tasks. Tasks represent subproblems of the whole event that help the user keep track of how much the user has completed already.

## 📝 Usage examples

| This video showcases the process of creating an event and editing that event. It also shows the filtering/sorting options of the main screen dashboard. | ![Osobní Replay Final (1)](docs/lightmode.gif) |
| ------------------------------------------------------------ | ---------------------------------------------- |
| This video showcases the support for dark mode and deleting an Event. | ![Osobní Replay Final](docs/darkmode.gif)      |

## 🧪 Testing

As the interactivity of the app is not that complex, the testing was mainly done manualy. I have personally used the app while studying for final exams to keep track of my studying progress.
