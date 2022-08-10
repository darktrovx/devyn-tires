# Remove vehicle tires with qb-target and repair them using a tire item.

# Items

```
['tire'] 			 		 	 = {['name'] = 'tire', 							['label'] = 'Tire', 		['weight'] = 5000, 		['type'] = 'item', 		['image'] = 'tire.png', 		['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'The wheels on the bus go round and round'},
```

# qb-target

Under the Config.TargetBones add the following
```
["tires"] = {
		bones = {"wheel_lf", "wheel_rf", "wheel_lm1", "wheel_rm1", "wheel_lm2", "wheel_rm2", "wheel_lm3", "wheel_rm3", "wheel_lr", "wheel_rr"},
		options = {
            {
				type = "client",
				event = "Tire:Handler",
                icon = "fa-solid fa-circle-dot",
                label = "Remove Tire",
            },
        },
        distance = 2.0,
	}
```

# Previews
![image](https://user-images.githubusercontent.com/7463741/183925954-b3dff654-15f5-46bc-a3f4-b08bdd3d78aa.png)

![image](https://user-images.githubusercontent.com/7463741/183926029-0ef79d93-9741-4497-86da-751dc6caac24.png)


