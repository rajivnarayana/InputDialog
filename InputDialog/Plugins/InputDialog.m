//
//  InputDialog.m
//  InputDialog
//
//  Created by Rajiv Narayana Singaseni on 3/27/13.
//
//

#import "InputDialog.h"

@interface InputDialog() {
    NSMutableArray *textFieldsCreated;
}

- (UITextField *) textFieldAtIndex:(NSInteger ) integer;

@property(nonatomic, strong)    CDVInvokedUrlCommand * myCommand;
@property(nonatomic, strong)    NSMutableArray *textFieldsCreated;

@end

@implementation InputDialog

@synthesize textFieldsCreated;

- (void) prompt:(CDVInvokedUrlCommand *) command {
    
    self.myCommand = command;
    
    NSMutableDictionary *options = [[command.arguments lastObject] mutableCopy];
    
    NSArray *buttons = [options valueForKey:@"buttons"];
    
    //retain the command so we can use the callbackid later to get back to js

    //present an alert view to the user.

    //first button is always cancel Button.
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[options valueForKey:@"title"] message:[options valueForKey:@"text"] delegate:self cancelButtonTitle:[buttons[0] valueForKey:@"text"] otherButtonTitles: nil];
    if ([buttons count] > 1) {
        [alertView addButtonWithTitle:[buttons[1] valueForKey:@"text"]];
    }
    
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
    
//    [[[UIAlertView alloc] initWithTitle:@"Some title" message:@"Some message" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil] show];
}
- (void)willPresentAlertView:(UIAlertView *)alertView{  // before animation and showing view
    NSMutableDictionary *options = [[_myCommand.arguments lastObject] mutableCopy];
    NSArray *textFields = [options valueForKey:@"inputFields"];

    if (textFields.count < 2) {
        return;
    }

    
    UITextField *firstTextField = [alertView textFieldAtIndex:0];
    firstTextField.borderStyle = UITextBorderStyleBezel;
    CGRect textFieldFrame = firstTextField.frame;
    firstTextField.frame = CGRectMake(textFieldFrame.origin.x, textFieldFrame.origin.y, textFieldFrame.size.width/2-3, textFieldFrame.size.height);
    UITextField *textField2 = [[UITextField alloc] initWithFrame:CGRectMake(textFieldFrame.origin.x + textFieldFrame.size.width/2 + 3, textFieldFrame.origin.y, textFieldFrame.size.width/2-3, textFieldFrame.size.height)];
    textField2.borderStyle = UITextBorderStyleBezel;

    [alertView addSubview:textField2];
    self.textFieldsCreated = [NSMutableArray arrayWithObject:textField2];
}

- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    //prepare a cdv result and send the result to it.
    CDVPluginResult* pluginResult = nil;
    NSString* javaScript = nil;
    
    NSMutableArray *texts = [NSMutableArray arrayWithObject:[alertView textFieldAtIndex:0].text];
    NSMutableDictionary *options = [[_myCommand.arguments lastObject] mutableCopy];
    NSArray *textFields = [options valueForKey:@"inputFields"];
    
    if (textFields.count > 1) {
        [texts addObject:[self textFieldAtIndex:1].text];
    }

    @try {
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:buttonIndex], @"buttonIndexClicked", texts,@"text", nil];
        
//        if (myarg != nil) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dictionary];
            javaScript = [pluginResult toSuccessCallbackString:_myCommand.callbackId];
//        }
    } @catch (id exception) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_JSON_EXCEPTION messageAsString:[exception reason]];
        javaScript = [pluginResult toErrorCallbackString:_myCommand.callbackId];
    }
    
    [self writeJavascript:javaScript];
    
    //invoke writeJavascript method of CDVPlugin.
}

- (UITextField *) textFieldAtIndex:(NSInteger ) integer {
    return [self.textFieldsCreated objectAtIndex:integer-1];
}

@end
