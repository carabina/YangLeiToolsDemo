
//
//  YLSystemHeader.h
//  CheckTheUpdate
//
//  Created by yangLei on 16/6/5.
//  Copyright © 2016年 yl. All rights reserved.
//


#if 0
#define k_debug_color UIColor clearColor]   // 1  执行此句
#else
#define k_debug_color [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0]
#endif



#define k_screen_width [UIScreen mainScreen].bounds.size.width 
#define k_screen_height [UIScreen mainScreen].bounds.size.height



#define k_width_scale k_screen_width/320
#define k_height_scale k_screen_height/568





