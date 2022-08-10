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
