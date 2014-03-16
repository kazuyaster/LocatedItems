//
//  ASXMainViewController.h
//  LocatedItems
//
//  Created by koda on 2014/03/12.
//  Copyright (c) 2014年 Asterisk. All rights reserved.
//

#import "ASXFlipsideViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>


@interface ASXMainViewController : UIViewController <ASXFlipsideViewControllerDelegate,CBPeripheralManagerDelegate,UITextFieldDelegate>
@end
