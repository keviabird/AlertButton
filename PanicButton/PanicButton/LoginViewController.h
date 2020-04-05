//
//  LoginViewController.h
//  PanicButton
//
//  Created by Елена Грачева on 03.04.15.
//  Copyright (c) 2015 BACCA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property(weak) IBOutlet UIButton *code;
@property(weak) IBOutlet UITextField *phone;
@property(weak) IBOutlet UITextField *identifier;
@property(weak) IBOutlet UILabel *enterPhoneTitle;
@property(weak) IBOutlet UILabel *enterIdTitle;
@property(weak) IBOutlet UIButton *login;

-(IBAction)showCitySelector:(id)sender;
-(IBAction)login:(id)sender;

@end
