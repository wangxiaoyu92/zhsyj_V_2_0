package com.zzhdsoft.utils;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.axis.utils.StringUtils;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.collections.FastHashMap;
import org.apache.log4j.Logger;

import com.zzhdsoft.GlobalNames;

/**
 * 
 *  StringHelper的中文名称：处理字符串工具类
 *
 *  StringHelper的描述：
 *
 *  Written  by  : zjf
 */
public class StringHelper
{
	static String htmlMatch = ""; 
	
    public static String array2string(Object aobj[])
    {
        StringBuffer stringbuffer = new StringBuffer();
        if(aobj != null)
        {
            stringbuffer.append("\n");
            for(int i = 0; i < aobj.length; i++)
            {
                stringbuffer.append("\n");
                stringbuffer.append(aobj[i]).append(";\t");
            }
        }
        return stringbuffer.toString();
    }

    public static String array2string(Object aobj[][])
    {
        StringBuffer stringbuffer = new StringBuffer();
        if(aobj != null)
        {
            stringbuffer.append("\n");
            for(int i = 0; i < aobj.length; i++)
            {
                stringbuffer.append("\n");
                Object aobj1[] = aobj[i];
                if(aobj1 != null)
                {
                    for(int j = 0; j < aobj1.length; j++)
                        stringbuffer.append(aobj1[j]).append(";\t");

                }
            }

        }
        return stringbuffer.toString();
    }

    public static String AsciiToChineseString(String s)
    {
        char ac[] = s.toCharArray();
        byte abyte0[] = new byte[ac.length];
        for(int i = 0; i < ac.length; i++)
            abyte0[i] = (byte)(ac[i] & 0xff);

        try
        {
            return new String(abyte0, "GBK");
        }
        catch(Exception exception)
        {
            System.out.println(exception);
        }
        return s;
    }

    public static String ChineseStringToAscii(String s)
    {
        try
        {
            byte abyte0[] = s.getBytes("GBK");
            char ac[] = new char[abyte0.length];
            for(int i = 0; i < abyte0.length; i++)
                ac[i] = (char)(abyte0[i] & 0xff);

            return new String(ac);
        }
        catch(Exception exception)
        {
            System.out.println(exception);
        }
        return s;
    }

    public static String ChineseStringToUTF(String s)
    {
        try
        {
            byte abyte0[] = s.getBytes("UTF-8");
            char ac[] = new char[abyte0.length];
            for(int i = 0; i < abyte0.length; i++)
                ac[i] = (char)(abyte0[i] & 0xff);

            return new String(ac);
        }
        catch(Exception exception)
        {
            System.out.println(exception);
        }
        return s;
    }

    public static String convertCardID(String s)
    {
        String s1 = "";
        if(s != null && s.trim() != "")
        {
            String s2 = s.trim();
            if(s2.length() == 15)
            {
                s1 = s2.substring(0, 6) + "19" + s2.substring(6, 15);
                s1 = s1 + createCK(s1);
            } else
            if(s2.length() == 18)
                s1 = s2.substring(0, 6) + s2.substring(8, 17);
        }
        return s1;
    }

    public static int countMonths(String s, String s1)
    {
        String s2 = s.substring(0, 4);
        String s3 = s1.substring(0, 4);
        String s4 = s.substring(4, 6);
        String s5 = s1.substring(4, 6);
        int i = (new Integer(s3)).intValue() - (new Integer(s2)).intValue();
        int j = ((i * 12 + (new Integer(s5)).intValue()) - (new Integer(s4)).intValue()) + 1;
        return j;
    }

    public static String createCK(String s)
    {
        int j = 0;
        int ai[] = {
            7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 
            7, 9, 10, 5, 8, 4, 2, 1
        };
        String as[] = {
            "1", "0", "X", "9", "8", "7", "6", "5", "4", "3", 
            "2"
        };
        for(int i = 0; i < s.length(); i++)
        {
            int k = Integer.parseInt(s.substring(i, i + 1)) * ai[i];
            j += k;
        }

        j %= 11;
        return as[j];
    }

    public static synchronized String dealOrderBy(String s)
    {
        s = regexReplace("\\s+", " ", s);
        String s1 = s;
        if(exist("order\\s+by", s1.toLowerCase()))
        {
            s1 = regexReplace("order\\s+by", GlobalNames.ORDER_BY, s1.toLowerCase());
            int i = s1.lastIndexOf(GlobalNames.ORDER_BY);
            s = s.substring(0, i) + GlobalNames.ORDER_BY + " " + s.substring(i + 8);
        }
        return s;
    }

    public static String decodeBase64(String s) throws Exception
    {
        try
        {
            return new String(Base64.decodeBase64(s.getBytes("gb2312")), "gb2312");
        }
        catch(UnsupportedEncodingException unsupportedencodingexception)
        {
            throw new Exception("\u7CFB\u7EDF\u4E0D\u652F\u6301GB2312\u5B57\u7B26\u96C6\u7F16\u7801\uFF01", unsupportedencodingexception);
        }
    }

    public static String decodeBase64(String s, String s1) throws Exception
    {
        try
        {
            return new String(Base64.decodeBase64(s.getBytes("gb2312")), s1);
        }
        catch(UnsupportedEncodingException unsupportedencodingexception)
        {
            throw new Exception("\u7CFB\u7EDF\u4E0D\u652F\u6301" + s1 + "\u5B57\u7B26\u96C6\u7F16\u7801\uFF01", unsupportedencodingexception);
        }
    }

    public static String decodeForward(String s)
    {
        s = replace(s, GlobalNames.AND, "&");
        return s;
    }

    public static String encodeBase64(String s) throws Exception
    {
        try
        {
            return new String(Base64.encodeBase64(s.getBytes("gb2312")));
        }
        catch(UnsupportedEncodingException unsupportedencodingexception)
        {
            throw new Exception("\u7CFB\u7EDF\u4E0D\u652F\u6301GB2312\u5B57\u7B26\u96C6\u7F16\u7801\uFF01", unsupportedencodingexception);
        }
    }

    public static String encodeBase64(String s, String s1) throws Exception
    {
        try
        {
            return new String(Base64.encodeBase64(s.getBytes(s1)));
        }
        catch(UnsupportedEncodingException unsupportedencodingexception)
        {
            throw new Exception("\u7CFB\u7EDF\u4E0D\u652F\u6301" + s1 + "\u5B57\u7B26\u96C6\u7F16\u7801\uFF01", unsupportedencodingexception);
        }
    }

    public static String encodeForward(String s)
    {
        s = replace(s, "&", GlobalNames.AND);
        return s;
    }

    public static synchronized boolean exist(String s, String s1)
    {
        Pattern pattern = a(s);
        Matcher matcher = pattern.matcher(s1);
        return matcher.find();
    }

    public static String fillZero(String s, int i)
    {
        String s1;
        if(s.length() < i)
        {
            char ac[] = new char[i - s.length()];
            for(int j = 0; j < i - s.length(); j++)
                ac[j] = '0';

            s1 = new String(ac) + s;
        } else
        {
            s1 = s;
        }
        return s1;
    }

    public static String followZero(String s, int i)
    {
        String s1;
        if(s.length() < i)
        {
            char ac[] = new char[i - s.length()];
            for(int j = 0; j < i - s.length(); j++)
                ac[j] = '0';

            s1 = s + new String(ac);
        } else
        {
            s1 = s;
        }
        return s1;
    }

    public static String genUUID()
    {
    	 UUID uuid = UUID.randomUUID();
    	 return uuid.toString();
    }

    public static int getIndex(String as[], String s)
    {
        if(as != null)
        {
            for(int i = 0; i < as.length; i++)
                if(s.equalsIgnoreCase(as[i]))
                    return i;

            return -1;
        } else
        {
            return -1;
        }
    }

    public static String getJsAlertString(String s)
    {
        if(s == null)
            s = "";
        s = s.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\n", "\\\\n").replaceAll("\\r", "\\\\r").replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"");
        return s;
    }

    public static String MnemonicWords(String s)
        throws Exception
    {
        String s1 = "";
        try
        {
            for(int i = 0; i < s.length(); i++)
            {
                String s2 = s.substring(i, i + 1);
                byte abyte0[] = s2.getBytes("gbk");
                if(abyte0.length == 1)
                {
                    s1 = s1 + s.substring(i, i + 1).toUpperCase();
                } else
                {
                    int j = (256 + abyte0[0]) - 160;
                    int k = (256 + abyte0[1]) - 160;
                    int l = j * 100 + k;
                    if(l > 1600 && l < 5590)
                    {
                        for(int i1 = 22; i1 >= 0; i1--)
                        {
                            if(l < SEC_POS_VALUE[i1])
                                continue;
                            s1 = s1 + FIRST_LETTER[i1];
                            break;
                        }

                    } else
                    {
                        int j1 = ((j - 56) * 94 + k) - 1;
                        if(j1 >= 0 && j1 <= 3007)
                            s1 = s1 + SECOND_SEC_TABLE.substring(j1, j1 + 1);
                        else
                            s1 = s1 + s.charAt(i);
                    }
                }
            }

        }
        catch(Exception exception)
        {
            bL.error("\u53D6\u6C49\u5B57\u62FC\u97F3\u7801\u9519\u8BEF\uFF01", exception);
            exception.printStackTrace();
        }
        return s1.toLowerCase();
    }

    public static synchronized String regexReplace(String s, String s1, String s2)
    {
        Pattern pattern = a(s);
        Matcher matcher = pattern.matcher(s2);
        StringBuffer stringbuffer = new StringBuffer();
        for(; matcher.find(); matcher.appendReplacement(stringbuffer, s1));
        matcher.appendTail(stringbuffer);
        return stringbuffer.toString();
    }

    public static String replace(String s, String s1, String s2)
    {
        if(s == null)
            return null;
        if(s1 == null || s1.equals(""))
            return s;
        if(s2 == null)
            return s;
        int i = s1.length();
        int j;
        for(; s.indexOf(s1) != -1; s = s.substring(0, j) + s2 + s.substring(j + i))
            j = s.indexOf(s1);

        return s;
    }

    public static String showNull2Empty(Object obj)
    {
        if(obj == null || "null".equals(obj))
            return "";
        else
            return String.valueOf((obj));
    }

    public static String decimalToPercent(String s) throws Exception
    {
        if(s != null && !"".equals(s) && !s.endsWith("%"))
            if(s.split("\\.").length == 2)
            {
                String s1 = "true";
                s = s.replaceFirst("\\.", "");
                if(s.length() < 3)
                {
                    if(s.startsWith("0"))
                    {
                        if("0".equals(s.substring(1, 2)))
                            s = "0%";
                        else
                            s = s.substring(1, 2) + "0%";
                    } else
                    {
                        s = s + "0%";
                    }
                } else
                if(s.length() == 3)
                {
                    if(s.startsWith("0"))
                    {
                        if("0".equals(s.substring(1, 2)))
                            s = s.substring(2, 3) + "%";
                        else
                            s = s.substring(1, 3) + "%";
                    } else
                    {
                        s = s + "%";
                    }
                } else
                if(s.length() > 3)
                    if(s.startsWith("0"))
                    {
                        for(int i = 0; i < s.length(); i++)
                        {
                            if("0".equals(s.subSequence(i, i + 1)))
                                continue;
                            if(i > 3)
                                s = "0." + s.substring(3, s.length()) + "%";
                            else
                            if(i == 1)
                                s = s.substring(i, i + 2) + "." + s.substring(i + 1, s.length()) + "%";
                            else
                            if(i == 2)
                                s = s.substring(i, i + 1) + "." + s.substring(i + 1, s.length()) + "%";
                            s1 = "false";
                            break;
                        }

                        if("true".equals(s1))
                            s = "0%";
                    } else
                    {
                        s = s.substring(0, 3) + "." + s.substring(3, s.length()) + "%";
                    }
            } else
            if(s.split("\\.").length == 1)
            {
                if(s.startsWith("0"))
                    throw new Exception("\u8F93\u5165\u6709\u8BEF\uFF0C\u8BF7\u91CD\u65B0\u8F93\u5165");
                s = s + "00%";
            } else
            {
                throw new Exception("\u8F93\u5165\u6709\u8BEF\uFF0C\u8BF7\u91CD\u65B0\u8F93\u5165");
            }
        return s;
    }

    /**
	 * cpObj的中文名称：比较两个对象是否相同
	 * 
	 * cpObj的概要说明：两个对象相同返回true
	 * 
	 * @param first的中文名称
	 *            ：比较对象1
	 * @return last的中文名称：比较对象2
	 */
	public static boolean cpObj(final Object first, final Object last) {
		boolean flag = true;

		if (first == null) {
			// first无值,last有值，则改变flag = false
			if (last != null && !"".equals(last)) {
				flag = false;
			}
		} else {
			// first 有值，last无值,改变flag = false
			if (last == null) {
				flag = false;
			} else {
				// first 有值，last有值,两值不相等，改变flag = false
				if (!first.equals(last)) {
					flag = false;
				}
			}
		}
		return flag;
	}
	
	/**
	 * 格式化字符串
	 * 
	 * 例：formateString("xxx{0}bbb",1) = xxx1bbb
	 * 
	 * @param str
	 * @param params
	 * @return
	 */
	public static String formateString(String str, String... params) {
		for (int i = 0; i < params.length; i++) {
			str = str.replace("{" + i + "}", params[i] == null ? "" : params[i]);
		}
		return str;
	}
	
    protected StringHelper()
    {
    }

    private static final Logger bL;
    static Pattern collectionPattern = null;
    static final int SEC_POS_VALUE[] = {
        1601, 1637, 1833, 2078, 2274, 2302, 2433, 2594, 2787, 3106, 
        3212, 3472, 3635, 3722, 3730, 3858, 4027, 4086, 4390, 4558, 
        4684, 4925, 5249
    };
    static final String FIRST_LETTER[] = {
        "A", "B", "C", "D", "E", "F", "G", "H", "J", "K", 
        "L", "M", "N", "O", "P", "Q", "R", "S", "T", "W", 
        "X", "Y", "Z"
    };
    static final String SECOND_SEC_TABLE = (new StringBuffer(4096)).append("CJWGNSPGCGNE[Y[BTYYZDXYKYGT[JNNJQMBSGZSCYJSYY[PG").append("KBZGY[YWJKGKLJYWKPJQHY[W[DZLSGMRYPYWWCCKZNKYYGTT").append("NJJNYKKZYTCJNMCYLQLYPYQFQRPZSLWBTGKJFYXJWZLTBNCX").append("JJJJTXDTTSQZYCDXXHGCK[PHFFSS[YBGXLPPBYLL[HLXS[ZM").append("[JHSOJNGHDZQYKLGJHSGQZHXQGKEZZWYSCSCJXYEYXADZPMD").append("SSMZJZQJYZC[J[WQJBYZPXGZNZCPWHKXHQKMWFBPBYDTJZZK").append("QHYLYGXFPTYJYYZPSZLFCHMQSHGMXXSXJ[[DCSBBQBEFSJYH").append("XWGZKPYLQBGLDLCCTNMAYDDKSSNGYCSGXLYZAYBNPTSDKDYLH").append("GYMYLCXPY[JNDQJWXQXFYYFJLEJPZRXCCQWQQSBNKYMGPLBMJ").append("RQCFLNYMYQMSQYRBCJTHZTQFRXQHXMJJCJLXQGJMSHZKBSWYE").append("MYLTXFSYDSWLYCJQXSJNQBSCTYHBFTDCYZDJWYGHQFRXWCKQK").append("XEBPTLPXJZSRMEBWHJLBJSLYYSMDXLCLQKXLHXJRZJMFQHXHW").append("YWSBHTRXXGLHQHFNM[YKLDYXZPYLGG[MTCFPAJJZYLJTYANJG").append("BJPLQGDZYQYAXBKYSECJSZNSLYZHSXLZCGHPXZHZNYTDSBCJK").append("DLZAYFMYDLEBBGQYZKXGLDNDNYSKJSHDLYXBCGHXYPKDJMMZN").append("GMMCLGWZSZXZJFZNMLZZTHCSYDBDLLSCDDNLKJYKJSYCJLKWH").append("QASDKNHCSGANHDAASHTCPLCPQYBSDMPJLPZJOQLCDHJJYSPRC").append("HN[NNLHLYYQYHWZPTCZGWWMZFFJQQQQYXACLBHKDJXDGMMYDJ").append("XZLLSYGXGKJRYWZWYCLZMSSJZLDBYD[FCXYHLXCHYZJQ[[QAG").append("MNYXPFRKSSBJLYXYSYGLNSCMHZWWMNZJJLXXHCHSY[[TTXRYC").append("YXBYHCSMXJSZNPWGPXXTAYBGAJCXLY[DCCWZOCWKCCSBNHCPD").append("YZNFCYYTYCKXKYBSQKKYTQQXFCWCHCYKELZQBSQYJQCCLMTHS").append("YWHMKTLKJLYCXWHEQQHTQH[PQ[QSCFYMNDMGBWHWLGSLLYSDL").append("MLXPTHMJHWLJZYHZJXHTXJLHXRSWLWZJCBXMHZQXSDZPMGFCS").append("GLSXYMJSHXPJXWMYQKSMYPLRTHBXFTPMHYXLCHLHLZYLXGSSS").append("STCLSLDCLRPBHZHXYYFHB[GDMYCNQQWLQHJJ[YWJZYEJJDHPB").append("LQXTQKWHLCHQXAGTLXLJXMSL[HTZKZJECXJCJNMFBY[SFYWYB").append("JZGNYSDZSQYRSLJPCLPWXSDWEJBJCBCNAYTWGMPAPCLYQPCLZ").append("XSBNMSGGFNZJJBZSFZYNDXHPLQKZCZWALSBCCJX[YZGWKYPSG").append("XFZFCDKHJGXDLQFSGDSLQWZKXTMHSBGZMJZRGLYJBPMLMSXLZ").append("JQQHZYJCZYDJWBMYKLDDPMJEGXYHYLXHLQYQHKYCWCJMYYXNA").append("TJHYCCXZPCQLBZWWYTWBQCMLPMYRJCCCXFPZNZZLJPLXXYZTZ").append("LGDLDCKLYRZZGQTGJHHGJLJAXFGFJZSLCFDQZLCLGJDJCSNZL").append("LJPJQDCCLCJXMYZFTSXGCGSBRZXJQQCTZHGYQTJQQLZXJYLYL").append("BCYAMCSTYLPDJBYREGKLZYZHLYSZQLZNWCZCLLWJQJJJKDGJZ").append("OLBBZPPGLGHTGZXYGHZMYCNQSYCYHBHGXKAMTXYXNBSKYZZGJ").append("ZLQJDFCJXDYGJQJJPMGWGJJJPKQSBGBMMCJSSCLPQPDXCDYYK").append("Y[CJDDYYGYWRHJRTGZNYQLDKLJSZZGZQZJGDYKSHPZMTLCPWN").append("JAFYZDJCNMWESCYGLBTZCGMSSLLYXQSXSBSJSBBSGGHFJLYPM").append("ZJNLYYWDQSHZXTYYWHMZYHYWDBXBTLMSYYYFSXJC[DXXLHJHF").append("[SXZQHFZMZCZTQCXZXRTTDJHNNYZQQMNQDMMG[YDXMJGDHCDY").append("ZBFFALLZTDLTFXMXQZDNGWQDBDCZJDXBZGSQQDDJCMBKZFFXM").append("KDMDSYYSZCMLJDSYNSBRSKMKMPCKLGDBQTFZSWTFGGLYPLLJZ").append("HGJ[GYPZLTCSMCNBTJBQFKTHBYZGKPBBYMTDSSXTBNPDKLEYC").append("JNYDDYKZDDHQHSDZSCTARLLTKZLGECLLKJLQJAQNBDKKGHPJT").append("ZQKSECSHALQFMMGJNLYJBBTMLYZXDCJPLDLPCQDHZYCBZSCZB").append("ZMSLJFLKRZJSNFRGJHXPDHYJYBZGDLQCSEZGXLBLGYXTWMABC").append("HECMWYJYZLLJJYHLG[DJLSLYGKDZPZXJYYZLWCXSZFGWYYDLY").append("HCLJSCMBJHBLYZLYCBLYDPDQYSXQZBYTDKYXJY[CNRJMPDJGK").append("LCLJBCTBJDDBBLBLCZQRPPXJCJLZCSHLTOLJNMDDDLNGKAQHQ").append("HJGYKHEZNMSHRP[QQJCHGMFPRXHJGDYCHGHLYRZQLCYQJNZSQ").append("TKQJYMSZSWLCFQQQXYFGGYPTQWLMCRNFKKFSYYLQBMQAMMMYX").append("CTPSHCPTXXZZSMPHPSHMCLMLDQFYQXSZYYDYJZZHQPDSZGLST").append("JBCKBXYQZJSGPSXQZQZRQTBDKYXZKHHGFLBCSMDLDGDZDBLZY").append("YCXNNCSYBZBFGLZZXSWMSCCMQNJQSBDQSJTXXMBLTXZCLZSHZ").append("CXRQJGJYLXZFJPHYMZQQYDFQJJLZZNZJCDGZYGCTXMZYSCTLK").append("PHTXHTLBJXJLXSCDQXCBBTJFQZFSLTJBTKQBXXJJLJCHCZDBZ").append("JDCZJDCPRNPQCJPFCZLCLZXZDMXMPHJSGZGSZZQLYLWTJPFSY").append("ASMCJBTZKYCWMYTCSJJLJCQLWZMALBXYFBPNLSFHTGJWEJJXX").append("GLLJSTGSHJQLZFKCGNNNSZFDEQFHBSAQTGYLBXMMYGSZLDYDQ").append("MJJRGBJTKGDHGKBLQKBDMBYLXWCXYTTYBKMRTJZXQJBHLMHMJ").append("JZMQASLDCYXYQDLQCAFYWYXQHZ").toString();

    static 
    {
        bL = Logger.getLogger(StringHelper.class);
        collectionPattern = Pattern.compile("[a-z]{3}[0-9]{2}[0-9a-z]");
    }
    
    
    //---------start---------------------------------
    //集成进来com.lbs.leaf.util.a.b
    public static Pattern a(String s)
    {
        Pattern pattern = null;
        if(a.containsKey(s))
        {
            pattern = (Pattern)a.get(s);
        } else
        {
            pattern = Pattern.compile(s);
            a.put(s, pattern);
        }
        return pattern;
    }
    static Map a = new FastHashMap();
    //----------end---------------------------------


    /**
     * 首字母大写
     *
     * @param srcStr
     * @return
     */
    public static String firstCharacterToUpper(String srcStr) {
        return srcStr.substring(0, 1).toUpperCase() + srcStr.substring(1);
    }

    /**
     * 替换字符串并让它的下一个字母为大写
     * @param srcStr
     * @param org
     * @param ob
     * @return
     */
    public static String replaceUnderlineAndfirstToUpper(String srcStr,String org,String ob)
    {
        String newString = "";
        int first=0;
        while(srcStr.indexOf(org)!=-1)
        {
            first=srcStr.indexOf(org);
            if(first!=srcStr.length())
            {
                newString=newString+srcStr.substring(0,first)+ob;
                srcStr=srcStr.substring(first+org.length(),srcStr.length());
                srcStr=firstCharacterToUpper(srcStr);
            }
        }
        newString=newString+srcStr;
        return newString;
    }


    /**
     * 替换字符串并让它的下一个字母为大写
     * @param srcStr
     * @param org
     * @return
     */
    public static String replaceUnderlineAndfirstToUpper(String srcStr,String org)
    {
        return replaceUnderlineAndfirstToUpper(srcStr,org,"");
    }


    /**
     * 测试
     */
    public static void main(String[] args) throws Exception {
    	//
    	System.out.println("fillZero('a',5)="+fillZero("a",5));
    	System.out.println("followZero('a',5)="+followZero("a",5));
    	System.out.println("genUUID="+genUUID());
    	String[] a=org.nutz.lang.Strings.splitIgnoreBlank("select * from mm aa where a=bL", " ");
    	System.out.println("decimalToPercent('0.0123')="+decimalToPercent("0.0123"));
    }
    
    public static String myMakeStrLen2(String v_src,int v_len){
    	String v_srcyuan=dowithNullPrint(v_src);
    	String v_srcdes=v_srcyuan;
    	String v_kong="";
    	if (v_src!=null && !"".equals(v_src)){
        	int v_srclen=getWordCount(v_srcyuan); 
        	if (v_len>v_srclen){
        		for (int i=0;i<v_len-v_srclen;i++){
        			v_kong+="_";
        			//v_kong+="a";
        		}
        	}    		
    	}else{
    		for (int i=0;i<v_len;i++){
    			v_kong+="_";
    			//v_kong+="a";
    		}    		
    	};

    	return v_kong;
    }	
    
    public static String myMakeStrLen(String v_src,int v_len,int v_leftOrRight){
    	String v_srcyuan=dowithNullPrint(v_src);
    	String v_srcdes=v_srcyuan;
    	String v_kong="";
    	if (v_src!=null && !"".equals(v_src)){
        	int v_srclen=getWordCount(v_srcyuan); 
        	if (v_len>v_srclen){
        		for (int i=0;i<v_len-v_srclen;i++){
        			v_kong+="&nbsp;&nbsp;";
        			//v_kong+="a";
        		}
        	}    		
    	}else{
    		for (int i=0;i<v_len;i++){
    			v_kong+="&nbsp;&nbsp;";
    			//v_kong+="a";
    		}    		
    	};
    	
    	if (v_leftOrRight==0){//右
    		v_srcdes+=v_kong;
    	}else{
    		v_srcdes=v_kong+v_srcdes;
    	}
    	return v_srcdes;
    }	
    
	public static String dowithNullPrint(Object obj) {
		return (obj == null || "0".equals((obj+""))) ? "" : obj.toString().trim();
	}
	
	   public static int getWordCount(String s)  
	    {  
	        int length = 0;  
	        for(int i = 0; i < s.length(); i++)  
	        {  
	            int ascii = Character.codePointAt(s, i);  
	            if(ascii >= 0 && ascii <=255)  
	                length++;  
	            else  
	                length += 2;  
	                  
	        }  
	        return length;  
	          
	    }	
	   
	   public static boolean strisnull(String s)  
	    {  
            boolean v_b=false;
	  		if (s==null || "".equals(s) || "null".equalsIgnoreCase(s) || "undefined".equals(s)){
	  			v_b=true;
			}	
	  		return v_b;
	    }	
	   
		public static String dowithNull(Object obj){
			return null==obj?"":obj.toString();
		}   
        
		//encodeURI(encodeURI(basePath + '/pcompany/savePcompanydr?succJsonStr=' + succJsonStr)),
		public static String myDecodeURI(Object obj) throws UnsupportedEncodingException{
			String v_ret=dowithNull(obj);
			v_ret=java.net.URLDecoder.decode(v_ret, "UTF-8");
			return v_ret;
		}	
		
		public static String strIfNull(String prm_str,String prm_ifnulldefault){
			return StringUtils.isEmpty(prm_str)?prm_ifnulldefault:prm_str;
		} 
		
		public static BigDecimal NullToZero(BigDecimal prm_a){
			return (prm_a==null)?new BigDecimal("0"):prm_a;
		}   		
		     
	    public static String filterStringHTML(String param, int length, String endWith) {    
	        if(length<1) {System.out.println("length must >0");return null;}    
	        if(param.length()<length){return param;}    
	        StringBuffer result = new StringBuffer();    
	        StringBuffer str = new StringBuffer();    
	        int n = 0;    
	        char temp;    
	        boolean isCode = false; // 是不是HTML代码    
	        boolean isHTML = false; // 是不是HTML特殊字符,如    
	        for (int i = 0; i < param.length(); i++) {    
	            temp = param.charAt(i); 
	            if (temp =='<') {    
	                isCode = true;    
	            }    
	            else if (temp =='&') {    
	                isHTML = true;    
	            }    
	            else if (temp =='>' && isCode) {    
	                n = n - 1;    
	                isCode = false;    
	            }    
	            else if (temp ==';' && isHTML) {    
	                isHTML = false;    
	            }    
	            if (!isCode && !isHTML) {    
	                n = n + 1;    
	                // UNICODE码字符占两个字节    
	                if ((temp + "").getBytes().length > 1) {    
	                    n = n + 1;    
	                }    
	                str.append(temp);    
	            }    
	            result.append(temp);    
	            if (n >= length) {    
	                break;    
	            }    
	        }    
	        result.append(endWith);    
	        // 取出截取字符串中的HTML标记    
	        String temp_result = result.toString().replaceAll("(>)[^<>]*(<?)","$1$2");    
	   
	        // 去掉不需要结束标记的HTML标记    
	        temp_result = temp_result    
	                .replaceAll("<(AREA|BASE|BASEFONT|BODY|BR|COL|COLGROUP|DD|DT|FRAME|HEAD|HR|HTML|IMG|INPUT|ISINDEX|LI|LINK|META|OPTION|P|PARAM|TBODY|TD|TFOOT|TH|THEAD|TR|area|base|basefont|body|br|col|colgroup|dd|dt|frame|head|hr|html|img|input|isindex|li|link|meta|option|p|param|tbody|td|tfoot|th|thead|tr)[^<>]*/>","");    
	   
	        // 去掉成对的HTML标记    
	        // temp_result=temp_result.replaceAll("<([a-zA-Z]+)[^<>]*>(.*?)</\\1>","$2");    
	        htmlMatch = temp_result;    
	        temp_result = removeMatchHtmlTag();    
	        //System.out.println("6666:" + temp_result);    
	        // 用正则表达式取出标记    
	   
	        Pattern p = Pattern.compile("<([a-zA-Z]+)[^<>]*>");    
	        Matcher m = p.matcher(temp_result);    
	        List endHTML = new ArrayList();    
	   
	        while (m.find()) {    
	            endHTML.add(m.group(1));    
	        }    
	   
	        // 补全不成对的HTML标记    
	        for (int i = endHTML.size() - 1; i >= 0; i--) {    
	            result.append("</");    
	            result.append(endHTML.get(i));    
	            result.append(">");    
	   
	        }    
	        return result.toString();    
	   
	    }
	    
		 // 通过递归删除html文件中的配对的html标签    
	    public static String removeMatchHtmlTag() {    
	        // String html="<p></p><table><tr><td></td><td></td></tr></table>";    
	        Pattern p = Pattern.compile("<([a-zA-Z]+)[^<>]*>(.*?)</\\1>");    
	        Matcher m = p.matcher(htmlMatch);    
	        if (m.find()) {    
	        //  System.out.println(htmlMatch);    
	            htmlMatch = htmlMatch.replaceAll("<([a-zA-Z]+)[^<>]*>(.*?)</\\1>","$2");    
	            removeMatchHtmlTag();    
	        }    
	        return htmlMatch;    
	    } 	    
	    
}

