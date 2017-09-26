//
//  ProductDetailTableViewCell.h
//  iWatchPOC
//
//  Created by annapurna chandra on 28/04/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailTableViewCell : UITableViewCell

@property(nonatomic, weak)IBOutlet UILabel *productName;
@property(nonatomic, weak)IBOutlet UILabel *productCount;

@end
