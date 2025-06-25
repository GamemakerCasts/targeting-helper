function TargetingHelper() {
    
    static get_in_radius = function(x, y, radius, obj, filters = undefined) {
        var list = ds_list_create();
        collision_circle_list(x, y, radius, obj, false, false, list, true);

        var results = [];

        for (var i = 0; i < ds_list_size(list); i++) {
            var inst = list[| i];
			
			// Check filter, if provided
			if (!should_include(inst, filters)) continue;
			
            array_push(results, inst);
        }

        ds_list_destroy(list);
        return results;
    };

    static get_nearest = function(x, y, radius, obj, filters = undefined) {
        var nearby = TargetingHelper.get_in_radius(x, y, radius, obj, filters);
        var nearest = noone;

        if(array_length(nearby) > 0) {
			nearest = nearby[0];
		}

        return nearest;
    };

    static should_include = function (inst, filters) {
	    if (filters == undefined) return true;

	    if (is_array(filters)) {
	        for (var i = 0; i < array_length(filters); i++) {
	            var f = filters[i];
	            if (!f(inst)) return false;
	        }
	        return true;
	    }
		
		return filters(inst);
	}
}

TargetingHelper();
