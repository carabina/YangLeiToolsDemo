//
//  YLTool.m
//  YangLeiToolsDemo
//
//  Created by dev1 on 2016/10/26.
//  Copyright © 2016年 dev. All rights reserved.
//

#import "YLTool.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"

@implementation YLTool


+ (UIColor *) hexStringToColor: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}




+ (UIImage *)createImageWithColor: (UIColor *)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}




+ (NSString *)transformMandarinToLatin:(NSString *)string
{
    //    用kCFStringTransformMandarinLatin方法转化出来的是带音标的拼音，
    //    如果需要去掉音标，则继续使用kCFStringTransformStripCombiningMarks方法即可。
    
    
    //复制出一个可变的对象//
    NSMutableString *preString = [string mutableCopy];
    //转换成带音 调的拼音//
    CFStringTransform((CFMutableStringRef)preString, NULL, kCFStringTransformMandarinLatin, NO);
    //去掉音调//
    CFStringTransform((CFMutableStringRef)preString, NULL, kCFStringTransformStripDiacritics, NO);
    
    //多音字处理//
    if ([[(NSString *)string substringToIndex:1] compare:@"长"] == NSOrderedSame)
    {
        [preString replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chang"];
    }
    if ([[(NSString *)string substringToIndex:1] compare:@"沈"] == NSOrderedSame)
    {
        [preString replaceCharactersInRange:NSMakeRange(0, 4) withString:@"shen"];
    }
    if ([[(NSString *)string substringToIndex:1] compare:@"厦"] == NSOrderedSame)
    {
        [preString replaceCharactersInRange:NSMakeRange(0, 3) withString:@"xia"];
    }
    if ([[(NSString *)string substringToIndex:1] compare:@"地"] == NSOrderedSame)
    {
        [preString replaceCharactersInRange:NSMakeRange(0, 3) withString:@"di"];
    }
    if ([[(NSString *)string substringToIndex:1] compare:@"重"] == NSOrderedSame)
    {
        [preString replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chong"];
    }
    return preString;
}




+ (NSMutableAttributedString *)changeStringColor:(NSString *)str colorAndRangeArray:(NSArray *)array;
{
    NSMutableAttributedString * changeColorStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    for(int i = 0;i < array.count;i++)
    {
        NSArray * tempArr = array[i];
        
        [changeColorStr addAttribute:NSForegroundColorAttributeName value:tempArr[0] range:NSMakeRange([tempArr[1] integerValue], [tempArr[2] integerValue])];
    }
    return changeColorStr;
}




+ (CGFloat)labelContentTextHeight:(NSString *)str textFont:(CGFloat)font width:(CGFloat)width
{
    NSDictionary * textDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName,nil];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
    return rect.size.height;
}




+ (NSString *)getFilePathInCaches:(NSString *)fileName;
{
    NSString * tempPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:fileName];
    
    NSFileManager * manger = [NSFileManager defaultManager];
    if([manger fileExistsAtPath:tempPath])
        return tempPath;
    else
        return nil;
}




+ (CGFloat)folderSizeAtPath:(NSString *)folderPath
{
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath])
        return 0 ;
    NSEnumerator * childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString * fileName;
    CGFloat folderSize = 0.0 ;
    while((fileName = [childFilesEnumerator nextObject]) != nil)
    {
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    return folderSize;
}




+ (CGFloat)fileSizeAtPath:(NSString *)filePath
{
    NSFileManager * manager = [NSFileManager defaultManager];
    if([manager fileExistsAtPath:filePath])
    {
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize]/1000.0/1000.0;
    }
    return 0 ;
}





+ (void)alertControllerWithStyle:(NSInteger)styleInteg title:(NSString *)title message:(NSString *)mess butTitleArray:(NSArray *)butAarray clickBut:(void (^) (NSString *))clickBut tagetVC:(UIViewController *)tagetVC
{
    UIAlertController * alertV = [UIAlertController alertControllerWithTitle:@"提示" message:mess preferredStyle:styleInteg];
    
    
    for(int i = 0; i < butAarray.count;i++)
    {
        UIAlertAction * action = [UIAlertAction actionWithTitle:butAarray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //        NSLog(@"点击  左边的按钮");
            if(clickBut)
                clickBut(action.title);
        }];
        [alertV addAction:action];
    }
    [tagetVC presentViewController:alertV animated:YES completion:nil];

}





+ (UIImage *)fixOrientation:(UIImage *)aImage
{
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}




+ (void)compressedImageWithPath:(NSString *)imagePath scale:(CGFloat)scale targetWidth:(NSInteger )targetImageWidth
{
    //  把图片进行 压            0.1   压缩系数，范围0-1     数字越小图片越模糊
    UIImage * tempImage = [UIImage imageWithContentsOfFile:imagePath];
    UIImage * getNewImage = nil;
    if(scale == 1)
    {
        getNewImage = tempImage;
    }
    else
    {
        NSData * imageData = UIImageJPEGRepresentation(tempImage, scale);
        getNewImage = [UIImage imageWithData:imageData];
    }
    
    
    //把图片进行 缩
    // 图片的宽和高 改变
    CGSize imageSize = getNewImage.size;
    
    CGFloat width = imageSize.width;
    
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = targetImageWidth;
    
    CGFloat targetHeight = (targetWidth / width) * height;
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    
    [getNewImage drawInRect:CGRectMake(0,0,targetWidth, targetHeight)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    newImage = [self fixOrientation:newImage];
    
    //  把图片写入本地某个路径
    [UIImagePNGRepresentation(newImage) writeToFile:imagePath atomically:YES];
    
}




+ (NSInteger)dayNumberInThisMonth:(NSDate *)date
{
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldaysInMonth.length;
}




+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}







//**************************    AFNetworking   ************************//

+ (void)requestWithMethod:(NSString *)methodStr url:(NSString *)urlStr param:(NSDictionary *)paramDic successfulBlock:(void (^) (id))successful failBlock:(void (^) (id))fail
{
    //1.创建网络状态监测管理者
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    //2.监听改变
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if(status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi)
        {
            // 有网络
            
            //  url进行NSUTF8StringEncoding编码
            NSString * encodingUrlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
            
            if([[methodStr uppercaseString] isEqualToString:@"GET"])
            {
                [sessionManager GET:encodingUrlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                    
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    successful(responseObject);
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    fail([error description]);
                }];
                
            }
            else if ([[methodStr uppercaseString] isEqualToString:@"POST"])
            {
                [sessionManager POST:encodingUrlStr parameters:paramDic progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    successful(responseObject);
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    fail([error description]);
                    
                }];
                
            }
            else
            {
                [self alertControllerWithStyle:1 title:@"提示" message:@"方法类型不是get／post" butTitleArray:@[@"确定"] clickBut:nil];
            }
        }
        else
        {
            
            // 无网络
            [self alertControllerWithStyle:1 title:@"提示" message:@"无网络" butTitleArray:@[@"确定"] clickBut:nil];
        }
        
    }];
    //3.开始监听
    [reachabilityManager startMonitoring];
    
}





+ (void)uploadUrlStr:(NSString *)urlStr parameters:(NSDictionary *)parameters keyName:(NSString *)keyName mimeType:(NSString *)mimeType targetPath:(NSString *)path uploadFinishName:(NSString *)uploadFinishName uploadFileProgress:(void (^) (int64_t))uploadFileProgress successfulBlock:(void (^) (id))successful failBlock:(void (^) (id))fail
{
    //1。创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //  url进行NSUTF8StringEncoding编码
    NSString * encodingUrlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionDataTask * task = [manager POST:encodingUrlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData * fileData = [NSData dataWithContentsOfFile:path];
        
        if(fileData)
        {
            // 上传，以文件流的格式
            [formData appendPartWithFileData:fileData name:keyName fileName:uploadFinishName mimeType:mimeType];
            NSLog(@"目标data存在");
            
        }
        else
        {
            NSLog(@"目标data不存在");
        }
        
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印上传进度
        NSLog(@"上传进度%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        uploadFileProgress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //请求成功
        NSLog(@"上传成功：%@",responseObject);
        successful(responseObject);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //请求失败
        NSLog(@"上传失败：%@",error);
        fail(error);
        
        
    }];
    [task resume];
    
}





+ (void)downLoadFileWithUrl:(NSString *)urlStr downToPath:(NSString *)downToPath downLoadFileProgress:(void (^) (int64_t))downLoadFileProgress successfulBlock:(void (^) (id))successful failBlock:(void (^) (id))fail
{
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    //  url进行NSUTF8StringEncoding编码
    NSString * encodingUrlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //3.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:encodingUrlStr]];
    
    //下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //打印下载进度
        //        NSLog(@"下载进度%lf",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        downLoadFileProgress(downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //下载地址
        NSLog(@"默认下载地址:%@",targetPath);
        
        //设置下载路径，通过沙盒获取缓存地址，最后返回NSURL对象
        return [NSURL fileURLWithPath:downToPath];
        
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        //下载完成调用的方法
        NSLog(@"下载完成：");
        NSLog(@"response%@--filePath%@",response,filePath);
        
        if(error)
            fail(error);
        else
            successful(filePath.absoluteString);
        
    }];
    
    //开始启动任务
    [task resume];
    
}









//**************************    SVProgressHUD   ************************//

+ (void)showMBProgressHUD
{
    [SVProgressHUD showWithStatus:@"加载中"];
    [UIApplication sharedApplication].keyWindow.userInteractionEnabled = NO;
}




+ (void)removeMBProgressHUD
{
    [SVProgressHUD dismiss];
    [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;
}




@end

//**************************    UIView扩展   ************************//

@implementation UIView (YLViewCategory)

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}




@end
