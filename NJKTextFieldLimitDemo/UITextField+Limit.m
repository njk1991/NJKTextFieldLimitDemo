//
//  UITextField+Limit.m
//  NJKTextFieldLimitDemo
//
//  Created by JiakaiNong on 15/12/24.
//  Copyright © 2015年 poco. All rights reserved.
//

#import "UITextField+Limit.h"
#import <objc/runtime.h>

@implementation UITextField (Limit)

static NSString *kLimitTextLengthKey = @"kLimitTextLengthKey";
- (BOOL)limitTextLength:(NSInteger)length {
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    // 不在输入状态下
    if (!position) {
        return [self handleChineseStringWithLimitLength:length];
    } else {
        return YES;
    }
}

- (BOOL)handleChineseStringWithLimitLength:(NSInteger)limitLength {
    NSString *text = [self text];
    NSInteger currentLength = 0;
    NSInteger legalLength = 0;
    NSString *nickNameRegEx = @"[\u4e00-\u9fa5\\w]{1,20}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nickNameRegEx];
    NSString *characterRegEx = @"[^\\x00-\\xff]";
    NSPredicate *characterPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",characterRegEx];
    
    for (NSInteger i = 0; i < text.length; i++) {
        NSString *singleCharacter = [text substringWithRange:NSMakeRange(i , 1)];
        BOOL characterMatch = [characterPredicate evaluateWithObject:singleCharacter];
        if (characterMatch) {
            currentLength +=2;
        } else {
            currentLength +=1;
        }
        if (currentLength > limitLength) {
            break;
        }
        legalLength++;
    }
    //    NSLog(@"%@",@(currentLength));
    if (legalLength > limitLength) {
        legalLength = limitLength;
    }
    NSString *newText = [text substringToIndex:legalLength];
    [self setText:newText];
    
    BOOL match = [predicate evaluateWithObject:newText];
    if (!match) {
        [self setText:@""];
        return NO;
    }
    return YES;
}

@end
