#Usage 

`window.plugins.inputDialog.prompt(
                                        {
                                          title:"Where do you stay?",
                                          text:"Please enter your postcode",
                                          buttons:[
                                                   {text:"Cancel",callback:this.onCancelClicked},
                                                   {text:"Search",callback:this.onSearchClicked}
                                          ],
                                          inputFields:[
                                                      {id:"tf1",hint:"EC1"},
                                                      {id:"tf2",hint:"EC2"}
                                          ],
                                        }
        );`
