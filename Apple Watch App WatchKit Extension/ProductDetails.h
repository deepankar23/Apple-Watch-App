//
//  ProductDetails.h
//  iWatchPOC
//
//  Created by annapurna chandra on 27/04/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>

@interface ProductDetails : NSObject

@property(nonatomic, weak)IBOutlet WKInterfaceLabel *productName;
@property(nonatomic, weak)IBOutlet WKInterfaceLabel *productCount;

@end
