//
//  ViewController.h
//  MessageUI
//
//  Copyright © 2017 Apple Cocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ViewController : UIViewController <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate> {
    
    IBOutlet UITextField *nameLabel;
    IBOutlet UITextField *emailLabel;
    IBOutlet UITextField *phoneLabel;
    IBOutlet UITextField *subjectLabel;
    IBOutlet UITextView *bodyTextView;

    IBOutlet UIButton *smsButton;
    IBOutlet UIButton *emailButton;
    
}

-(IBAction)sendSMS:(id)sender;
-(IBAction)sendEmail:(id)sender;

@end

