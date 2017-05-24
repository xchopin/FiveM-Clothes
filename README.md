# FiveM: Clothing Shops addon
> The best clothing shop addon for FiveM

# Caution: WORK IN PROGRESS

## ToDo
- Withdraw
- Remove a cloth
- Add ears in the menu
- Add legacy setComponents function (for compatibility with mods using skin_customization such as Cops
- Reset firstConnection on 1 for users table

## Requirements
- EssentialMode 2.X
- MySQL or MariaDB (_not tested_)

## Features
- Fast loading
- Load skin on spawn
- Buy new clothes (it will also updates in the DBMS)
- Blips on the map
- Marker in shops
- Elegant menu
- A lot of accessories
- Choice of the gender

## Getting Started

### 1. Clone the repository
``` bash
$ git clone https://github.com/xchopin/es_clothingShop.git
```

### 2. Import the SQL file into your DBMS
``` bash
$ mysql> ./install.sql
```

### 3. Create your settings file (and fill the fields)
``` bash
$ cp Server/settings.lua.dist settings.lua
```


## API

