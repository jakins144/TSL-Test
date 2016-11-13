//
//  PlayListTableViewCell.h
//  TSL App Test
//
//  Created by Owner on 11/10/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *playListImageView;
@property (weak, nonatomic) IBOutlet UILabel *playListTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *songAmountLabel;

@end
