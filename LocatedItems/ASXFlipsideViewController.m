//
//  ASXFlipsideViewController.m
//  LocatedItems
//
//  Created by koda on 2014/03/12.
//  Copyright (c) 2014年 Asterisk. All rights reserved.
//

#import "ASXFlipsideViewController.h"


@interface ASXFlipsideViewController ()

@end

@implementation ASXFlipsideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
