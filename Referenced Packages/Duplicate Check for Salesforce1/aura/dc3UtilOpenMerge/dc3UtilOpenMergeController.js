({
	openMerge : function(component, event, helper) {
		var mergeUrl = '/apex/dupcheck__dc3Merge?ids=' + component.get("v.recordId") + ',' + component.get("v.mergeId");
		
		var navEvt = $A.get("e.force:navigateToURL");
    	navEvt.setParams({
	      "url": mergeUrl
	    });
	    navEvt.fire();
	}
})