({
    doInit : function(component, helper) {
        var Data = component.get('v.data');
        var Field = component.get('v.field');
        var outputText = component.find("outputTextId");
        outputText.set("v.value",Data[Field]);
    }
})