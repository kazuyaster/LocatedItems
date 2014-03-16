//
//  ASXFlipsideViewController.m
//  LocatedItems
//
//  Created by koda on 2014/03/12.
//  Copyright (c) 2014年 Asterisk. All rights reserved.
//

#import "ASXFlipsideViewController.h"
#import "ASXLocatedItemsWebViewController.h"


@interface ASXFlipsideViewController ()<CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    CLLocationManager *_locationManager;
    NSUUID *_uuid;
    CLBeaconRegion *_region;
    NSMutableArray *_beacons;
    BOOL _showingWebPage;
    NSNumber *_webMajourNumber;
    NSNumber *_webMinorNumber;
}

@end

@implementation ASXFlipsideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _uuid = [[NSUUID alloc] initWithUUIDString:@"580730F6-ECB0-4E94-B7A2-29D434C7ACF6"];
    _region = [[CLBeaconRegion alloc] initWithProximityUUID:_uuid identifier:[_uuid UUIDString]];
    _locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    
    _beacons = [[NSMutableArray alloc]init];
    _showingWebPage = NO;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_locationManager startRangingBeaconsInRegion:_region];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_locationManager stopRangingBeaconsInRegion:_region];
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

#pragma mark - Beacon job
- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region{

    [_beacons removeAllObjects];
    [_beacons addObject:beacons];
    
    [self.tableView reloadData];
    
    __block int immediateCount = 0;
    [_beacons enumerateObjectsUsingBlock:^(CLBeacon *obj, NSUInteger idx, BOOL *stop) {
        if (obj.proximity == CLProximityImmediate) {
            immediateCount++;
            //TODO: WEB開く
        }
    }];
    
    if (immediateCount == 0){
        //TODO: WEB閉じる
    }
}

#pragma mark - TableView job
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _beacons.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdntifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdntifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdntifier];
    }
    
    CLBeacon *beacon = _beacons[indexPath.row];
    NSString *prox;
    switch (beacon.proximity) {
        case CLProximityImmediate:
            prox = @"Immediate";
            break;
        case CLProximityNear:
            prox = @"Near";
            break;
        case CLProximityFar:
            prox = @"Far";
            break;
        case CLProximityUnknown:
            prox = @"Unknown";
            break;
    }
    cell.textLabel.text = [beacon.proximityUUID UUIDString];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Major:%@, Minor:%@, Prox:%@, Acc:%.2fm",beacon.major,beacon.minor,prox,beacon.accuracy];
    return cell;
}

#pragma mark - WEb Page job
- (void)openWebPageMajor:(NSNumber*)majorNumber minor:(NSNumber*)minorNumber{
    if (_showingWebPage == NO) {
        _webMajourNumber = majorNumber;
        _webMinorNumber = minorNumber;
        [self performSegueWithIdentifier:@"showWebPage" sender:self];
        _showingWebPage = YES;
        NSLog(@"show web page of %02d - %02d",majorNumber.intValue,minorNumber.intValue);
    }
}

- (void)closeWebPage{
    if (_showingWebPage == YES) {
        [self dismissViewControllerAnimated:YES completion:nil];
        _showingWebPage = NO;
        NSLog(@"Hide Web Page.");
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showWebPage"]) {
        ASXLocatedItemsWebViewController *nextViewController = [[ASXLocatedItemsWebViewController alloc]init];
        nextViewController.majorNumber = _webMajourNumber;
        nextViewController.minorNumber = _webMinorNumber;
    }
}




@end
