//
//  InterfaceController.m
//  Apple Watch App WatchKit Extension
//
//  Created by Deepankar Srivastava on 9/25/17.
//  Copyright © 2017 Deepankar Srivastava. All rights reserved.
//

#import "InterfaceController.h"


#import "ProductDetails.h"

@interface InterfaceController(){
    NSArray             *productName;
    NSMutableDictionary *productDetails;
}

@property(nonatomic, weak)IBOutlet WKInterfaceTable *productTable;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    productName = [[NSArray alloc]initWithObjects:@"Apple Watch",@"iPad",@"iPhone",@"iPod",@"Mac", nil];
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.apple.ist.RZMWatch"];
    NSDictionary *tempDic = [NSDictionary dictionaryWithDictionary:[defaults objectForKey:@"iWatchData"]];
    if ([[tempDic allKeys]count] != 0 || tempDic == nil) {
        
        productDetails = [[NSMutableDictionary alloc]initWithDictionary:tempDic];
        
    }else{
        productDetails = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"0",@"Apple Watch",@"0",@"iPad",@"0",@"iPhone",@"0",@"iPod",@"0",@"Mac",nil];
    }
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    if ([WCSession isSupported]) {
        WCSession *session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
    [self configureTableWithData:productName];
    [self updateUserActivity:@"group.com.apple.ist.WatchTestApp" userInfo:@{@"yo": @"dawg"} webpageURL:nil];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    [self invalidateUserActivity];
}

#pragma mark WKInterfaceTable delegate method

-(void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex{
    NSMutableDictionary *dataDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:[productDetails objectForKey:[productName objectAtIndex:rowIndex]],@"count",[productName objectAtIndex:rowIndex],@"productName", nil];
    [self pushControllerWithName:@"DetailInterfaceController" context:@{@"delegate" : self,@"data":dataDictionary}];
}

#pragma mark local methods

- (void)configureTableWithData:(NSArray*)dataObjects {
    [self.productTable setNumberOfRows:[dataObjects count] withRowType:@"ProductDetails"];
    
    for (NSInteger i = 0; i < self.productTable.numberOfRows; i++) {
        ProductDetails* theRow = [self.productTable rowControllerAtIndex:i];
        [theRow.productName setText:[productName objectAtIndex:i]];
        [theRow.productCount setText:[productDetails objectForKey:[productName objectAtIndex:i]]];
    }
}

-(void)updateCountData:(NSDictionary *)dataDictionary{
    [productDetails setObject:[dataDictionary objectForKey:@"count"] forKey:[dataDictionary objectForKey:@"productName"]];
    
    //save data
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.apple.ist.RZMWatch"];
    [defaults setObject:productDetails forKey:@"iWatchData"];
    
    [self shareData];
    [self.productTable setNumberOfRows:[productName count] withRowType:@"ProductDetails"];
}

-(void)shareData{
    [[WCSession defaultSession] sendMessage:productDetails replyHandler:^(NSDictionary *reply) {
        //handle reply from iPhone app here
    }
                               errorHandler:^(NSError *error) {
                                   //catch any errors here
                               }
     ];
    
}

#pragma mark WCSession method

- (void)sessionReachabilityDidChange:(WCSession *)session{
    [self shareData];
}

-(void)handleUserActivity:(NSDictionary *)userInfo{
    
}

@end



