//
//  NSString+Format.m
//  DJkit
//
//  Created by DennisDeng on 2017/4/14.
//  Copyright © 2017年 DennisDeng. All rights reserved.
//
// see https://github.com/fjcaetano/NSStringMask

#import "NSString+Format.h"
#import "NSString+RegEx.h"
#import "NSObject+Category.h"

#define kRESULT_INDEX   0
#define kLENGTH_INDEX   1

#define kDefaultPlaceholder     nil


@implementation NSString (Format)

- (NSString *)formatWithPattern:(NSString *)pattern
{
    return [self formatWithPattern:pattern placeholder:kDefaultPlaceholder];
}

- (NSString *)formatWithPattern:(NSString *)pattern placeholder:(NSString *)placeholder
{
    return [self formatWithPattern:pattern placeholder:kDefaultPlaceholder errorContinue:NO];
}

- (NSString *)formatWithPattern:(NSString *)pattern placeholder:(NSString *)placeholder errorContinue:(BOOL)errorContinue
{
    if (![pattern isNotEmpty])
    {
        return nil;
    }
    
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    return [self formatWithRegex:regex placeholder:placeholder errorContinue:errorContinue];
}

- (NSString *)formatWithRegex:(NSRegularExpression *)regex
{
    return [self formatWithRegex:regex placeholder:kDefaultPlaceholder];
}

- (NSString *)formatWithRegex:(NSRegularExpression *)regex placeholder:(NSString *)placeholder
{
    return [self formatWithRegex:regex placeholder:placeholder errorContinue:NO];
}

- (NSString *)formatWithRegex:(NSRegularExpression *)regex placeholder:(NSString *)placeholder errorContinue:(BOOL)errorContinue
{
    if (!regex)
    {
        return nil;
    }
    
    // Empty placeholder (@"")
    if (![placeholder isNotEmpty])
    {
        placeholder = nil;
    }
    
    NSString *validCharacters = [self validCharactersWithRegex:regex errorContinue:errorContinue];
    
    NSMutableString *pattern = [NSMutableString stringWithString:regex.pattern];
    NSMutableString *formattedString = [NSMutableString new];
    
    NSString *newPattern = [self patternStep:&pattern onString:validCharacters iterCount:1 resultFetcher:&formattedString range:NSMakeRange(0, validCharacters.length) placeholder:placeholder];
    
    // Replacing the occurrences newPattern with the results of pattern on the var formattedString
    [formattedString replaceOccurrencesOfString:newPattern
                                     withString:pattern
                                        options:NSRegularExpressionSearch
                                          range:NSMakeRange(0, formattedString.length)];
    
    return [formattedString copy];
}

// Returns only the valid characters in _string_ that matches the instance's _regex_ limited by the expected length.
- (NSString *)validCharactersWithRegex:(NSRegularExpression *)regex errorContinue:(BOOL)errorContinue
{
    if (!regex)
    {
        return nil;
    }
    
    NSString *string = [NSString stringWithString:self];
    NSMutableString *pattern = [NSMutableString stringWithString:regex.pattern];
    
    NSError *error = nil;
    
    NSString *firstGroupPattern = [self getStepPattern:&pattern iter:1];
    NSMutableString *validCharacters = [NSMutableString new];
    
    for (int i = 2; firstGroupPattern != nil; i++)
    {
        NSUInteger n = 0;
        NSArray *adaptingResult;
        NSTextCheckingResult *result;
        
        do
        {
            // Add a capturing group to the pattern
            adaptingResult = [self adaptsFirstGroupPattern:firstGroupPattern subtracting:n];
            if ([adaptingResult[kLENGTH_INDEX] integerValue] == 0)
            {
                break;
            }
            
            firstGroupPattern = adaptingResult[kRESULT_INDEX];
            
            // Try to match the pattern
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:firstGroupPattern
                                                                                   options:NSRegularExpressionCaseInsensitive
                                                                                     error:&error];
            
            result = [regex firstMatchInString:string options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, string.length)];
            if (!result)
            {
                if (errorContinue)
                {
                    break; // 继续匹配
                }
                else
                {
                    return validCharacters;
                }
            }
            
            NSString *matchedString = [string substringWithRange:result.range];
            
            string = [string stringByReplacingCharactersInRange:NSMakeRange(0, result.range.location + result.range.length) withString:@""];
            
            [validCharacters appendString:matchedString];
            
            n += result.range.length;
        }
        while (result.range.length != [adaptingResult[kLENGTH_INDEX] integerValue]);
        
        firstGroupPattern = [self getStepPattern:&pattern iter:i];
    }
    
    return validCharacters;
}


#pragma mark - Private Methods

// Adjusts the expected repetitions in _group_ to accept variable results from 0 to the maximum accepted.
- (NSArray *)adaptsFirstGroupPattern:(NSString *)group subtracting:(NSUInteger)n
{
    NSError *error = nil;
    
    // Gets the expected maximum repetition for the current group
    NSRegularExpression *maxRepetEx = [NSRegularExpression regularExpressionWithPattern:@"\\{((\\d+)?(?:,(\\d+)?)?)\\}" options:NSRegularExpressionAnchorsMatchLines error:&error];
    NSTextCheckingResult *numRep = [maxRepetEx firstMatchInString:group options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, group.length)];
    
    // Tries to get the maximum
    NSRange range = [numRep rangeAtIndex:3];
    if (range.location == NSNotFound)
    {
        // Goes for the minimum
        range = [numRep rangeAtIndex:2];
    }
    
    NSInteger numberOfRepetitions = [group substringWithRange:range].integerValue;
    
    // Replaces the the content of braces with {1, numberOfRepetitions}
    if (numberOfRepetitions > 0)
    {
        long reps = numberOfRepetitions - n;
        group = [group stringByReplacingCharactersInRange:[numRep rangeAtIndex:1] withString:[NSString stringWithFormat:@"1,%ld", reps]];

        if (reps < 1)
        {
            return @[@"", @0];
        }
    }
    else
    {
        numberOfRepetitions = NSIntegerMax;
    }
    
    return @[group, @(numberOfRepetitions)];
}

// Returns the first regex group and replaces it in the pattern with the current i.
- (NSString *)getStepPattern:(NSMutableString **)pattern iter:(long)i
{
    NSError *error = nil;
    
    // Extracts the content of parentheses if it's not preceded by slash.
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(?<!\\\\)\\(([^)(]*)(?<!\\\\)\\)"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSTextCheckingResult *checkingResult = [regex firstMatchInString:*pattern options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, (*pattern).length)];
    if (!checkingResult || checkingResult.range.location == NSNotFound)
    {
        return nil;
    }
    
    NSString *result = [*pattern substringWithRange:[checkingResult rangeAtIndex:1]];
    
    // Replaces the current group with $i.
    [*pattern replaceCharactersInRange:checkingResult.range withString:[NSString stringWithFormat:@"$%ld", i]];
    
    return result;
}

// Recursive method to format the given string based on the given pattern and placeholder, returning the new regex pattern to be used on NSMutableString's replaceOccurrencesOfString:withString:options:range: and editing the pattern to match this method's replacement string.
- (NSString *)patternStep:(NSMutableString **)pattern onString:(NSString *)string iterCount:(long)i resultFetcher:(NSMutableString **)mutableResult range:(NSRange)range placeholder:(NSString *)placeholder
{
    // Get the first group on the pattern and replace it with $i
    NSString *firstGroupPattern = [self getStepPattern:pattern iter:i];
    
    // If there's no group on the pattern, end the recursion.
    if (!firstGroupPattern)
    {
        return @"";
    }
    
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:firstGroupPattern options:NSRegularExpressionAnchorsMatchLines error:&error];
    
    NSTextCheckingResult *result = [regex firstMatchInString:string options:NSMatchingWithoutAnchoringBounds range:range];
    long num = 0;
    
    // If no result, tries the possibility of the string being shorted than expected.
    if (!result || result.range.location == NSNotFound)
    {
        // Gets the expected repetition for the current group
        NSRegularExpression *numRepetEx = [NSRegularExpression regularExpressionWithPattern:@"\\{(\\d+)?(?:,(\\d+)?)?\\}" options:NSRegularExpressionAnchorsMatchLines error:&error];
        NSTextCheckingResult *numRep = [numRepetEx firstMatchInString:firstGroupPattern options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, firstGroupPattern.length)];
        NSRange numRange = [numRep rangeAtIndex:2];
        if (numRange.location == NSNotFound)
        {
            numRange = [numRep rangeAtIndex:1];
        }
        
        num = [firstGroupPattern substringWithRange:numRange].integerValue;
        
        // Replaces the expected repetition on the group pattern with "+".
        firstGroupPattern = [firstGroupPattern stringByReplacingCharactersInRange:numRep.range withString:@"+"];
        
        // Tries to match the new pattern on the string.
        regex = [NSRegularExpression regularExpressionWithPattern:firstGroupPattern options:NSRegularExpressionAnchorsMatchLines error:&error];
        result = [regex firstMatchInString:string options:NSMatchingWithoutAnchoringBounds range:range];
    }
    
    // The matching on the string
    NSString *stringMatched = [string substringWithRange:result.range];
    [*mutableResult appendString:stringMatched];
    
    if (num > 0 && placeholder)
    {
        // Has a placeholder but couldn't match the expected repetition, but matched when repetition was replaced by "+"
        // Then, it'll complete the missing characters with the placeholder.
        NSString *placeholderRepetition = [@"" stringByPaddingToLength:num-stringMatched.length withString:placeholder startingAtIndex:0];
        [*mutableResult appendString:placeholderRepetition];
        
        // Adjusts the group pattern to also accept the placeholder.
        firstGroupPattern = [NSString stringWithFormat:@"[%@%@]{%ld}", firstGroupPattern, placeholder, num];
    }
    
    if (result)
    {
        // Adjusts the range to advance in the string.
        range.location = result.range.location + result.range.length;
        range.length = string.length - range.location;
    }
    
    return [NSString stringWithFormat:@"(%@)%@", firstGroupPattern, [self patternStep:pattern onString:string iterCount:++i resultFetcher:mutableResult range:range placeholder:placeholder]];
}

@end

/*
[NSStringMask maskString:@"c" withPattern:@"\\w"]
// result: nil

[NSStringMask maskString:@"c" withPattern:@"(\\w)"]
// result: "c"

[NSStringMask maskString:@"3" withPattern:@"\\((\\d)\\)"]
// result: (3)

[NSStringMask maskString:@"3" withPattern:@"\\((\\d{4})\\)" placeholder:@"_"]
// result: (3___)


[NSStringMask maskString:@"1234567890" withPattern:@"(\\d{3})-(\\d{3})-(\\d{4})"]
// result: 123-456-7890

[NSStringMask maskString:@"123foo456" withPattern:@"(\\d{3})#(\\d{4})]
// result: 123456


[NSStringMask maskString:@"" withPattern:@"(\\d{2})/(\\d{2})/(\\d{4})" placeholder:@"_"]
// result: __/__/____
 
[NSStringMask maskString:@"" withPattern:@"(\\d{2})/(\\d{2})/(\\d{4})" placeholder:@"abcde"]
// result: ab/ab/abcd
 
*/

#define PHONENUMBER_LENGTH      11

@implementation NSString (PhoneNumber)

- (NSString *)maskPhoneNumber:(NSRange)maskRang withMask:(char)maskChar
{
    if (![self isValidPhoneNumber])
    {
        return self;
    }
    
    return [self maskAtRang:maskRang withMask:maskChar];
}

- (NSString *)maskAtRang:(NSRange)maskRang withMask:(char)maskChar
{
    if (maskRang.location == NSNotFound || maskRang.location>=self.length)
    {
        return self;
    }
    
    if (maskRang.length+maskRang.location >= self.length)
    {
        maskRang.length = self.length-maskRang.location;
    }
    
    NSMutableString *mask = [NSMutableString string];
    for (NSUInteger i=0; i<maskRang.length; i++)
    {
        [mask appendFormat:@"%c", maskChar];
    }
    
    if (mask.length)
    {
        return [self stringByReplacingCharactersInRange:maskRang withString:mask];
    }
    
    return self;
}

@end
