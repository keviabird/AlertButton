//
//  CititesViewController.h
//  PanicButton
//
//  Created by Елена Грачева on 06.04.15.
//  Copyright (c) 2015 BACCA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CitiesViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property(weak) IBOutlet UILabel *titleLabel;
@property(weak) IBOutlet UITableView *tableView;

-(IBAction)back:(id)sender;

@end
