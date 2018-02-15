({
	openConvert : function(component, event, helper) {
		var convertUrl = '/apex/dupcheck__dc3Convert?';
		var recordA = component.get("v.recordId");
		var recordB = component.get("v.mergeId");
		
		var uriList = [];
		if (helper.startsWith(recordA, '001')) {
			uriList.push('account='+recordA);
		} else if (helper.startsWith(recordA, '00Q')) {
			uriList.push('Id='+recordA);
		} else if (helper.startsWith(recordA, '003')) {
			uriList.push('contact='+recordA);
		}
		
		if (helper.startsWith(recordB, '001')) {
			uriList.push('account='+recordB);
		} else if (helper.startsWith(recordB, '00Q')) {
			uriList.push('Id='+recordB);
		} else if (helper.startsWith(recordB, '003')) {
			uriList.push('contact='+recordB);
		}
		
		var navEvt = $A.get("e.force:navigateToURL");
    	navEvt.setParams({
	      "url": convertUrl + uriList.join('&')
	    });
	    navEvt.fire();
	}
})