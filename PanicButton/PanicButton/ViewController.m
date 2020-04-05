//
//  ViewController.m
//  PanicButton
//
//  Created by Елена Грачева on 02.04.15.
//  Copyright (c) 2015 BACCA. All rights reserved.
//

#import "ViewController.h"
#import "Const.h"
#import "LoginViewController.h"
#import "SynchroService.h"
#import "ConnectionUnreachableException.h"
#import "Alert.h"


@interface ViewController () {
    
    BOOL panicSent;
    NSDate *released;
    NSString *url;
    CLLocationManager *locationManager;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sendPing];
    
    panicSent = NO;
    released = nil;
    self.timeLabel.text = NSLocalizedString(@"THREE_SECONDS", @"");
    if ( [[NSUserDefaults standardUserDefaults] objectForKey:NAME_CODE] == nil || [[NSUserDefaults standardUserDefaults] objectForKey:NAME_PHONE] == nil || [[NSUserDefaults standardUserDefaults] objectForKey:NAME_SYSTEM_ID] == nil ) {
        [self showLogin];
    } else {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
        locationManager.delegate = self;
        [locationManager startUpdatingLocation];
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)sendPing {
    @try {
        AlertThriftThriftPingResponse *pingResponse = [SynchroService ping];
        if (pingResponse.newVersionAvailable) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"VERSION_UNSUPPORTED", @"") message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"UPDATE", @""), NSLocalizedString(@"QUIT", @""), nil];
            alert.tag = ThriftExceptionType_SERVICE_VERSION_MISMATCH;
            url = pingResponse.updateUrl;
            [alert show];
        }
    } @catch (AlertThriftThriftException *exception) {
        switch (exception.typeCode) {
            case ThriftExceptionType_SERVICE_VERSION_MISMATCH: {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"VERSION_DEPRECATED", @"") message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"UPDATE", @""), nil];
                alert.tag = ThriftExceptionType_SERVICE_VERSION_MISMATCH;
                url = exception.url;
                [alert show];
                break;
            }
            case ThriftExceptionType_UNDEFINED: {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"UNDEFINED_EXCEPTION", @"") message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"RETRY", @""), nil];
                alert.tag = ThriftExceptionType_UNDEFINED;
                [alert show];
                break;
            }
            default:
                break;
        }
    } @catch (ConnectionUnreachableException *exception) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"CONNECTION_FAILED", @"") message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"RETRY", @""), nil];
        alert.tag = ThriftExceptionType_UNDEFINED;
        [alert show];
    }
}

-(void)showLogin {
    LoginViewController *login = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.navigationController pushViewController:login animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)panicPressed:(id)sender {
    NSDate *date = [NSDate date];
    released = date;
    [self performSelector:@selector(firstSecond:) withObject:date afterDelay:1];
}

-(IBAction)panicReleased:(id)sender {
    released = nil;
    if ( !panicSent ) {
        [self.panic setBackgroundImage:[UIImage imageNamed:@"ButtonActive"] forState:UIControlStateNormal];
        self.timeLabel.text = NSLocalizedString(@"THREE_SECONDS", @"");
    }
    [self.panic setImage:[UIImage imageNamed:@"ProcessingOne"] forState:UIControlStateHighlighted];
}

-(void)firstSecond:(NSDate *)date {
    if ( released == nil || ![released isEqualToDate:date] ) {
        return;
    }
    [self.panic setImage:[UIImage imageNamed:@"ProcessingTwo"] forState:UIControlStateHighlighted];
    self.timeLabel.text = NSLocalizedString(@"TWO_SECONDS", @"");
    [self performSelector:@selector(secondSecond:) withObject:date afterDelay:1];
}

-(void)secondSecond:(NSDate *)date {
    if ( released == nil || ![released isEqualToDate:date] ) {
        return;
    }
    [self.panic setImage:[UIImage imageNamed:@"ProcessingThree"] forState:UIControlStateHighlighted];
    self.timeLabel.text = NSLocalizedString(@"ONE_SECOND", @"");
    [self performSelector:@selector(thirdSecond:) withObject:date afterDelay:1];
}

-(void)thirdSecond:(NSDate *)date {
    if ( released == nil || ![released isEqualToDate:date] ) {
        return;
    }
    self.panic.userInteractionEnabled = NO;
    [self sendPanic];
}

-(void)sendPanic {
    @try {
        [SynchroService alert];
        [self.panic setBackgroundImage:[UIImage imageNamed:@"ButtonSucceeded"] forState:UIControlStateNormal];
        [self.panic setBackgroundImage:[UIImage imageNamed:@"ButtonSucceeded"] forState:UIControlStateHighlighted];
        [self.panic setImage:[UIImage imageNamed:nil] forState:UIControlStateHighlighted];
        self.timeLabel.text = NSLocalizedString(@"MESSAGE_SENT", @"");
        panicSent = YES;
        [self performSelector:@selector(pauseFinished) withObject:nil afterDelay:2];
    } @catch(ConnectionUnreachableException *ex) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"CONNECTION_FAILED", @"") message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"QUIT", @""), nil];
        [alert show];
        [self pauseFinished];
    } @catch(AlertThriftThriftException *exception) {
        switch (exception.typeCode) {
            case ThriftExceptionType_SERVICE_VERSION_MISMATCH: {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"VERSION_DEPRECATED", @"") message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"UPDATE", @""), nil];
                alert.tag = ThriftExceptionType_SERVICE_VERSION_MISMATCH;
                url = exception.url;
                [alert show];
                break;
            }
            case ThriftExceptionType_AUTHENTICATION_FAILED: {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"AUTHENTICATION_FAILED", @"") message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"QUIT", @""), nil];
                alert.tag = ThriftExceptionType_AUTHENTICATION_FAILED;
                [alert show];
                break;
            }
            case ThriftExceptionType_UNDEFINED: {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"UNDEFINED_EXCEPTION", @"") message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"QUIT", @""), nil];
                [alert show];
                break;
            }
            default:
                break;
        }
        [self pauseFinished];
    }
}

-(void)pauseFinished {
    [self.panic setBackgroundImage:[UIImage imageNamed:@"ButtonActive"] forState:UIControlStateNormal];
    [self.panic setBackgroundImage:[UIImage imageNamed:@"ButtonProcessed"] forState:UIControlStateHighlighted];
    self.timeLabel.text = NSLocalizedString(@"THREE_SECONDS", @"");
    self.panic.userInteractionEnabled = YES;
    panicSent = NO;
}

-(IBAction)phone:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://+74955802688"]];
}


#pragma mark -
#pragma mark Alert View Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == ThriftExceptionType_UNDEFINED) {
        if (buttonIndex == 0) {
            [self sendPing];
        }
    } else if (alertView.tag == ThriftExceptionType_AUTHENTICATION_FAILED) {
        if (buttonIndex == 0) {
            [self showLogin];
        }
    } else if (alertView.tag == ThriftExceptionType_SERVICE_VERSION_MISMATCH) {
        if (buttonIndex == 0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }
    }
}

#pragma mark -
#pragma mark Location Manager Delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithDouble:manager.location.coordinate.latitude] forKey:NAME_LATITUDE];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithDouble:manager.location.coordinate.longtitude] forKey:NAME_LONGTITUDE];
}


@end
