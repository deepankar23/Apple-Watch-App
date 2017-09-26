//
//  ViewController.m
//  Apple Watch App
//
//  Created by Deepankar Srivastava on 9/25/17.
//  Copyright © 2017 Deepankar Srivastava. All rights reserved.
//

#import "ViewController.h"

#import "ProductDetailTableViewCell.h"

@interface ViewController (){
    NSMutableDictionary *productDetails;
    NSArray             *productName;
    WCSession           *session;
}
@property(nonatomic,weak)IBOutlet UITableView *productTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    NSDictionary *tempDic = [NSDictionary dictionaryWithDictionary:[defaults objectForKey:@"iWatchData"]];
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.apple.ist.RZMWatch"];
    NSDictionary *tempDic = [NSDictionary dictionaryWithDictionary:[defaults objectForKey:@"iWatchData"]];
    if ([[tempDic allKeys]count] != 0 || tempDic == nil) {
        
        productDetails = [[NSMutableDictionary alloc]initWithDictionary:tempDic];
        
    }else{
        productDetails = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"0",@"Apple Watch",@"0",@"iPad",@"0",@"iPhone",@"0",@"iPod",@"0",@"Mac",nil];
    }
    
    
    self.productTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    productName = [[NSArray alloc]initWithObjects:@"Apple Watch",@"iPad",@"iPhone",@"iPod",@"Mac", nil];
    
    if ([WCSession isSupported]) {
        session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableview methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[productDetails allKeys]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductDetailTableViewCell"];
    if (cell == nil) {
        cell = [[ProductDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProductDetailTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.productName setText:[productName objectAtIndex:indexPath.row]];
    [cell.productCount setText:[productDetails objectForKey:[productName objectAtIndex:indexPath.row]]];
    return cell;
}

#pragma mark WCSession delegate

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message replyHandler:(void(^)(NSDictionary<NSString *, id> *replyMessage))replyHandler{
    
    //Use this to update the UI instantaneously (otherwise, takes a little while)
    dispatch_async(dispatch_get_main_queue(), ^{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:message forKey:@"iWatchData"];
        
        [productDetails removeAllObjects];
        [productDetails addEntriesFromDictionary:message];
        [self.productTableView reloadData];
    });
}

-(void)restoreUserActivityState:(NSUserActivity *)activity{
    
}

@end
