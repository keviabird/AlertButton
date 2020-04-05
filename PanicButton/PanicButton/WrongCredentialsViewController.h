//
//  WrongCredentialsViewController.h
//  PanicButton
//
//  Created by Елена Грачева on 08.04.15.
//  Copyright (c) 2015 BACCA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WrongCredentialsViewController : UIViewController

@property(weak) IBOutlet UILabel *titleLabel;
@property(weak) IBOutlet UITextView *text;
@property(weak) IBOutlet UIButton *close;

-(IBAction)close:(id)sender;

@end
