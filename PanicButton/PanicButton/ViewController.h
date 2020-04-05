//
//  ViewController.h
//  PanicButton
//
//  Created by Елена Грачева on 02.04.15.
//  Copyright (c) 2015 BACCA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <UIAlertViewDelegate, CLLocationManagerDelegate>

@property(weak,nonatomic) IBOutlet UIButton *panic;
@property(weak,nonatomic) IBOutlet UILabel *timeLabel;

-(IBAction)panicPressed:(id)sender;
-(IBAction)panicReleased:(id)sender;
-(IBAction)phone:(id)sender;

@end

