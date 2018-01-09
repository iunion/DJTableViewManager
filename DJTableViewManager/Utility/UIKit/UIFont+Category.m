//
//  UIFont+Category.m
//  DJkit
//
//  Created by DennisDeng on 16/6/28.
//  Copyright © 2016年 DennisDeng. All rights reserved.
//

#import "UIFont+Category.h"
#import "NSArray+Category.h"

@implementation UIFont (Category)

+ (NSDictionary *)allFamilyAndFonts
{
    NSArray *fontFamilies = (NSArray *)[UIFont familyNames];
    fontFamilies = [fontFamilies sortArrayByKey:@"" ascending:YES];
    
    NSMutableDictionary *fontFamilyDic = [[NSMutableDictionary alloc] init];
    for (NSUInteger i = 0; i < fontFamilies.count; i++)
    {
        NSString *fontFamily = fontFamilies[i];
        NSArray *fontNames = [UIFont fontNamesForFamilyName:fontFamily];
        [fontFamilyDic setObject:fontNames forKey:fontFamily];
    }
    
    NSLog(@"%@", fontFamilyDic);
    
    return fontFamilyDic;
}

+ (NSArray *)fontsNameForFamilyName:(MQFamilyFontName)familyFontName
{
    NSArray *fontNames;
    
    switch (familyFontName)
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        case FamilyFontNameBanglaSangamMN:
            fontNames = [UIFont fontNamesForFamilyName:@"Bangla Sangam MN"];
            break;
        case FamilyFontNameDINAlternate:
            fontNames = [UIFont fontNamesForFamilyName:@"DIN Alternate"];
            break;
        case FamilyFontNameDINCondensed:
            fontNames = [UIFont fontNamesForFamilyName:@"DIN Condensed"];
            break;
        case FamilyFontNameIowanOldStyle:
            fontNames = [UIFont fontNamesForFamilyName:@"Iowan Old Style"];
            break;
        case FamilyFontNameMarion:
            fontNames = [UIFont fontNamesForFamilyName:@"Marion"];
            break;
        case FamilyFontNameSuperclarendon:
            fontNames = [UIFont fontNamesForFamilyName:@"Superclarendon"];
            break;
#pragma clang diagnostic pop
        case FamilyFontNameAcademyEngravedLET:
            fontNames = [UIFont fontNamesForFamilyName:@"Academy Engraved LET"];
            break;
        case FamilyFontNameAlNile:
            fontNames = [UIFont fontNamesForFamilyName:@"Al Nile"];
            break;
        case FamilyFontNameAmericanTypewriter:
            fontNames = [UIFont fontNamesForFamilyName:@"American Typewriter"];
            break;
        case FamilyFontNameAppleColorEmoji:
            fontNames = [UIFont fontNamesForFamilyName:@"Apple Color Emoji"];
            break;
        case FamilyFontNameAppleSDGothicNeo:
            fontNames = [UIFont fontNamesForFamilyName:@"Apple SD Gothic Neo"];
            break;
        case FamilyFontNameArial:
            fontNames = [UIFont fontNamesForFamilyName:@"Arial"];
            break;
        case FamilyFontNameArialHebrew:
            fontNames = [UIFont fontNamesForFamilyName:@"Arial Hebrew"];
            break;
        case FamilyFontNameArialRoundedMTBold:
            fontNames = [UIFont fontNamesForFamilyName:@"Arial Rounded MT Bold"];
            break;
        case FamilyFontNameAvenir:
            fontNames = [UIFont fontNamesForFamilyName:@"Avenir"];
            break;
        case FamilyFontNameAvenirNext:
            fontNames = [UIFont fontNamesForFamilyName:@"Avenir Next"];
            break;
        case FamilyFontNameAvenirNextCondensed:
            fontNames = [UIFont fontNamesForFamilyName:@"Avenir Next Condensed"];
            break;
        case FamilyFontNameBaskerville:
            fontNames = [UIFont fontNamesForFamilyName:@"Baskerville"];
            break;
        case FamilyFontNameBodoni72:
            fontNames = [UIFont fontNamesForFamilyName:@"Bodoni 72"];
            break;
        case FamilyFontNameBodoni72Oldstyle:
            fontNames = [UIFont fontNamesForFamilyName:@"Bodoni 72 Oldstyle"];
            break;
        case FamilyFontNameBodoni72Smallcaps:
            fontNames = [UIFont fontNamesForFamilyName:@"Bodoni 72 Smallcaps"];
            break;
        case FamilyFontNameBodoniOrnaments:
            fontNames = [UIFont fontNamesForFamilyName:@"Bodoni Ornaments"];
            break;
        case FamilyFontNameBradleyHand:
            fontNames = [UIFont fontNamesForFamilyName:@"Bradley Hand"];
            break;
        case FamilyFontNameChalkboardSE:
            fontNames = [UIFont fontNamesForFamilyName:@"Chalkboard SE"];
            break;
        case FamilyFontNameChalkduster:
            fontNames = [UIFont fontNamesForFamilyName:@"Chalkduster"];
            break;
        case FamilyFontNameCochin:
            fontNames = [UIFont fontNamesForFamilyName:@"Cochin"];
            break;
        case FamilyFontNameCopperplate:
            fontNames = [UIFont fontNamesForFamilyName:@"Copperplate"];
            break;
        case FamilyFontNameCourier:
            fontNames = [UIFont fontNamesForFamilyName:@"Courier"];
            break;
        case FamilyFontNameCourierNew:
            fontNames = [UIFont fontNamesForFamilyName:@"Courier New"];
            break;
        case FamilyFontNameDamascus:
            fontNames = [UIFont fontNamesForFamilyName:@"Damascus"];
            break;
        case FamilyFontNameDevanagariSangamMN:
            fontNames = [UIFont fontNamesForFamilyName:@"Devanagari Sangam MN"];
            break;
        case FamilyFontNameDidot:
            fontNames = [UIFont fontNamesForFamilyName:@"Didot"];
            break;
        case FamilyFontNameEuphemiaUCAS:
            fontNames = [UIFont fontNamesForFamilyName:@"Euphemia UCAS"];
            break;
        case FamilyFontNameFarah:
            fontNames = [UIFont fontNamesForFamilyName:@"Farah"];
            break;
        case FamilyFontNameFutura:
            fontNames = [UIFont fontNamesForFamilyName:@"Futura"];
            break;
        case FamilyFontNameGeezaPro:
            fontNames = [UIFont fontNamesForFamilyName:@"Geeza Pro"];
            break;
        case FamilyFontNameGeorgia:
            fontNames = [UIFont fontNamesForFamilyName:@"Georgia"];
            break;
        case FamilyFontNameGillSans:
            fontNames = [UIFont fontNamesForFamilyName:@"Gill Sans"];
            break;
        case FamilyFontNameGujaratiSangemMN:
            fontNames = [UIFont fontNamesForFamilyName:@"Gujarati Sangam MN"];
            break;
        case FamilyFontNameGurmukhiMN:
            fontNames = [UIFont fontNamesForFamilyName:@"Gurmukhi MN"];
            break;
        case FamilyFontNameHeitiSC:
            fontNames = [UIFont fontNamesForFamilyName:@"Heiti SC"];
            break;
        case FamilyFontNameHeitiTC:
            fontNames = [UIFont fontNamesForFamilyName:@"Heiti TC"];
            break;
        case FamilyFontNameHelvetica:
            fontNames = [UIFont fontNamesForFamilyName:@"Helvetica"];
            break;
        case FamilyFontNameHelveticaNeue:
            fontNames = [UIFont fontNamesForFamilyName:@"Helvetica Neue"];
            break;
        case FamilyFontNameHiraginoKakuGothicProN:
            fontNames = [UIFont fontNamesForFamilyName:@"Hiragino Kaku Gothic ProN"];
            break;
        case FamilyFontNameHiraginoMinchoProN:
            fontNames = [UIFont fontNamesForFamilyName:@"Hiragino Mincho ProN"];
            break;
        case FamilyFontNameHoeflerText:
            fontNames = [UIFont fontNamesForFamilyName:@"Hoefler Text"];
            break;
        case FamilyFontNameKailasa:
            fontNames = [UIFont fontNamesForFamilyName:@"Kailasa"];
            break;
        case FamilyFontNameKannadaSangamMN:
            fontNames = [UIFont fontNamesForFamilyName:@"Kannada Sangam MN"];
            break;
        case FamilyFontNameKhmerSangamMN:
            fontNames = [UIFont fontNamesForFamilyName:@"Khmer Sangam MN"];
            break;
        case FamilyFontNameKohinoorBangla:
            fontNames = [UIFont fontNamesForFamilyName:@"Kohinoor Bangla"];
            break;
        case FamilyFontNameKohinoorDevanagari:
            fontNames = [UIFont fontNamesForFamilyName:@"Kohinoor Devanagari"];
            break;
        case FamilyFontNameLaoSangamMN:
            fontNames = [UIFont fontNamesForFamilyName:@"Lao Sangam MN"];
            break;
        case FamilyFontNameMalayamSangamMN:
            fontNames = [UIFont fontNamesForFamilyName:@"Malayalam Sangam MN"];
            break;
        case FamilyFontNameMarkerFelt:
            fontNames = [UIFont fontNamesForFamilyName:@"Marker Felt"];
            break;
        case FamilyFontNameMenlo:
            fontNames = [UIFont fontNamesForFamilyName:@"Menlo"];
            break;
        case FamilyFontNameMishafi:
            fontNames = [UIFont fontNamesForFamilyName:@"Mishafi"];
            break;
        case FamilyFontNameNoteworthy:
            fontNames = [UIFont fontNamesForFamilyName:@"Noteworthy"];
            break;
        case FamilyFontNameOptima:
            fontNames = [UIFont fontNamesForFamilyName:@"Optima"];
            break;
        case FamilyFontNameOriyaSangemMN:
            fontNames = [UIFont fontNamesForFamilyName:@"Oriya Sangam MN"];
            break;
        case FamilyFontNamePalatino:
            fontNames = [UIFont fontNamesForFamilyName:@"Palatino"];
            break;
        case FamilyFontNamePapyrus:
            fontNames = [UIFont fontNamesForFamilyName:@"Papyrus"];
            break;
        case FamilyFontNamePartyLET:
            fontNames = [UIFont fontNamesForFamilyName:@"Party LET"];
            break;
        case FamilyFontNameSavoyeLET:
            fontNames = [UIFont fontNamesForFamilyName:@"Savoye LET"];
            break;
        case FamilyFontNameSinhalaSangamMN:
            fontNames = [UIFont fontNamesForFamilyName:@"Sinhala Sangam MN"];
            break;
        case FamilyFontNameSnellRoundhand:
            fontNames = [UIFont fontNamesForFamilyName:@"Snell Roundhand"];
            break;
        case FamilyFontNameSymbol:
            fontNames = [UIFont fontNamesForFamilyName:@"Symbol"];
            break;
        case FamilyFontNameTamilSangamMN:
            fontNames = [UIFont fontNamesForFamilyName:@"Tamil Sangam MN"];
            break;
        case FamilyFontNameTeluguSangamMN:
            fontNames = [UIFont fontNamesForFamilyName:@"Telugu Sangam MN"];
            break;
        case FamilyFontNameThonburi:
            fontNames = [UIFont fontNamesForFamilyName:@"Thonburi"];
            break;
        case FamilyFontNameTimesNewRoman:
            fontNames = [UIFont fontNamesForFamilyName:@"Times New Roman"];
            break;
        case FamilyFontNameTrebuchetMS:
            fontNames = [UIFont fontNamesForFamilyName:@"Trebuchet MS"];
            break;
        case FamilyFontNameVerdana:
            fontNames = [UIFont fontNamesForFamilyName:@"Verdana"];
            break;
        case FamilyFontNameZapfDingBats:
            fontNames = [UIFont fontNamesForFamilyName:@"Zapf Dingbats"];
            break;
        case FamilyFontNameZapfino:
            fontNames = [UIFont fontNamesForFamilyName:@"Zapfino"];
            break;
    }
    
    NSLog(@"%@", fontNames);

    return fontNames;
}

+ (NSString *)fontNameToString:(MQFontName)fontName
{
    switch (fontName)
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        case FontNameBanglaSangamMN:
            return @"BanglaSangamMN";
        case FontNameBanglaSangamMNBold:
            return @"BanglaSangamMN-Bold";
        case FontNameDINAlternateBold:
            return @"DINAlternate-Bold";
        case FontNameDINCondensedBold:
            return @"DINCondensed-Bold";
        case FontNameIowanOldStyleBold:
            return @"IowanOldStyle-Bold";
        case FontNameIowanOldStyleBoldItalic:
            return @"IowanOldStyle-BoldItalic";
        case FontNameIowanOldStyleItalic:
            return @"IowanOldStyle-Italic";
        case FontNameIowanOldStyleRoman:
            return @"IowanOldStyle-Roman";
        case FontNameMarionBold:
            return @"Marion-Bold";
        case FontNameMarionItalic:
            return @"Marion-Italic";
        case FontNameMarionRegular:
            return @"Marion-Regular";
        case FontNameSuperclarendonBlack:
            return @"Superclarendon-Black";
        case FontNameSuperclarendonBlackItalic:
            return @"Superclarendon-BalckItalic";
        case FontNameSuperclarendonBold:
            return @"Superclarendon-Bold";
        case FontNameSuperclarendonBoldItalic:
            return @"Superclarendon-BoldItalic";
        case FontNameSuperclarendonItalic:
            return @"Superclarendon-Italic";
        case FontNameSuperclarendonLight:
            return @"Superclarendon-Light";
        case FontNameSuperclarendonLightItalic:
            return @"Superclarendon-LightItalic";
        case FontNameSuperclarendonRegular:
            return @"Superclarendon-Regular";
#pragma clang diagnostic pop
        case FontNameAcademyEngravedLetPlain:
            return @"AcademyEngravedLetPlain";
        case FontNameAlNile:
            return @"AlNile";
        case FontNameAlNileBold:
            return @"AlNile-Bold";
        case FontNameAmericanTypewriter:
            return @"AmericanTypewriter";
        case FontNameAmericanTypewriterBold:
            return @"AmericanTypewriter-Bold";
        case FontNameAmericanTypewriterCondensed:
            return @"AmericanTypewriter-Condensed";
        case FontNameAmericanTypewriterCondensedBold:
            return @"AmericanTypewriter-CondensedBold";
        case FontNameAmericanTypewriterCondensedLight:
            return @"AmericanTypewriter-CondensedLight";
        case FontNameAmericanTypewriterLight:
            return @"AmericanTypewriter-Light";
        case FontNameAppleColorEmoji:
            return @"AppleColorEmoji";
        case FontNameAppleSDGothicNeoBold:
            return @"AppleSDGothicNeo-Bold";
        case FontNameAppleSDGothicNeoLight:
            return @"AppleSDGothicNeo-Light";
        case FontNameAppleSDGothicNeoMedium:
            return @"AppleSDGothicNeo-Medium";
        case FontNameAppleSDGothicNeoRegular:
            return @"AppleSDGothicNeo-Regular";
        case FontNameAppleSDGothicNeoSemiBold:
            return @"AppleSDGothicNeo-SemiBold";
        case FontNameAppleSDGothicNeoThin:
            return @"AppleSDGothicNeo-Thin";
        case FontNameAppleSDGothicNeoUltraLight:
            return @"AppleSDGothicNeo-UltraLight";
        case FontNameArialBoldItalicMT:
            return @"Arial-BoldItalicMT";
        case FontNameArialBoldMT:
            return @"Arial-BoldMT";
        case FontNameArialHebrew:
            return @"ArialHebrew";
        case FontNameArialHebrewBold:
            return @"ArialHebrew-Bold";
        case FontNameArialHebrewLight:
            return @"ArialHebrew-Light";
        case FontNameArialItalicMT:
            return @"Arial-ItalicMT";
        case FontNameArialMT:
            return @"ArialMT";
        case FontNameArialRoundedMTBold:
            return @"ArialRoundedMTBold";
        case FontNameASTHeitiLight:
            return @"ASTHeiti-Light";
        case FontNameASTHeitiMedium:
            return @"ASTHeiti-Medium";
        case FontNameAvenirBlack:
            return @"Avenir-Black";
        case FontNameAvenirBlackOblique:
            return @"Avenir-BlackOblique";
        case FontNameAvenirBook:
            return @"Avenir-Book";
        case FontNameAvenirBookOblique:
            return @"Avenir-BookOblique";
        case FontNameAvenirHeavyOblique:
            return @"Avenir-HeavyOblique";
        case FontNameAvenirHeavy:
            return @"Avenir-Heavy";
        case FontNameAvenirLight:
            return @"Avenir-Light";
        case FontNameAvenirLightOblique:
            return @"Avenir-LightOblique";
        case FontNameAvenirMedium:
            return @"Avenir-Medium";
        case FontNameAvenirMediumOblique:
            return @"Avenir-MediumOblique";
        case FontNameAvenirNextBold:
            return @"AvenirNext-Bold";
        case FontNameAvenirNextBoldItalic:
            return @"AvenirNext-BoldItalic";
        case FontNameAvenirNextCondensedBold:
            return @"AvenirNextCondensed-Bold";
        case FontNameAvenirNextCondensedBoldItalic:
            return @"AvenirNextCondensed-BoldItalic";
        case FontNameAvenirNextCondensedDemiBold:
            return @"AvenirNextCondensed-DemiBold";
        case FontNameAvenirNextCondensedDemiBoldItalic:
            return @"AvenirNextCondensed-DemiBoldItalic";
        case FontNameAvenirNextCondensedHeavy:
            return @"AvenirNextCondensed-Heavy";
        case FontNameAvenirNextCondensedHeavyItalic:
            return @"AvenirNextCondensed-HeavyItalic";
        case FontNameAvenirNextCondensedItalic:
            return @"AvenirNextCondensed-Italic";
        case FontNameAvenirNextCondensedMedium:
            return @"AvenirNextCondensed-Medium";
        case FontNameAvenirNextCondensedMediumItalic:
            return @"AvenirNextCondensed-MediumItalic";
        case FontNameAvenirNextCondensedRegular:
            return @"AvenirNextCondensed-Regular";
        case FontNameAvenirNextCondensedUltraLight:
            return @"AvenirNextCondensed-UltraLight";
        case FontNameAvenirNextCondensedUltraLightItalic:
            return @"AvenirNextCondensed-UltraLightItalic";
        case FontNameAvenirNextDemiBold:
            return @"AvenirNext-DemiBold";
        case FontNameAvenirNextDemiBoldItalic:
            return @"AvenirNext-DemiBoldItalic";
        case FontNameAvenirNextHeavy:
            return @"AvenirNext-Heavy";
        case FontNameAvenirNextItalic:
            return @"AvenirNext-Italic";
        case FontNameAvenirNextMedium:
            return @"AvenirNext-Medium";
        case FontNameAvenirNextMediumItalic:
            return @"AvenirNext-MediumItalic";
        case FontNameAvenirNextRegular:
            return @"AvenirNext-Regular";
        case FontNameAvenirNextUltraLight:
            return @"AvenirNext-UltraLight";
        case FontNameAvenirNextUltraLightItalic:
            return @"AvenirNext-UltraLightItalic";
        case FontNameAvenirOblique:
            return @"Avenir-Oblique";
        case FontNameAvenirRoman:
            return @"Avenir-Roman";
        case FontNameBaskerville:
            return @"Baskerville";
        case FontNameBaskervilleBold:
            return @"Baskerville-Bold";
        case FontNameBaskervilleBoldItalic:
            return @"Baskerville-BoldItalic";
        case FontNameBaskervilleItalic:
            return @"Baskerville-Italic";
        case FontNameBaskervilleSemiBold:
            return @"Baskerville-SemiBold";
        case FontNameBaskervilleSemiBoldItalic:
            return @"Baskerville-SemiBoldItalic";
        case FontNameBodoniOrnamentsITCTT:
            return @"BodoniOrnamentsITCTT";
        case FontNameBodoniSvtyTwoITCTTBold:
            return @"BodoniSvtyTwoITCTT-Bold";
        case FontNameBodoniSvtyTwoITCTTBook:
            return @"BodoniSvtyTwoITCTT-Book";
        case FontNameBodoniSvtyTwoITCTTBookIta:
            return @"BodoniSvtyTwoITCTT-BookIta";
        case FontNameBodoniSvtyTwoOSITCTTBold:
            return @"BodoniSvtyTwoOSITCTT-Bold";
        case FontNameBodoniSvtyTwoOSITCTTBook:
            return @"BodoniSvtyTwoOSITCTT-Book";
        case FontNameBodoniSvtyTwoOSITCTTBookIt:
            return @"BodoniSvtyTwoOSITCTT-BookIt";
        case FontNameBodoniSvtyTwoSCITCTTBook:
            return @"BodoniSvtyTwoSCITCTT-Book";
        case FontNameBradleyHandITCTTBold:
            return @"BradleyHandITCTT-Bold";
        case FontNameChalkboardSEBold:
            return @"ChalkboardSE-Bold";
        case FontNameChalkboardSELight:
            return @"ChalkboardSE-Light";
        case FontNameChalkboardSERegular:
            return @"ChalkboardSE-Regular";
        case FontNameChalkduster:
            return @"Chalkduster";
        case FontNameCochin:
            return @"Cochin";
        case FontNameCochinBold:
            return @"Cochin-Bold";
        case FontNameCochinBoldItalic:
            return @"Cochin-BoldItalic";
        case FontNameCochinItalic:
            return @"Cochin-Italic";
        case FontNameCopperplate:
            return @"Copperplate";
        case FontNameCopperplateBold:
            return @"Copperplate-Bold";
        case FontNameCopperplateLight:
            return @"Copperplate-Light";
        case FontNameCourier:
            return @"Courier";
        case FontNameCourierBold:
            return @"Courier-Bold";
        case FontNameCourierBoldOblique:
            return @"Courier-BoldOblique";
        case FontNameCourierNewPSBoldItalicMT:
            return @"CourierNewPS-BoldItalicMT";
        case FontNameCourierNewPSBoldMT:
            return @"CourierNewPS-BoldMT";
        case FontNameCourierNewPSItalicMT:
            return @"CourierNewPS-ItalicMT";
        case FontNameCourierNewPSMT:
            return @"CourierNewPSMT";
        case FontNameCourierOblique:
            return @"Courier-Oblique";
        case FontNameDamascus:
            return @"Damascus";
        case FontNameDamascusBold:
            return @"DamascusBold";
        case FontNameDamascusMedium:
            return @"DamascusMedium";
        case FontNameDamascusSemiBold:
            return @"DamascusSemiBold";
        case FontNameDevanagariSangamMN:
            return @"DevanagariSangamMN";
        case FontNameDevanagariSangamMNBold:
            return @"DevanagariSangamMN-Bold";
        case FontNameDidot:
            return @"Didot";
        case FontNameDidotBold:
            return @"Didot-Bold";
        case FontNameDidotItalic:
            return @"Didot-Italic";
        case FontNameDiwanMishafi:
            return @"DiwanMishafi";
        case FontNameEuphemiaUCAS:
            return @"EuphemiaUCAS";
        case FontNameEuphemiaUCASBold:
            return @"EuphemiaUCAS-Bold";
        case FontNameEuphemiaUCASItalic:
            return @"EuphemiaUCAS-Italic";
        case FontNameFarah:
            return @"Farah";
        case FontNameFuturaCondensedExtraBold:
            return @"Futura-ExtraBold";
        case FontNameFuturaCondensedMedium:
            return @"Futura-CondensedMedium";
        case FontNameFuturaMedium:
            return @"Futura-Medium";
        case FontNameFuturaMediumItalicm:
            return @"Futura-MediumItalic";
        case FontNameGeezaPro:
            return @"GeezaPro";
        case FontNameGeezaProBold:
            return @"GeezaPro-Bold";
        case FontNameGeezaProLight:
            return @"GeezaPro-Light";
        case FontNameGeorgia:
            return @"Georgia";
        case FontNameGeorgiaBold:
            return @"Georgia-Bold";
        case FontNameGeorgiaBoldItalic:
            return @"Georgia-BoldItalic";
        case FontNameGeorgiaItalic:
            return @"Georgia-Italic";
        case FontNameGillSans:
            return @"GillSans";
        case FontNameGillSansBold:
            return @"GillSans-Bold";
        case FontNameGillSansBoldItalic:
            return @"GillSans-BoldItalic";
        case FontNameGillSansItalic:
            return @"GillSans-Italic";
        case FontNameGillSansLight:
            return @"GillSans-Light";
        case FontNameGillSansLightItalic:
            return @"GillSans-LightItalic";
        case FontNameGujaratiSangamMN:
            return @"GujaratiSangamMN";
        case FontNameGujaratiSangamMNBold:
            return @"GujaratiSangamMN-Bold";
        case FontNameGurmukhiMN:
            return @"GurmukhiMN";
        case FontNameGurmukhiMNBold:
            return @"GurmukhiMN-Bold";
        case FontNameHelvetica:
            return @"Helvetica";
        case FontNameHelveticaBold:
            return @"Helvetica-Bold";
        case FontNameHelveticaBoldOblique:
            return @"Helvetica-BoldOblique";
        case FontNameHelveticaLight:
            return @"Helvetica-Light";
        case FontNameHelveticaLightOblique:
            return @"Helvetica-LightOblique";
        case FontNameHelveticaNeue:
            return @"HelveticaNeue";
        case FontNameHelveticaNeueBold:
            return @"HelveticaNeue-Bold";
        case FontNameHelveticaNeueBoldItalic:
            return @"HelveticaNeue-BoldItalic";
        case FontNameHelveticaNeueCondensedBlack:
            return @"HelveticaNeue-CondensedBlack";
        case FontNameHelveticaNeueCondensedBold:
            return @"HelveticaNeue-CondensedBold";
        case FontNameHelveticaNeueItalic:
            return @"HelveticaNeue-Italic";
        case FontNameHelveticaNeueLight:
            return @"HelveticaNeue-Light";
        case FontNameHelveticaNeueMedium:
            return @"HelveticaNeue-Medium";
        case FontNameHelveticaNeueMediumItalic:
            return @"HelveticaNeue-MediumItalic";
        case FontNameHelveticaNeueThin:
            return @"HelveticaNeue-Thin";
        case FontNameHelveticaNeueThinItalic:
            return @"HelveticaNeue-ThinItalic";
        case FontNameHelveticaNeueUltraLight:
            return @"HelveticaNeue-UltraLight";
        case FontNameHelveticaNeueUltraLightItalic:
            return @"HelveticaNeue-UltraLightItalic";
        case FontNameHelveticaOblique:
            return @"Helvetica-Oblique";
        case FontNameHiraKakuProNW3:
            return @"HiraKakuProN-W3";
        case FontNameHiraKakuProNW6:
            return @"HiraKakuProN-W6";
        case FontNameHiraMinProNW3:
            return @"HiraMinProN-W3";
        case FontNameHiraMinProNW6:
            return @"HiraMinProN-W6";
        case FontNameHoeflerTextBlack:
            return @"HoeflerText-Black";
        case FontNameHoeflerTextBlackItalic:
            return @"HoeflerText-BlackItalic";
        case FontNameHoeflerTextItalic:
            return @"HoeflerText-Italic";
        case FontNameHoeflerTextRegular:
            return @"HoeflerText-Regular";
        case FontNameKailasa:
            return @"Kailasa";
        case FontNameKailasaBold:
            return @"Kailasa-Bold";
        case FontNameKannadaSangamMN:
            return @"KannadaSangamMN";
        case FontNameKannadaSangamMNBold:
            return @"KannadaSangamMN-Bold";
        case FontNameKhmerSangamMN:
            return @"KhmerSangamMN";
        case FontNameKohinoorBanglaLight:
            return @"KohinoorBangla-Light";
        case FontNameKohinoorBanglaMedium:
            return @"KohinoorBangla-Medium";
        case FontNameKohinoorBanglaRegular:
            return @"KohinoorBangla-Regular";
        case FontNameKohinoorDevanagariLight:
            return @"KohinoorDevanagari-Light";
        case FontNameKohinoorDevanagariMedium:
            return @"KohinoorDevanagari-Medium";
        case FontNameKohinoorDevanagariBook:
            return @"KohinoorDevanagari-Book";
        case FontNameLaoSangamMN:
            return @"LaoSangamMN";
        case FontNameMalayalamSangamMN:
            return @"MalayalamSangamMN";
        case FontNameMalayalamSangamMNBold:
            return @"MalayalamSangamMN-Bold";
        case FontNameMarkerFeltThin:
            return @"MarkerFelt-Thin";
        case FontNameMarkerFeltWide:
            return @"MarkerFelt-Wide";
        case FontNameMenloBold:
            return @"Menlo-Bold";
        case FontNameMenloBoldItalic:
            return @"Menlo-BoldItalic";
        case FontNameMenloItalic:
            return @"Menlo-Italic";
        case FontNameMenloRegular:
            return @"Menlo-Regular";
        case FontNameNoteworthyBold:
            return @"Noteworthy-Bold";
        case FontNameNoteworthyLight:
            return @"Noteworthy-Light";
        case FontNameOptimaBold:
            return @"Optima-Bold";
        case FontNameOptimaBoldItalic:
            return @"Optima-BoldItalic";
        case FontNameOptimaExtraBlack:
            return @"Optima-ExtraBold";
        case FontNameOptimaItalic:
            return @"Optima-Italic";
        case FontNameOptimaRegular:
            return @"Optima-Regular";
        case FontNameOriyaSangamMN:
            return @"OriyaSangamMN";
        case FontNameOriyaSangamMNBold:
            return @"OriyaSangamMN-Bold";
        case FontNamePalatinoBold:
            return @"Palatino-Bold";
        case FontNamePalatinoBoldItalic:
            return @"Palatino-BoldItalic";
        case FontNamePalatinoItalic:
            return @"Palatino-Italic";
        case FontNamePalatinoRoman:
            return @"Palatino-Roman";
        case FontNamePapyrus:
            return @"Papyrus";
        case FontNamePapyrusCondensed:
            return @"Papyrus-Condensed";
        case FontNamePartyLetPlain:
            return @"PartyLetPlain";
        case FontNameSavoyeLetPlain:
            return @"SavoyeLetPlain";
        case FontNameSinhalaSangamMN:
            return @"SinhalaSangamMN";
        case FontNameSinhalaSangamMNBold:
            return @"SinhalaSangamMN-Bold";
        case FontNameSnellRoundhand:
            return @"SnellRoundhand";
        case FontNameSnellRoundhandBlack:
            return @"SnellRoundhand-Black";
        case FontNameSnellRoundhandBold:
            return @"SnellRoundhand-Bold";
        case FontNameSTHeitiSCLight:
            return @"STHeitiSC-Light";
        case FontNameSTHeitiSCMedium:
            return @"STHeitiSC-Medium";
        case FontNameSTHeitiTCLight:
            return @"STHeitiTC-Light";
        case FontNameSTHeitiTCMedium:
            return @"STHeitiTC-Medium";
        case FontNameSymbol:
            return @"Symbol";
        case FontNameTamilSangamMN:
            return @"TamilSangamMN";
        case FontNameTamilSangamMNBold:
            return @"TamilSangamMN-Bold";
        case FontNameTeluguSangamMN:
            return @"TeluguSangamMN";
        case FontNameTeluguSangamMNBold:
            return @"TeluguSangamMN-Bold";
        case FontNameThonburi:
            return @"Thonburi";
        case FontNameThonburiBold:
            return @"Thonburi-Bold";
        case FontNameThonburiLight:
            return @"Thonburi-Light";
        case FontNameTimesNewRomanPSBoldItalicMT:
            return @"TimesNewRomanPS-BoldItalic";
        case FontNameTimesNewRomanPSBoldMT:
            return @"TimesNewRomanPS-Bold";
        case FontNameTimesNewRomanPSItalicMT:
            return @"TimesNewRomanPS-ItalicMT";
        case FontNameTimesNewRomanPSMT:
            return @"TimesNewRomanPSMT";
        case FontNameTrebuchetBoldItalic:
            return @"Trebuchet-BoldItalic";
        case FontNameTrebuchetMS:
            return @"TrebuchetMS";
        case FontNameTrebuchetMSBold:
            return @"TrebuchetMS-Bold";
        case FontNameTrebuchetMSItalic:
            return @"TrebuchetMS-Italic";
        case FontNameVerdana:
            return @"Verdana";
        case FontNameVerdanaBold:
            return @"Verdana-Bold";
        case FontNameVerdanaBoldItalic:
            return @"Verdana-BoldItalic";
        case FontNameVerdanaItalic:
            return @"Verdana-Italic";
        case FontNameZapfDingbatsITC:
            return @"ZapfDingbatsITC";
        case FontNameZapfino:
            return @"Zapfino";
        default:
            return nil;
    }
}

+ (UIFont *)fontForFontName:(MQFontName)fontName size:(CGFloat)fontSize
{
    NSString *fontStrName = [UIFont fontNameToString:fontName];
    if (fontStrName)
    {
        return [UIFont fontWithName:fontStrName size:fontSize];
    }
    else
    {
        return [UIFont systemFontOfSize:fontSize];
    }
}

//UIFontDescriptor *attributeFontDescriptor = [UIFontDescriptor fontDescriptorWithFontAttributes:
//                                             @{UIFontDescriptorFamilyAttribute: @"Avenir Next Condensed",
//                                                 UIFontDescriptorNameAttribute:@"AvenirNextCondensed-Italic",
//                                                 UIFontDescriptorSizeAttribute: @40.0,
//                                               UIFontDescriptorMatrixAttribute:[NSValue valueWithCGAffineTransform:CGAffineTransformMakeRotation(M_1_PI*1.5)]}];
//UIFont *font = [UIFont fontWithDescriptor:attributeFontDescriptor size:0.0];

- (UIFont *)fontWithBold
{
    if (![self respondsToSelector:@selector(fontDescriptor)]) return nil;
    return [UIFont fontWithDescriptor:[self.fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold] size:self.pointSize];
}

- (UIFont *)fontWithItalic
{
    if (![self respondsToSelector:@selector(fontDescriptor)]) return nil;
    return [UIFont fontWithDescriptor:[self.fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitItalic] size:self.pointSize];
}

- (UIFont *)fontWithBoldItalic
{
    if (![self respondsToSelector:@selector(fontDescriptor)]) return nil;
    return [UIFont fontWithDescriptor:[self.fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold | UIFontDescriptorTraitItalic] size:self.pointSize];
}

- (UIFont *)fontWithNormal
{
    if (![self respondsToSelector:@selector(fontDescriptor)]) return nil;
    return [UIFont fontWithDescriptor:[self.fontDescriptor fontDescriptorWithSymbolicTraits:0] size:self.pointSize];
}


@end
