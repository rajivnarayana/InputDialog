// window.plugins.inputDialog

var InputDialog = function() {
    this.callback;
}

/**
  *
  *{
    title:"Where do you stay?",
    text:"Please enter your post code",
    buttons:[
        {text:"Search",callback:function}
        {text:"Cancel",callback:function}
    ],
    inputFields:[
        {text:"",hint:"EC1"}
    ],
 }
  */
InputDialog.prototype.prompt = function(params) {
    
	cordova.exec(function(result){
                 console.log("result: "+JSON.stringify(result));
                 params['buttons'][result['buttonIndexClicked']]['callback'](result['text']);
    }, function(error){
                 alert("failed");
                 console.log("result: "+JSON.stringify(result));
    }, "InputDialog", "showInputDialog", [params]);
}

cordova.addConstructor(function()  {
                    if(!window.plugins) {
                       window.plugins = {};
                       }
                       
                       // shim to work in 1.5 and 1.6
                       if (!window.Cordova) {
                       window.Cordova = cordova;
                       };
                       
                       window.plugins.inputDialog = new InputDialog();
                       });