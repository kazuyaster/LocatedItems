//
//  ASXLocatedItemsWebViewController.m
//  LocatedItems
//
//  Created by koda on 2014/03/12.
//  Copyright (c) 2014年 Asterisk. All rights reserved.
//

#import "ASXLocatedItemsWebViewController.h"

@interface ASXLocatedItemsWebViewController ()

@end

@implementation ASXLocatedItemsWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    NSString *urlString = [NSString stringWithFormat:@"http://newtonworks.sakura.ne.jp/wp/LocatedItems/%02d-%02d",_majorNumber.intValue,_minorNumber.intValue];
    [_webView loadRequest:[NSURL URLWithString:urlString]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
