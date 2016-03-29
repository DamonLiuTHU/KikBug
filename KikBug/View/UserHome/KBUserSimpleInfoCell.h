//
//  KBUserSimpleInfoCell.h
//  
//
//  Created by DamonLiu on 16/3/28.
//
//

#import "KBBaseTableViewCell.h"

@interface KBUserSimpleInfoCell : KBBaseTableViewCell
@property (strong,nonatomic) UIImageView *headIcon;
@property (strong,nonatomic) UILabel *accountNumber;
@property (strong,nonatomic) UILabel *userName;
@property (strong,nonatomic) UIImageView *arrowImage;
//@property (strong,nonatomic) UILabel *accountNumberHint;
//@property (strong,nonatomic) UILabel *userNameHint;
@end
