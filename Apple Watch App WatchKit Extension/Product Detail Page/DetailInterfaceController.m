//
//  DetailInterfaceController.m
//  iWatchPOC
//
//  Created by annapurna chandra on 28/04/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

#import "DetailInterfaceController.h"

@interface DetailInterfaceController (){
    NSInteger count;
    NSMutableDictionary *detailDictionary;
}

@end

@implementation DetailInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    if ([context isKindOfClass:[NSDictionary class]]) {
        self.delegate = [context objectForKey:@"delegate"];
        detailDictionary = [[NSMutableDictionary alloc]initWithDictionary:[context objectForKey:@"data"]];
      
    }
    count = [[detailDictionary objectForKey:@"count"]integerValue];
    [self.resultLabel setText:[NSString stringWithFormat:@"%d",count]];
    [self.titleLabel setText:[NSString stringWithFormat:@"%@ Units Sold",[detailDictionary objectForKey:@"productName"]]];
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];

}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

-(IBAction)addButtonAction:(id)sender{
    count++;
    [self.resultLabel setText:[NSString stringWithFormat:@"%d",count]];
}

-(IBAction)substractButtonAction:(id)sender{
    if (count == 0) {
        return;
    }
    count--;
    [self.resultLabel setText:[NSString stringWithFormat:@"%d",count]];
    
}

-(IBAction)saveButtonAction:(id)sender{
    [self updateValue];
}

-(void)updateValue{
    //Send count to parent application
    NSString *counterString = [NSString stringWithFormat:@"%d", count];
    [detailDictionary setObject:counterString forKey:@"count"];
    [self.delegate updateCountData:detailDictionary];
    [self popController];

//    WKAlertAction *action =
//    [WKAlertAction actionWithTitle:@"OK"
//                             style:WKAlertActionStyleDefault
//     
//                           handler:^{
//                               // do something after OK is clicked
//                           }];
//    NSString *message = [NSString stringWithFormat:@"%@ data has been saved.",[detailDictionary objectForKey:@"productName"]];
//    [self presentAlertControllerWithTitle:nil message:message preferredStyle:WKAlertControllerStyleAlert actions:@[ action ]];
}


-(void)handleUserActivity:(NSDictionary *)userInfo{
    
}

@end



