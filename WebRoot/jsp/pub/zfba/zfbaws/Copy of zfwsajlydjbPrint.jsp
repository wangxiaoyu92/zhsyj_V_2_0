<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="/WEB-INF/fn.tld" %>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
int page_number=1;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:w="urn:schemas-microsoft-com:office:word"
xmlns:m="http://schemas.microsoft.com/office/2004/12/omml"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<meta name=ProgId content=Word.Document>
<meta name=Generator content="Microsoft Word 12">
<meta name=Originator content="Microsoft Word 12">
<link rel=File-List href="案件来源登记表.files/filelist.xml">
<link rel=Edit-Time-Data href="案件来源登记表.files/editdata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>88</o:TotalTime>
  <o:Created>2016-02-26T08:08:00Z</o:Created>
  <o:LastSaved>2016-02-26T08:08:00Z</o:LastSaved>
  <o:Pages>2</o:Pages>
  <o:Words>140</o:Words>
  <o:Characters>798</o:Characters>
  <o:Company>Sky123.Org</o:Company>
  <o:Lines>6</o:Lines>
  <o:Paragraphs>1</o:Paragraphs>
  <o:CharactersWithSpaces>937</o:CharactersWithSpaces>
  <o:Version>12.00</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<link rel=themeData href="案件来源登记表.files/themedata.thmx">
<link rel=colorSchemeMapping href="案件来源登记表.files/colorschememapping.xml">
<!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:TrackMoves>false</w:TrackMoves>
  <w:TrackFormatting/>
  <w:PunctuationKerning/>
  <w:DrawingGridVerticalSpacing>7.8 磅</w:DrawingGridVerticalSpacing>
  <w:DisplayHorizontalDrawingGridEvery>0</w:DisplayHorizontalDrawingGridEvery>
  <w:DisplayVerticalDrawingGridEvery>2</w:DisplayVerticalDrawingGridEvery>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:DoNotPromoteQF/>
  <w:LidThemeOther>EN-US</w:LidThemeOther>
  <w:LidThemeAsian>ZH-CN</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:Compatibility>
   <w:SpaceForUL/>
   <w:BalanceSingleByteDoubleByteWidth/>
   <w:DoNotLeaveBackslashAlone/>
   <w:ULTrailSpace/>
   <w:DoNotExpandShiftReturn/>
   <w:AdjustLineHeightInTable/>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:DontGrowAutofit/>
   <w:DontUseIndentAsNumberingTabStop/>
   <w:FELineBreak11/>
   <w:WW11IndentRules/>
   <w:DontAutofitConstrainedTables/>
   <w:AutofitLikeWW11/>
   <w:HangulWidthLikeWW11/>
   <w:UseNormalStyleForList/>
   <w:UseFELayout/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
  <m:mathPr>
   <m:mathFont m:val="Cambria Math"/>
   <m:brkBin m:val="before"/>
   <m:brkBinSub m:val="--"/>
   <m:smallFrac m:val="off"/>
   <m:dispDef/>
   <m:lMargin m:val="0"/>
   <m:rMargin m:val="0"/>
   <m:defJc m:val="centerGroup"/>
   <m:wrapIndent m:val="1440"/>
   <m:intLim m:val="subSup"/>
   <m:naryLim m:val="undOvr"/>
  </m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="true"
  DefSemiHidden="true" DefQFormat="false" DefPriority="99"
  LatentStyleCount="267">
  <w:LsdException Locked="false" Priority="0" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Normal"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="heading 1"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 2"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 3"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 4"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 5"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 6"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 7"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 8"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 9"/>
  <w:LsdException Locked="false" Priority="39" Name="toc 1"/>
  <w:LsdException Locked="false" Priority="39" Name="toc 2"/>
  <w:LsdException Locked="false" Priority="39" Name="toc 3"/>
  <w:LsdException Locked="false" Priority="39" Name="toc 4"/>
  <w:LsdException Locked="false" Priority="39" Name="toc 5"/>
  <w:LsdException Locked="false" Priority="39" Name="toc 6"/>
  <w:LsdException Locked="false" Priority="39" Name="toc 7"/>
  <w:LsdException Locked="false" Priority="39" Name="toc 8"/>
  <w:LsdException Locked="false" Priority="39" Name="toc 9"/>
  <w:LsdException Locked="false" Priority="35" QFormat="true" Name="caption"/>
  <w:LsdException Locked="false" Priority="10" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Title"/>
  <w:LsdException Locked="false" Priority="1" Name="Default Paragraph Font"/>
  <w:LsdException Locked="false" Priority="11" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtitle"/>
  <w:LsdException Locked="false" Priority="22" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Strong"/>
  <w:LsdException Locked="false" Priority="20" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Emphasis"/>
  <w:LsdException Locked="false" Priority="59" SemiHidden="false"
   UnhideWhenUsed="false" Name="Table Grid"/>
  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Placeholder Text"/>
  <w:LsdException Locked="false" Priority="1" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="No Spacing"/>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading"/>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List"/>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid"/>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1"/>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2"/>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1"/>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2"/>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1"/>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2"/>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3"/>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List"/>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading"/>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List"/>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid"/>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 1"/>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 1"/>
  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Revision"/>
  <w:LsdException Locked="false" Priority="34" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="List Paragraph"/>
  <w:LsdException Locked="false" Priority="29" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Quote"/>
  <w:LsdException Locked="false" Priority="30" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Quote"/>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 1"/>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 1"/>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 2"/>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 2"/>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 2"/>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 3"/>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 3"/>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 3"/>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 4"/>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 4"/>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 4"/>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 5"/>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 5"/>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 5"/>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 6"/>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 6"/>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 6"/>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="19" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtle Emphasis"/>
  <w:LsdException Locked="false" Priority="21" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Emphasis"/>
  <w:LsdException Locked="false" Priority="31" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtle Reference"/>
  <w:LsdException Locked="false" Priority="32" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Reference"/>
  <w:LsdException Locked="false" Priority="33" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Book Title"/>
  <w:LsdException Locked="false" Priority="37" Name="Bibliography"/>
  <w:LsdException Locked="false" Priority="39" QFormat="true" Name="TOC Heading"/>
 </w:LatentStyles>
</xml><![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:宋体;
	panose-1:2 1 6 0 3 1 1 1 1 1;
	mso-font-alt:SimSun;
	mso-font-charset:134;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:3 680460288 22 0 262145 0;}
@font-face
	{font-family:黑体;
	panose-1:2 1 6 9 6 1 1 1 1 1;
	mso-font-alt:SimHei;
	mso-font-charset:134;
	mso-generic-font-family:modern;
	mso-font-pitch:fixed;
	mso-font-signature:-2147482945 953122042 22 0 262145 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;
	mso-font-charset:0;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:-536870145 1107305727 0 0 415 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-520092929 1073786111 9 0 415 0;}
@font-face
	{font-family:仿宋_GB2312;
	mso-font-alt:"Arial Unicode MS";
	mso-font-charset:134;
	mso-generic-font-family:modern;
	mso-font-pitch:auto;
	mso-font-signature:0 135135232 0 0 262144 0;}
@font-face
	{font-family:仿宋;
	panose-1:2 1 6 9 6 1 1 1 1 1;
	mso-font-charset:134;
	mso-generic-font-family:modern;
	mso-font-pitch:fixed;
	mso-font-signature:-2147482945 953122042 22 0 262145 0;}
@font-face
	{font-family:"\@宋体";
	panose-1:2 1 6 0 3 1 1 1 1 1;
	mso-font-charset:134;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:3 680460288 22 0 262145 0;}
@font-face
	{font-family:"\@仿宋";
	panose-1:2 1 6 9 6 1 1 1 1 1;
	mso-font-charset:134;
	mso-generic-font-family:modern;
	mso-font-pitch:fixed;
	mso-font-signature:-2147482945 953122042 22 0 262145 0;}
@font-face
	{font-family:"\@黑体";
	panose-1:2 1 6 9 6 1 1 1 1 1;
	mso-font-charset:134;
	mso-generic-font-family:modern;
	mso-font-pitch:fixed;
	mso-font-signature:-2147482945 953122042 22 0 262145 0;}
@font-face
	{font-family:"\@仿宋_GB2312";
	mso-font-charset:134;
	mso-generic-font-family:modern;
	mso-font-pitch:auto;
	mso-font-signature:0 135135232 0 0 262144 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-parent:"";
	margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	mso-pagination:none;
	font-size:10.5pt;
	mso-bidi-font-size:12.0pt;
	font-family:"Times New Roman","serif";
	mso-fareast-font-family:宋体;
	mso-font-kerning:1.0pt;}
p.MsoHeader, li.MsoHeader, div.MsoHeader
	{mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-link:"页眉 Char";
	margin:0cm;
	margin-bottom:.0001pt;
	text-align:center;
	mso-pagination:none;
	tab-stops:center 207.65pt right 415.3pt;
	layout-grid-mode:char;
	border:none;
	mso-border-bottom-alt:solid windowtext .75pt;
	padding:0cm;
	mso-padding-alt:0cm 0cm 1.0pt 0cm;
	font-size:9.0pt;
	font-family:"Times New Roman","serif";
	mso-fareast-font-family:宋体;
	mso-font-kerning:1.0pt;}
p.MsoFooter, li.MsoFooter, div.MsoFooter
	{mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-link:"页脚 Char";
	margin:0cm;
	margin-bottom:.0001pt;
	mso-pagination:none;
	tab-stops:center 207.65pt right 415.3pt;
	layout-grid-mode:char;
	font-size:9.0pt;
	font-family:"Times New Roman","serif";
	mso-fareast-font-family:宋体;
	mso-font-kerning:1.0pt;}
p.p17, li.p17, div.p17
	{mso-style-name:p17;
	mso-style-unhide:no;
	margin-top:5.0pt;
	margin-right:0cm;
	margin-bottom:5.0pt;
	margin-left:0cm;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:宋体;
	mso-bidi-font-family:宋体;}
span.Char
	{mso-style-name:"页眉 Char";
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-unhide:no;
	mso-style-locked:yes;
	mso-style-link:页眉;
	mso-ansi-font-size:9.0pt;
	mso-bidi-font-size:9.0pt;
	font-family:"Times New Roman","serif";
	mso-ascii-font-family:"Times New Roman";
	mso-hansi-font-family:"Times New Roman";
	mso-font-kerning:1.0pt;}
span.Char0
	{mso-style-name:"页脚 Char";
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-unhide:no;
	mso-style-locked:yes;
	mso-style-link:页脚;
	mso-ansi-font-size:9.0pt;
	mso-bidi-font-size:9.0pt;
	font-family:"Times New Roman","serif";
	mso-ascii-font-family:"Times New Roman";
	mso-hansi-font-family:"Times New Roman";
	mso-font-kerning:1.0pt;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-default-props:yes;
	mso-ascii-font-family:Calibri;
	mso-fareast-font-family:宋体;
	mso-hansi-font-family:Calibri;}
 /* Page Definitions */
 @page
	{mso-page-border-surround-header:no;
	mso-page-border-surround-footer:no;
	mso-footnote-separator:url("案件来源登记表.files/header.htm") fs;
	mso-footnote-continuation-separator:url("案件来源登记表.files/header.htm") fcs;
	mso-endnote-separator:url("案件来源登记表.files/header.htm") es;
	mso-endnote-continuation-separator:url("案件来源登记表.files/header.htm") ecs;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;
	mso-header-margin:42.55pt;
	mso-footer-margin:49.6pt;
	mso-paper-source:0;
	layout-grid:15.6pt;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:普通表格;
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-qformat:yes;
	mso-style-parent:"";
	mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
	mso-para-margin:0cm;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Calibri","sans-serif";
	mso-bidi-font-family:"Times New Roman";}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="3074"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
 
<!-- 引入库 -->

<jsp:include page="${path}/inc.jsp"></jsp:include>

 <jsp:include page="${path}/inc.jsp"></jsp:include>  
 
 <script language="javascript" src="<%=basePath %>lodop/LodopFuncs.js"></script>

<!-- 插入打印控件 -->

<object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0> 
	<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0 pluginspage="<%=basePath %>lodop/install_lodop32.exe"></embed>
</object>

<style>
.Noprint{text-align:center;} 
.PageNext{page-break-after: always;} 
</style>

<script language="javascript" type="text/javascript">
var LODOP; //声明为全局变量
//打印预览 
function printView(){	
	CreatePrintPage();
  	LODOP.PREVIEW();		
};

//直接打印
function printData(){		
	CreatePrintPage();
  	LODOP.PRINT();		
};

//打印维护
function printSetup() {		
	CreatePrintPage();
	LODOP.PRINT_SETUP();		
};

//打印设计
function printDesign() {		
	CreatePrintPage();
	LODOP.PRINT_DESIGN();		
};
	
function CreatePrintPage() {
	LODOP=getLodop();  
	
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——案件来源登记表");
	LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向
	LODOP.ADD_PRINT_HTM("20mm","20mm","85%","100%",document.getElementById("page1").innerHTML);
	LODOP.NEWPAGE ();
	LODOP.ADD_PRINT_HTM("20mm","20mm","85%","100%",document.getElementById("page2").innerHTML);
}
</script>

</head>

<body lang=ZH-CN style='tab-interval:21.0pt;text-justify-trim:punctuation'>
<div class="Noprint">
	<!-- 
    <a href="javascript:void(0)" id="pagesetBtn" icon="icon-page-set" class="easyui-linkbutton" onclick=" printSetup();">打印维护</a>
	<a href="javascript:void(0)" id="pagesetBtn" icon="icon-page-set" class="easyui-linkbutton" onclick=" printDesign();">打印设计</a>
	-->
	<a href="javascript:void(0)" id="printViewBtn" icon="icon-page-find" class="easyui-linkbutton" onclick="printView();">打证预览</a>
	<a href="javascript:void(0)" id="saveBtn" icon="icon-print" class="easyui-linkbutton" onclick="printData();">直接打证</a>
	<a href="javascript:void(0)" id="backBtn" icon="icon-back" class="easyui-linkbutton" onclick="javascript:window.close()">关闭返回</a>
</div>

<div class=Section1 style='layout-grid:15.6pt'>
<div align="center" id="page<%=page_number %>">
<p class=p17 align=center style='margin:0cm;margin-bottom:.0001pt;text-align:
center'><b><span style='font-size:16.0pt;font-family:黑体;color:black'>食品药品行政处罚文书<span
lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal align=center style='text-align:center'><b style='mso-bidi-font-weight:
normal'><span style='font-size:22.0pt;font-family:宋体;mso-ascii-font-family:
"Times New Roman";mso-hansi-font-family:"Times New Roman";color:black'>案件来源登记表</span></b><span
lang=EN-US style='font-size:22.0pt;color:black'><o:p></o:p></span></p>

<p class=MsoNormal align=right style='margin-top:7.8pt;mso-para-margin-top:
.5gd;text-align:right'><span lang=EN-US style='font-size:10.0pt;font-family:
仿宋_GB2312;mso-hansi-font-family:仿宋;color:black'><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span style='font-size:10.0pt;font-family:仿宋_GB2312;mso-hansi-font-family:
仿宋;color:black'>（</span><span style='mso-bidi-font-size:10.5pt;font-family:
仿宋_GB2312;mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:black'>××</span><span
style='font-size:10.0pt;font-family:仿宋_GB2312;mso-hansi-font-family:仿宋;
color:black'>）食药监</span><span style='mso-bidi-font-size:10.5pt;font-family:
仿宋_GB2312;mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:black'>×</span><span
style='font-size:10.0pt;font-family:仿宋_GB2312;mso-hansi-font-family:仿宋;
color:black'>案源〔年份〕</span><span style='mso-bidi-font-size:10.5pt;font-family:
仿宋_GB2312;mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:black'>×</span><span
style='font-size:10.0pt;font-family:仿宋_GB2312;mso-hansi-font-family:仿宋;
color:black'>号<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='margin-top:7.8pt;mso-para-margin-top:.5gd;text-indent:
5.0pt;mso-char-indent-count:.5'><!--[if gte vml 1]><v:line id="Line_x0020_10"
 o:spid="_x0000_s1026" style='position:absolute;left:0;text-align:left;
 z-index:1' from="-9pt,0" to="433.2pt,.05pt" strokeweight="1.5pt"/><![endif]--><![if !vml]><span
style='mso-ignore:vglayout;position:relative;z-index:1'><span style='left:0px;
position:absolute;left:-13px;top:-1px;width:592px;height:3px'><img width=592
height=3 src="案件来源登记表.files/image001.gif" v:shapes="Line_x0020_10"></span></span><![endif]><span
style='font-family:仿宋_GB2312;mso-hansi-font-family:仿宋;color:black'>案件来源：</span><span
style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;mso-hansi-font-family:
仿宋;color:black;mso-font-kerning:0pt'>□</span><span style='font-family:仿宋_GB2312;
mso-hansi-font-family:仿宋;color:black;mso-font-kerning:0pt'>监督检查<span
lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><span style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;
mso-hansi-font-family:仿宋;color:black;mso-font-kerning:0pt'>□</span><span
style='font-family:仿宋_GB2312;mso-hansi-font-family:仿宋;color:black;mso-font-kerning:
0pt'>投诉<span lang=EN-US>/</span>举报<span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><span style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;
mso-hansi-font-family:仿宋;color:black;mso-font-kerning:0pt'>□</span><span
style='font-family:仿宋_GB2312;mso-hansi-font-family:仿宋;color:black;mso-font-kerning:
0pt'>上级交办<span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><span
style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;mso-hansi-font-family:
仿宋;color:black;mso-font-kerning:0pt'>□</span><span style='font-family:仿宋_GB2312;
mso-hansi-font-family:仿宋;color:black;mso-font-kerning:0pt'>下级报请<span
lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><o:p></o:p></span></span></p>

<p class=MsoNormal style='margin-top:7.8pt;margin-right:0cm;margin-bottom:0cm;
margin-left:57.75pt;margin-bottom:.0001pt;mso-para-margin-top:.5gd;mso-para-margin-right:
0cm;mso-para-margin-bottom:0cm;mso-para-margin-left:5.0gd;mso-para-margin-bottom:
.0001pt;text-indent:-5.25pt;mso-char-indent-count:-.5;mso-pagination:widow-orphan;
layout-grid-mode:char'><span style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;
mso-hansi-font-family:仿宋;color:black;mso-font-kerning:0pt'>□</span><span
style='font-family:仿宋_GB2312;mso-hansi-font-family:仿宋;color:black;mso-font-kerning:
0pt'>监督抽验<span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><span style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;
mso-hansi-font-family:仿宋;color:black;mso-font-kerning:0pt'>□</span><span
style='font-family:仿宋_GB2312;mso-hansi-font-family:仿宋;color:black;mso-font-kerning:
0pt'>移送<span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><span style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;
mso-hansi-font-family:仿宋;color:black;mso-font-kerning:0pt'>□其他</span><u><span
lang=EN-US style='font-family:仿宋_GB2312;mso-hansi-font-family:仿宋;color:black;
mso-font-kerning:0pt'><o:p></o:p></span></u></p>

<p class=MsoNormal style='margin-top:7.8pt;mso-para-margin-top:.5gd;text-indent:
5.25pt;mso-char-indent-count:.5'><span style='font-family:仿宋_GB2312;mso-hansi-font-family:
仿宋;color:black'>当事人：<u><span lang=EN-US><span
style='mso-spacerun:yes'>${printbean.wslydsr}
</span><span style='mso-spacerun:yes'>&nbsp;&nbsp;</span><o:p></o:p></span></u></span></p>

<p class=MsoNormal style='margin-top:7.8pt;mso-para-margin-top:.5gd;text-indent:
5.25pt;mso-char-indent-count:.5'><span style='font-family:仿宋_GB2312;mso-hansi-font-family:
仿宋;color:black'>地址<span lang=EN-US>:<u><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></u></span>邮编：<u><span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><o:p></o:p></span></u></span></p>

<p class=MsoNormal style='margin-top:7.8pt;mso-para-margin-top:.5gd;text-indent:
5.25pt;mso-char-indent-count:.5'><span style='font-family:仿宋_GB2312;mso-hansi-font-family:
仿宋;color:black;mso-font-kerning:0pt'>法定代表人（负责人）<span lang=EN-US>/</span>自然人<span
lang=EN-US>:<u><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></u></span>联系电话<span lang=EN-US>:<u><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><o:p></o:p></u></span></span></p>

<p class=MsoNormal align=left style='margin-top:7.8pt;mso-para-margin-top:.5gd;
text-align:left;text-indent:5.25pt;mso-char-indent-count:.5'><span
style='font-family:仿宋_GB2312;mso-hansi-font-family:仿宋;color:black;mso-font-kerning:
0pt'>法定代表人（负责人）<span lang=EN-US>/</span>自然人身份证号码：<u><span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><o:p></o:p></span></u></span></p>

<p class=MsoNormal align=left style='margin-top:7.8pt;mso-para-margin-top:.5gd;
text-align:left;text-indent:5.05pt;mso-char-indent-count:.5'><span
style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;mso-hansi-font-family:
仿宋;color:black;letter-spacing:-.2pt;mso-font-kerning:0pt'>登记时间</span><span
style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;mso-hansi-font-family:
仿宋;color:black;letter-spacing:-.2pt'>：<u><span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></u></span><span style='mso-bidi-font-size:10.5pt;font-family:
仿宋_GB2312;mso-hansi-font-family:仿宋;color:black;letter-spacing:-.2pt;mso-font-kerning:
0pt'>年<u><span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></u>月<u><span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></u>日<u>　<span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></u>时<u>　<span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></u>分</span><span lang=EN-US style='mso-bidi-font-size:10.5pt;
font-family:仿宋_GB2312;mso-hansi-font-family:仿宋;color:black;letter-spacing:-.2pt'><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:7.8pt;margin-right:0cm;margin-bottom:0cm;
margin-left:5.05pt;margin-bottom:.0001pt;mso-para-margin-top:.5gd;mso-para-margin-right:
0cm;mso-para-margin-bottom:0cm;mso-para-margin-left:.48gd;mso-para-margin-bottom:
.0001pt'><!--[if gte vml 1]><v:line id="Line_x0020_12" o:spid="_x0000_s1028"
 style='position:absolute;left:0;text-align:left;z-index:3' from="-9pt,3.25pt"
 to="433.2pt,3.3pt" strokeweight="1.5pt"/><![endif]--><![if !vml]><span
style='mso-ignore:vglayout;position:absolute;z-index:3;left:0px;margin-left:
-13px;margin-top:3px;width:592px;height:3px'><img width=592 height=3
src="案件来源登记表.files/image001.gif" v:shapes="Line_x0020_12"></span><![endif]><span
style='font-family:仿宋_GB2312;mso-hansi-font-family:仿宋;color:black'>基本情况介绍：（</span><span
style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;color:black'>负责人，案发时间、地点，重要证据，危害后果及其影响等</span><span
style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;mso-hansi-font-family:
仿宋;color:black'>）<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal><span lang=EN-US style='mso-bidi-font-size:10.5pt;
font-family:仿宋_GB2312;mso-hansi-font-family:仿宋;color:black'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span lang=EN-US style='font-family:仿宋_GB2312;mso-hansi-font-family:
仿宋;color:black'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span lang=EN-US style='font-family:仿宋_GB2312;mso-hansi-font-family:
仿宋;color:black'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span lang=EN-US style='font-family:仿宋_GB2312;mso-hansi-font-family:
仿宋;color:black'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-top:12.0pt;text-indent:21.0pt;mso-char-indent-count:
2.0'><span lang=EN-US style='font-family:仿宋_GB2312;mso-hansi-font-family:仿宋;
color:black'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-top:12.0pt;text-indent:21.0pt;mso-char-indent-count:
2.0'><span lang=EN-US style='font-family:仿宋_GB2312;mso-hansi-font-family:仿宋;
color:black'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-top:12.0pt;text-indent:26.25pt;mso-char-indent-count:
2.5'><span style='font-family:仿宋_GB2312;mso-hansi-font-family:仿宋;color:black'>附件：（</span><span
style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;mso-hansi-font-family:
宋体;color:black'>现场检查笔录、投诉举报材料、检测（检验）报告、相关部门移送材料等</span><span style='mso-bidi-font-size:
10.5pt;font-family:仿宋_GB2312;mso-hansi-font-family:仿宋;color:black'>）<span
lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
style='font-family:仿宋_GB2312;mso-hansi-font-family:仿宋;color:black'><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><o:p></o:p></span></p>

<p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
style='font-family:仿宋_GB2312;mso-hansi-font-family:仿宋;color:black'><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><o:p></o:p></span></p>

</div>
<%page_number++; %>
<div align="center" id="page<%=page_number %>">

<p class=MsoNormal align=right style='margin-top:7.8pt;mso-para-margin-top:
.5gd;text-align:right'><span lang=EN-US style='font-family:仿宋_GB2312;
mso-hansi-font-family:仿宋;color:black'><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;
mso-hansi-font-family:仿宋;mso-bidi-font-family:仿宋;color:black'>记录人：</span><u><span
style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;mso-hansi-font-family:
Arial;mso-bidi-font-family:Arial;color:black'>×××</span></u><u><span
lang=EN-US style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;mso-hansi-font-family:
仿宋;mso-bidi-font-family:仿宋;color:black'>(</span></u><u><span style='mso-bidi-font-size:
10.5pt;font-family:仿宋_GB2312;mso-hansi-font-family:仿宋;mso-bidi-font-family:
仿宋;color:black'>签字<span lang=EN-US>)<o:p></o:p></span></span></u></p>

<p class=MsoNormal align=right style='margin-top:7.8pt;mso-para-margin-top:
.5gd;text-align:right'><span lang=EN-US style='mso-bidi-font-size:10.5pt;
font-family:仿宋_GB2312;mso-hansi-font-family:仿宋;mso-bidi-font-family:仿宋;
color:black'><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span><span
style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;mso-hansi-font-family:
Arial;mso-bidi-font-family:Arial;color:black'>×</span><span style='mso-bidi-font-size:
10.5pt;font-family:仿宋_GB2312;mso-hansi-font-family:仿宋;mso-bidi-font-family:
仿宋;color:black'>年</span><span style='mso-bidi-font-size:10.5pt;font-family:
仿宋_GB2312;mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:black'>×</span><span
style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;mso-hansi-font-family:
仿宋;mso-bidi-font-family:仿宋;color:black'>月</span><span style='mso-bidi-font-size:
10.5pt;font-family:仿宋_GB2312;mso-hansi-font-family:Arial;mso-bidi-font-family:
Arial;color:black'>×</span><span style='mso-bidi-font-size:10.5pt;font-family:
仿宋_GB2312;mso-hansi-font-family:仿宋;mso-bidi-font-family:仿宋;color:black'>日<span
lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;mso-hansi-font-family:
仿宋;mso-bidi-font-family:仿宋;color:black'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-top:7.8pt;mso-para-margin-top:.5gd;text-indent:
5.25pt;mso-char-indent-count:.5'><!--[if gte vml 1]><v:line id="Line_x0020_13"
 o:spid="_x0000_s1029" style='position:absolute;left:0;text-align:left;
 z-index:4' from="-9pt,3.9pt" to="433.2pt,3.95pt" strokeweight="1.25pt"/><![endif]--><![if !vml]><span
style='mso-ignore:vglayout;position:absolute;z-index:4;left:0px;margin-left:
-13px;margin-top:4px;width:592px;height:3px'><img width=592 height=3
src="案件来源登记表.files/image001.gif" v:shapes="Line_x0020_13"></span><![endif]><span
style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;mso-hansi-font-family:
仿宋;mso-bidi-font-family:仿宋;color:black'>处理意见：<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='margin-top:7.8pt;mso-para-margin-top:.5gd;text-indent:
246.75pt;mso-char-indent-count:23.5'><span lang=EN-US style='mso-bidi-font-size:
10.5pt;font-family:仿宋_GB2312;mso-hansi-font-family:仿宋;mso-bidi-font-family:
仿宋;color:black'><span style='mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:7.8pt;mso-para-margin-top:.5gd;text-indent:
246.75pt;mso-char-indent-count:23.5'><span lang=EN-US style='mso-bidi-font-size:
10.5pt;font-family:仿宋_GB2312;mso-hansi-font-family:仿宋;mso-bidi-font-family:
仿宋;color:black'><span style='mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></p>

<p class=MsoNormal align=right style='margin-top:7.8pt;mso-para-margin-top:
.5gd;text-align:right'><span lang=EN-US style='mso-bidi-font-size:10.5pt;
font-family:仿宋_GB2312;mso-hansi-font-family:仿宋;mso-bidi-font-family:仿宋;
color:black'><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;
mso-hansi-font-family:仿宋;mso-bidi-font-family:仿宋;color:black'>负责人：</span><u><span
style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;mso-hansi-font-family:
Arial;mso-bidi-font-family:Arial;color:black'>×××</span></u><u><span
lang=EN-US style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;mso-hansi-font-family:
仿宋;mso-bidi-font-family:仿宋;color:black'>(</span></u><u><span style='mso-bidi-font-size:
10.5pt;font-family:仿宋_GB2312;mso-hansi-font-family:仿宋;mso-bidi-font-family:
仿宋;color:black'>签字<span lang=EN-US>)</span></span></u><span lang=EN-US
style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;mso-hansi-font-family:
仿宋;mso-bidi-font-family:仿宋;color:black'><span
style='mso-spacerun:yes'>&nbsp;&nbsp; </span><u><o:p></o:p></u></span></p>

<p class=MsoNormal align=right style='margin-top:7.8pt;mso-para-margin-top:
.5gd;text-align:right'><!--[if gte vml 1]><v:line id="Line_x0020_11" o:spid="_x0000_s1027"
 style='position:absolute;left:0;text-align:left;z-index:2' from="-9pt,31.8pt"
 to="433.2pt,31.85pt" strokeweight="1.5pt"/><![endif]--><![if !vml]><span
style='mso-ignore:vglayout;position:absolute;z-index:2;left:0px;margin-left:
-13px;margin-top:41px;width:592px;height:3px'><img width=592 height=3
src="案件来源登记表.files/image001.gif" v:shapes="Line_x0020_11"></span><![endif]><span
lang=EN-US style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;mso-hansi-font-family:
仿宋;mso-bidi-font-family:仿宋;color:black'><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;
mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:black'>×</span><span
style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;mso-hansi-font-family:
仿宋;mso-bidi-font-family:仿宋;color:black'>年</span><span style='mso-bidi-font-size:
10.5pt;font-family:仿宋_GB2312;mso-hansi-font-family:Arial;mso-bidi-font-family:
Arial;color:black'>×</span><span style='mso-bidi-font-size:10.5pt;font-family:
仿宋_GB2312;mso-hansi-font-family:仿宋;mso-bidi-font-family:仿宋;color:black'>月</span><span
style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;mso-hansi-font-family:
Arial;mso-bidi-font-family:Arial;color:black'>×</span><span style='mso-bidi-font-size:
10.5pt;font-family:仿宋_GB2312;mso-hansi-font-family:仿宋;mso-bidi-font-family:
仿宋;color:black'>日<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='margin-top:7.8pt;mso-para-margin-top:.5gd'><span
lang=EN-US style='font-size:12.0pt;font-family:宋体;color:black;mso-bidi-font-weight:
bold'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

</div>
</div>

</body>

</html>
