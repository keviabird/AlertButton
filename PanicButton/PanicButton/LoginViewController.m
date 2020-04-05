//
//  LoginViewController.m
//  PanicButton
//
//  Created by Елена Грачева on 03.04.15.
//  Copyright (c) 2015 BACCA. All rights reserved.
//

#import "LoginViewController.h"
#import "CitiesViewController.h"
#import "SynchroService.h"
#import "Alert.h"
#import "Const.h"
#import "ConnectionUnreachableException.h"
#import "WrongCredentialsViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.login setTitle:NSLocalizedString(@"CONTINUE", @"") forState:UIControlStateNormal];
    [self.login setTitle:NSLocalizedString(@"CONTINUE", @"") forState:UIControlStateHighlighted];
    self.enterPhoneTitle.text = NSLocalizedString(@"ENTER_PHONE", @"");
    self.enterIdTitle.text = NSLocalizedString(@"ID", @"");
    [self.code setTitle:NSLocalizedString(@"CODE", @"") forState:UIControlStateNormal];
    [self.code setTitle:NSLocalizedString(@"CODE", @"") forState:UIControlStateHighlighted];
    self.phone.placeholder = NSLocalizedString(@"PHONE_NUMBER", @"");
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)login:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:self.phone.text forKey:NAME_PHONE];
    [[NSUserDefaults standardUserDefaults] setObject:self.identifier.text forKey:NAME_SYSTEM_ID];
    @try {
        [SynchroService authorize];
        [self.navigationController popViewControllerAnimated:YES];
    } @catch(AlertThriftThriftException *e) {
        NSString *errorString = e.displayMessage;
        
        switch (e.typeCode) {
            case ThriftExceptionType_SERVICE_VERSION_MISMATCH: {
                if (errorString == nil || [errorString isEqualToString:@""]) {
                    errorString = NSLocalizedString(@"VERSION_DEPRECATED", @"");
                }
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:errorString message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"UPDATE", @""), nil];
                [alert show];
                break;
            }
                
            case ThriftExceptionType_AUTHENTICATION_FAILED: {
                WrongCredentialsViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WrongCredentialsViewController"];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
                
            case ThriftExceptionType_UNDEFINED: {
                if (errorString == nil || [errorString isEqualToString:@""]) {
                    errorString = NSLocalizedString(@"UNDEFINED_EXCEPTION", @"");
                }
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:errorString message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"RETRY", @""), NSLocalizedString(@"QUIT", @""), nil];
                [alert show];
                break;
            }
                
            default:
                break;
        }
    } @catch(ConnectionUnreachableException *e) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"CONNECTION_FAILED", @"") message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"QUIT", @""), nil];
        [alert show];
    }
}

-(IBAction)showCitySelector:(id)sender {
    [self.phone resignFirstResponder];
    [self.identifier resignFirstResponder];
    CitiesViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CitiesViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:NAME_CODE] == nil) {
        [self.code setTitle:NSLocalizedString(@"CODE", @"") forState:UIControlStateNormal];
        [self.code setTitle:NSLocalizedString(@"CODE", @"") forState:UIControlStateHighlighted];
    }else {
        [self.code setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:NAME_CODE] forState:UIControlStateNormal];
        [self.code setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:NAME_CODE] forState:UIControlStateHighlighted];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)moveTextViewForKeyboard:(NSNotification*)aNotification up:(BOOL)up {
    NSDictionary* userInfo = [aNotification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    CGRect newFrame = self.login.frame;
    if (up) {
        newFrame.origin.y = newFrame.origin.y - keyboardEndFrame.size.height;
    } else {
        newFrame.origin.y = newFrame.origin.y + keyboardEndFrame.size.height;
    }
    self.login.frame = newFrame;
    
    [UIView commitAnimations];
}


- (void)keyboardWillShown:(NSNotification*)aNotification {
    [self moveTextViewForKeyboard:aNotification up:YES];
}

- (void)keyboardWillHide:(NSNotification*)aNotification {
    [self moveTextViewForKeyboard:aNotification up:NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.phone) {
        [self.identifier becomeFirstResponder];
    } else if (textField == self.identifier) {
        [self.identifier resignFirstResponder];
    }
    return YES;
}

@end
