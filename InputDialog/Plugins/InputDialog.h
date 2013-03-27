//
//  InputDialog.h
//  InputDialog
//
//  Created by Rajiv Narayana Singaseni on 3/27/13.
//
//

#import <Cordova/CDV.h>

@interface InputDialog : CDVPlugin <UIAlertViewDelegate>

- (void) prompt:(CDVInvokedUrlCommand *) command;

@end
