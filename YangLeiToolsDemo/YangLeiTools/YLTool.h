//
//  YLTool.h
//  YangLeiToolsDemo
//
//  Created by dev1 on 2016/10/26.
//  Copyright © 2016年 dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YLTool : NSObject

/**
 *  十六进制颜色值转换成UIColor对象
 *  @param stringToConvert 十六进制颜色值
 *  @return UIColor 对象
 */
+ (UIColor *)hexStringToColor:(NSString *)stringToConvert;




/**
 *  使用UIColor创建UIImage
 *  @param color 颜色
 *  @return UIImage 对象
 */
+ (UIImage *)createImageWithColor:(UIColor *)color;




/**
 *  把汉字转为拼音
 *  @param string 要转换的汉字
 *  @return 拼音
 */
+ (NSString *)transformMandarinToLatin:(NSString *)string;




/**
 *  改变一段文字里某些字的颜色(数组的格式很重要，否则会崩,好像只有UILabel有效果)
 *  @param str   要改变颜色的str
 *  @param array    格式（颜色，从第几个字开始，几个字）
 NSArray * arr = @[@[[UIColor redColor],@"2",@"3"],@[[UIColor orangeColor],@"8",@"1"],@[[UIColor yellowColor],@"14",@"5"]];
 *  @return NSMutableAttributedString 对象
 */
+ (NSMutableAttributedString *)changeStringColor:(NSString *)str colorAndRangeArray:(NSArray *)array;





/**
 *  计算文本的高度(系统默认字号  17.0)
 *  @param str   文本
 *  @param font  文本字号
 *  @param width 显示文本的限定宽度
 *  @return 文本高度
 */
+ (CGFloat)labelContentTextHeight:(NSString *)str textFont:(CGFloat)font width:(CGFloat)width;




/**
 *  得到caches里文件的完整路径(没有此文件时返回nil)
 *  @param fileName 文件名
 *  @return 在caches文件夹里的文件的完整路径
 */
+ (NSString *)getFilePathInCaches:(NSString *)fileName;




/**
 *  文件夹  大小（单位 MB）
 *  @param folderPath 文件夹路径
 *  @return 文件夹大小
 */
+ (CGFloat)folderSizeAtPath:(NSString *)folderPath;




/**
 *  文件  大小 （单位 MB）
 *  @param filePath  文件路径
 *  @return 文件大小
 */
+ (CGFloat)fileSizeAtPath:(NSString *)filePath;





/**
 *  弹出 ActionSheet(styleInteg=0) 或  AlertView(styleInteg=1)
 *  @param styleInteg ---0 ActionSheet    1  AlertView
 *  @param title      标题
 *  @param mess       信息
 *  @param butAarray  按钮的标题
 *  @param clickBut   点击按钮的回调
 *  @param tagetVC    显示在哪个vc上
 */
+ (void)alertControllerWithStyle:(NSInteger)styleInteg title:(NSString *)title message:(NSString *)mess butTitleArray:(NSArray *)butAarray clickBut:(void (^) (NSString *))clickBut tagetVC:(UIViewController *)tagetVC;





/**
 *  图片保存到本地后图片旋转90度的解决办法
 *  @param aImage <#aImage description#>
 *  @return <#return value description#>
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage;




/**
 *  压缩本地磁盘图片（压缩好的图片覆盖原图片）
 *  @param imagePath       要被压缩的图片的路径
 *  @param scale           压缩系数，范围0-1 数字越小图片越模糊（改变图片的分辨率）
 *  @param targetImageWidth 压缩图片到多宽  （改变图片宽度，等比例的）
 */
+ (void)compressedImageWithPath:(NSString *)imagePath scale:(CGFloat)scale targetWidth:(NSInteger )targetImageWidth;




/**
 *  这个月有几天
 *  @param date <#date description#>
 *  @return <#return value description#>
 */
+ (NSInteger)dayNumberInThisMonth:(NSDate *)date;




/**
 *  这个月的第一天是周几
 *  @param date <#date description#>
 *  @return <#return value description#>
 */
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;








//**************************    AFNetworking   ************************//

/**
 *  get  和  post  的网络请求
 *  @param methodStr  请求类型（get／post）
 *  @param urlStr     url
 *  @param paramDic   post参数
 *  @param successful 请求成功回调
 *  @param fail       请求失败回调
 */
+ (void)requestWithMethod:(NSString *)methodStr url:(NSString *)urlStr param:(NSDictionary *)paramDic successfulBlock:(void (^) (id))successful failBlock:(void (^) (id))fail;





/**
 *  上传图片或文件
 *
 *  @param urlStr             服务器urlstr
 *  @param parameters         参数
 *  @param keyName            与指定的图片/文件相关联的名称，这是由后端写接口的人指定的，如imagefiles
 *  @param mimeType           图片（image/jpeg   image/png）
 .aac文件（audio/x-aac）
 *  @param path               要上传的图片或文件的路径
 *  @param uploadFinishName   先是在服务器的名字
 *  @param uploadFileProgress 上传进度
 *  @param successful         上传成功的回调
 *  @param fail               上传失败的回调
 */
+ (void)uploadUrlStr:(NSString *)urlStr parameters:(NSDictionary *)parameters keyName:(NSString *)keyName mimeType:(NSString *)mimeType targetPath:(NSString *)path uploadFinishName:(NSString *)uploadFinishName uploadFileProgress:(void (^) (int64_t))uploadFileProgress successfulBlock:(void (^) (id))successful failBlock:(void (^) (id))fail;






/**
 *  下载文件
 *  @param urlStr     服务器url
 *  @param downToPath 下载文件到哪里
 *  @param downLoadFileProgress 下载文件进度回调
 *  @param successful 下载成功回调 返回文件路径
 *  @param fail       下载失败回调
 */
+ (void)downLoadFileWithUrl:(NSString *)urlStr downToPath:(NSString *)downToPath downLoadFileProgress:(void (^) (int64_t))downLoadFileProgress successfulBlock:(void (^) (id))successful failBlock:(void (^) (id))fail;






//**************************    SVProgressHUD   ************************//

/**
 *  显示 加载中菊花
 */
+ (void)showMBProgressHUD;




/**
 *  移除  加载中菊花
 */
+ (void)removeMBProgressHUD;





@end

//**************************    UIView扩展   ************************//

@interface UIView (YLViewCategory)

@property(nonatomic,assign)CGFloat left;
@property(nonatomic,assign)CGFloat top;
@property(nonatomic,assign)CGFloat right;
@property(nonatomic,assign)CGFloat bottom;

@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;

@property(nonatomic,assign)CGFloat centerX;
@property(nonatomic,assign)CGFloat centerY;




@end
