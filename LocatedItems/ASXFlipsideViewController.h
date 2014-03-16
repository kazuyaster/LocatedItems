//
//  ASXFlipsideViewController.h
//  LocatedItems
//
//  Created by koda on 2014/03/12.
//  Copyright (c) 2014年 Asterisk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@class ASXFlipsideViewController;


@protocol ASXFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(ASXFlipsideViewController *)controller;
@end

@interface ASXFlipsideViewController : UIViewController

@property (weak, nonatomic) id <ASXFlipsideViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)done:(id)sender;

@end
