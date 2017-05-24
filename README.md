# FiveM: Clothing Shops addon
> Your clothing shop addon for FiveM.

## Caution: work in progress

## Requirements
- EssentialMode 2.X
- MySQL or MariaDB (_not tested_)

## Features
- Load skin on spawn/death
- Fast loading
- Buy new clothes (it will also updates in the DBMS)
- Blips on the map
- Marker in shops
- Elegant menu
- A lot of accessories
- Choice of the gender
- Legacy function (_in tribute of skin_customization_) for a compatibility with old mods like FiveM_Cops

## ToDo
- Payment
- Remove a cloth
- Setter and getter on each component

## Getting Started

### 1. Clone the repository
``` bash
$ git clone https://github.com/xchopin/FiveM_ClothingShop.git
```

### 2. Import the SQL file into your DBMS
``` bash
$ mysql> ./install.sql
```

### 3. Create your settings file (and fill the fields)
``` bash
$ cp Server/settings.lua.dist settings.lua
```

### 5. Add the dependency to your .yml


## Gameplay
- In a special menu, press right or left arrow to change the texture
- Press Enter or 'A' (Xbox) to save your choice (it will save in the database)

## API
### Details about components

| Component |      Part    | Prop          | Part |
|----------|:-------------:|:-------------:|:-------------:|
| Face      |    0  | Hats | 0 |
| Mask      |    1  | Glasses | 1 |
| Hair      |    2  | Ears | 2 |
| Gloves    |    3  |
| Pants     |    4  |
| Bags      |    5  |
| Shoes     |    6  |
| Shirts    |    8  |
| Vests     |    9  |
| Jackets   |   11  |




_Thanks to JCPires for his help on the menu design._
