//
//  ViewController.m
//  MessageUI
//
//  Created by Michael Newell on 8/27/17.
//  Copyright © 2017 Apple Cocoa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - Send Messages

-(IBAction)sendEmail:(id)sender {
    
    NSMutableArray *mailReceipients = [[NSMutableArray alloc] init];;
    
    // Check If You Can Send Email
    
    if (([MFMailComposeViewController canSendMail]) && ([mailReceipients count] > 0)) {
        
        MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
        mailController.mailComposeDelegate = self;
        
        // subject
        [mailController setSubject:subjectLabel.text];
        
        // to (NSArray)
        [mailController setToRecipients:@[emailLabel.text]];

        // body
        [mailController setMessageBody:bodyTextView.text isHTML:NO];
        
        [self presentModalViewController:mailController animated:YES];
        
    } else {
        
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Error!"
                                              message:@"Cannot send Email. Please configure your mail client."
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       // call a method when the OK button is pressed
                                   }];
        
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    
}

- (void)sendSMS:(id)sender {
    
    // Check If You Can Send SMS
    
    if([MFMessageComposeViewController canSendText]) {
        
        NSString *message = bodyTextView.text;
        
        MFMessageComposeViewController *messageController =  [[MFMessageComposeViewController alloc] init];
        messageController.messageComposeDelegate = self;
        [messageController setRecipients:@[phoneLabel.text]];
        [messageController setBody:message];
        
        // Present message view controller on screen
        [self presentViewController:messageController animated:YES completion:nil];
        
    } else {
        
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Error!"
                                              message:@"Cannot send Message. Please use a device that can send messages."
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       // call a method when the OK button is pressed
                                   }];
        
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    
}

#pragma mark - MessageUI Delegates

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    
    switch (result) {
            
        case MessageComposeResultCancelled:
            NSLog(@"You canceled the Message.");
            break;
            
        case MessageComposeResultFailed:
        {
            NSLog(@"Message failed:  An error occurred when trying to compose this message.");
            
            // uialertview is deprecated, used for example
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send Message!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            NSLog(@"You sent the Message.");
            break;
            
        default:
            NSLog(@"An unknown error occurred when trying to compose this Message");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    
    switch (result) {

        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
            break;
        
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
        
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            break;
        
        case MFMailComposeResultFailed:{

            NSLog(@"Mail failed:  An error occurred when trying to compose this Email");
            
            // uialertview is deprecated, used for example
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send Email!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];

            break;
        }
            
        default:
            NSLog(@"An unknown error occurred when trying to compose this Email");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
