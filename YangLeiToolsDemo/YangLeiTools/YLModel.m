//
//  YLModel.m
//  YangLeiToolsDemo
//
//  Created by dev1 on 2016/10/26.
//  Copyright © 2016年 dev. All rights reserved.
//

#import "YLModel.h"

@implementation YLModel

- (id)initWithDic:(NSDictionary *)dataDic
{
    if([super init])
        [self setValuesForKeysWithDictionary:dataDic];
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

@end
