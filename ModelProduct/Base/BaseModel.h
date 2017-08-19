//
//  BaseModel.h
//  WoVPNStore
//
//  Created by apple on 2017/8/8.
//  Copyright © 2017年 YQL. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BaseModel : JSONModel

@property (nonatomic, strong) NSString *error;
@property  (strong,nonatomic) NSString <Optional>*msg;

@end
