# headphones-music-radio-fivem
QB Core Script to use "headphones" to listen to music being played on GTA Radios stations anywhere in San Andreas! 

# Install
- Install Latest Version
- Drag into the Resources Folder and Ensure
- QB Core > Shared > Items.lua add the following:
```
    ["headphone"] = {
        ["name"] = "headphone",
        ["label"] = "Headphones",
        ["weight"] = 500,
        ["type"] = "item",
        ["image"] = "headphones.png",
        ["unique"] = true,
        ["useable"] = true,
        ["shouldClose"] = true,
        ["combinable"] = nil,
        ["description"] = "Listen to some of the best radio stations in San Andreas outside of your vehicle!"
    },
```
- Qb-Core > Shops > config.lua add the following where you see fit:
```
        {name = 'headphone',     price = 2,   amount = 50,    info = {}, type = 'item'},
```

Enjoy, if there are issues problems, or anything like that join my discord and let me know so I can fix it!
Discord: https://discord.gg/RQBhmWEzTx
