//
//  ASXMainViewController.m
//  LocatedItems
//
//  Created by koda on 2014/03/12.
//  Copyright (c) 2014年 Asterisk. All rights reserved.
//

#import "ASXMainViewController.h"

@interface ASXMainViewController (){
    CBPeripheralManager *_peripheralManager;
}
@property (weak, nonatomic) IBOutlet UITextField *majourNumber;
@property (weak, nonatomic) IBOutlet UITextField *minorNumber;
@end

NSString *const kIdentifier = @"identifer";

@implementation ASXMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _peripheralManager = [[CBPeripheralManager alloc]initWithDelegate:self queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
}

- (void)viewDidAppear:(BOOL)animated{
    [self getBeaconID];
    [self beaconing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Beacon job
- (void)beaconing:(BOOL)flag{
//    NSUUID *uuid = [[NSUUID alloc]initWithUUIDString:@"580730F6-ECB0-4E94-B7A2-29D434C7ACF6"];
//    
//    CLBeaconRegion *region = [[CLBeaconRegion alloc]initWithProximityUUID:uuid
//                                                                    major:_majourNumber.text.intValue
//                                                                    minor:_minorNumber.text.intValue
//                                                               identifier:kIdentifier];
//    
//    NSDictionary *peripheralData = [region peripheralDataWithMeasuredPower:nil];
//    
//    if(flag){
//        [_peripheralManager startAdvertising:peripheralData];
//        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
//    }else{
//        [_peripheralManager stopAdvertising];
//        [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
//    }
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
    
    NSUUID *uuid = [[NSUUID alloc]initWithUUIDString:@"580730F6-ECB0-4E94-B7A2-29D434C7ACF6"];
    
    CLBeaconRegion *region = [[CLBeaconRegion alloc]initWithProximityUUID:uuid
                                                                    major:_majourNumber.text.intValue
                                                                    minor:_minorNumber.text.intValue
                                                               identifier:kIdentifier];
    
    NSDictionary *peripheralData = [region peripheralDataWithMeasuredPower:nil];
    
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        NSLog(@"Powered On");
        [_peripheralManager startAdvertising:peripheralData];
    } else if (peripheral.state == CBPeripheralManagerStatePoweredOff) {
        NSLog(@"Powered Off");
        [_peripheralManager stopAdvertising];
    }
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(ASXFlipsideViewController *)controller
{
    [self beaconing:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

#pragma mark - Major/Minor edit
- (IBAction)majourEditEnd:(id)sender {
    [self beaconing:NO];
    [self beaconing:YES];
    [self setBeaconID];
}

- (IBAction)minorEditEnd:(id)sender {
    [self beaconing:NO];
    [self beaconing:YES];
    [self setBeaconID];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

- (void)setBeaconID{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_majourNumber.text forKey:@"majourNumber"];
    [defaults setObject:_minorNumber.text forKey:@"minorNumber"];
}

- (void)getBeaconID{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *major = [defaults objectForKey:@"majourNumber"];
    if([major length] > 0 ){
        self.majourNumber.text = major;
    }
    
    NSString *minor = [defaults objectForKey:@"minorNumber"];
    if([minor length] > 0){
        self.minorNumber.text = minor;
    }
}

@end
