//
//  WrongCredentialsViewController.m
//  PanicButton
//
//  Created by Елена Грачева on 08.04.15.
//  Copyright (c) 2015 BACCA. All rights reserved.
//

#import "WrongCredentialsViewController.h"

@interface WrongCredentialsViewController ()

@end

@implementation WrongCredentialsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = NSLocalizedString(@"AUTHENTICATION_FAILED", @"");
    self.text.text = NSLocalizedString(@"OUR_CONTACTS", @"");
    [self.close setTitle:NSLocalizedString(@"QUIT", @"") forState:UIControlStateNormal];
    [self.close setTitle:NSLocalizedString(@"QUIT", @"") forState:UIControlStateHighlighted];
}

-(IBAction)close:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
